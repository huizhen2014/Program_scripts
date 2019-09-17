Gene Ontology可分为分子功能(Molecular Function), 生物过程(Biological Process)和细胞组成(Cellular Component)三部分。蛋白质或基因可以通过ID对应或者序列注释的方法找到与之对应的GO号，而GO号可对于到Term，即功能类别或着细胞定位。

GO的一个主要用途就是针对一组gene进行富集分析。给定的一组在特定条件下高表达的gene，使用gene的注释信息，富集分析可以发现哪个GO terms为高表达的。

给定注释信息，我们可以将gene分为属于此类和非此类两组，就可以得到一个2x2的列联表做独立性分析，针对列联表就可以采用卡方检测和fisher‘s exact test，卡方检验只是近似估计值，特别是当sample size活expected all count比较小时，计算不够准确。fisher‘s exact test，使用超几何分布计算p值，比较准确。

例如共M个gene，其中N个属于该分类，那么抽取n个gene(来自同一个样本挑选出来用于富集分析的gene)，求其中有k个gene属于该分类的p值。

![image-20190604161233580](http://ww2.sinaimg.cn/large/006tNc79gy1g3p6xksu95j30es03cdfy.jpg)

针对该2x2表做独立性分析，卡方检验：

![image-20190604160040714](http://ww1.sinaimg.cn/large/006tNc79gy1g3p6l7hn2nj30tc05m74q.jpg)

无放回抽样检测符合超几何分布，fisher's exact test就是使用超几何分布计算p值:

![image-20190604160017773](http://ww4.sinaimg.cn/large/006tNc79gy1g3p6ktur57j30pg0aat9n.jpg)

超几何检测，phyper(k-1,M,N-M,n,lower.tail=F)，p值：

![image-20190604160130961](http://ww3.sinaimg.cn/large/006tNc79gy1g3p6m3dujjj30oy01qjrh.jpg)

摘抄：https://guangchuangyu.github.io/cn/2012/04/enrichment-analysis/

***

#### Loading genes and annotations data

`library(topGO)`

`library(ALL)`

`data(ALL)`

topGO package同时创建三个环境：GOBPTerm, GOMFTerm和GOCCTerm，对应为BP/MT/CC的所有GO terms。

`BPterms <- ls(GOBPTerm)`

一般而言，需要过滤掉低表达或者样本间变异很小的探针信息，采用genefilter package，genefilter函数处理。

`library(genefilter)`

`selProbes <- genefilter(ALL, filterfun(pOverA(0.1,log2(100)), function(x)(IQR(x)>0.25)))`

A filter function to filter according to the proportion of elements larger than A:pOverA(p=0.05, A=100, na.rm=TRUE)

`eset <- ALL[selProbes, ]`

**来自array或研究的所有gene为gene universe，当可得到gene-wise scores时，interesting genes为具有显著score的一组gene；或者直接定义一组gene为intereseting gene。**

topGO进行富集分析的核心步骤就是创建topGOdata对象，该对象包含了用于GO分析的所有信息：gene universe, interesting gene, gene score(if available), GO ontology(GO graph)。

* 一组gene id及可选的gene-wise score。score可用于差异表达的t-test检验，表型的相关性…
* gene id和GO term之间的对应关系，一般可直接从bioconductor或microarray获得
* GO的分级结构，来自GO.db package

**定制化注释信息也可用于构建topGOdata对象，注释信息需要以gene-to-GO或GO-to-gene的形式提供。**

`geneID2GO <- readMapings(file=system.file("examples/geneid2go.map", package="topGO"))`

![image-20190604170253604](http://ww4.sinaimg.cn/large/006tNc79gy1g3p8dxv31mj30vs06u0u0.jpg)

同时可以自定义文本来构建geneID2GO文件或GO2geneID文件供readMappings函数读取

`gene_ID<TAB>GO_ID1, GO_ID2, GO_ID3, …`

gene-to-GO和GO-to-gene之间关系互转

`GO2geneID <- inverseList(geneID2GO)`

![image-20190604170751316](http://ww3.sinaimg.cn/large/006tNc79gy1g3p8j4bhakj30s006w758.jpg)

* **定义一套interesting genes用于GO terms富集分析，仅需输入一组感兴趣的gene即可，这时就可以根据gene count计算统计显著性，例如fisher‘s exact test，Z scores， RNA-seq首选**

`geneNames <- names(geneID2GO)`

![image-20190604171142618](http://ww4.sinaimg.cn/large/006tNc79gy1g3p8n4gji5j30r602wt8y.jpg)

随机挑选10%的gene universe作为interesting genes

` myInterestingGenes <- sample(geneNames, length(geneNames)/10)`

`geneList <- factor(as.integer(geneNames %in% myInterestingGenes))`

`names(geneList) <- geneNames`

![image-20190604182619852](http://ww4.sinaimg.cn/large/006tNc79gy1g3pasrbab0j30uk03cjrp.jpg)

geneList对象用于命名因子指定哪些gene是interesting，哪些gene不是

`GOdata <- new("topGOdata", ontology="MF", allGenes=geneList, annot=annFun.gene2GO, gene2GO=geneID2GO, nodeSize=5)`

![image-20190604183341397](http://ww1.sinaimg.cn/large/006tNc79gy1g3pb0fqo7ej30yc0383yz.jpg)

可见new "topGodata"拥有这些slots可以存储信息

feasible genes是由microarray来定义的

![image-20190604185027787](http://ww4.sinaimg.cn/large/006tNc79gy1g3pbhw2khkj31060js76d.jpg)

* **大多数情况下，可以根据gene的score来计算interesting gene，例如根据差异表达基因的p-value。此时，topGOdata对象能够存储gene score，并根据规则来指定interesting gene。这样，就可以在不修改输入数据的情况下选择不同的统计方法进行GO分析。**

例如，discriminate between ALL cells delivered from either B-cell or T-cell precursors.

`y <- as.integer(sapply(eset$BT, function(x)return(substr(x,1,1) == "T")))`

![image-20190604200158459](http://ww3.sinaimg.cn/large/006tNc79gy1g3pdka85j3j30ig03e74a.jpg)

`geneList <- getPvalues(exprs(eset), classlabel=y, alternative="greater")`

getPvalues,针对gene表达矩阵计算gene的adjusted-p值
`getPvalues(edata, classlabel, test = "t", alternative = c("greater", "two.sided", "less”)[1],genesID = NULL, correction = c("none", "Bonferroni", "Holm", "Hochberg", "SidakSS", "SidakSD” ,”BH", "BY")[8])`

`topDiffGenes <- function(allScores){return(allScore < 0.01)}`

`x <- topDiffGenes(geneList)`

![image-20190604201019894](http://ww2.sinaimg.cn/large/006tNc79gy1g3pdszmwu0j30es024glj.jpg)

选择p-adjusted<0.01的gene

根据以上信息创建topGOdata

`GOdata <- new("topGOdata", description="GO analysis of ALL data: B-cell vs T-cell", ontology="BP", allGenes=geneList, geneSelectionFun= topDiffGenes, annot=annFUN.db, nodeSize=5, affyLib=affyLib)`

过滤掉少于5个annotated gene的GO term，一般设置5-10个会带来较稳定的结果，默认为1，意味着不删除任何GO term。

理想状态下，只有噪音探针，低表达探针和样本间小变异探针才会从分析中过滤出去。探针的数目对多重检验adjustment of p-values具有直接影响，太多的探针将会导致过于保守的adjsuted-p values，会导致Fisher's exact test结果偏差。

`allProb <- featureNames(ALL)`

`groupProb <- integer(length(allProb))+1`

`groupProb[allProb %in% genes(GOdata)] <- 0`，去除GOdata中没有的genes，probes

`groupProb[!selProbes] <- 2`

`groupProb <- factor(groupProb, labels=c("Used", "Not annotated", "Filtered"))`

![image-20190604203020693](http://ww2.sinaimg.cn/large/006tNc79gy1g3pekhghw4j30ns03qaa3.jpg)

在当前可行的probes执行差异表达分析，检测差异表达的genes是被富集分析排除在外

`pValue <- getPvalues(exprs(ALL), classlabel=y,alternative="greater")`

`geneVar <- apply(expres(ALL), 1, var)`

`dd <- data.frame(x=geneVar[allProb], y= log10(pValue[allProb]), groups=groupProb)`

`library(lattice)`

`xyplot(y~x|groups, data=dd, groups=groups)`

exprs获得ALL的表达矩阵信息(12625行，128列)，getPvalues函数根据表达矩阵，计算p-values，classlabel指定数据的表型，默认test为t检验，correction默认为'BH'

![image-20190604205339509](http://ww4.sinaimg.cn/large/006tNc79gy1g3pf6i5gi1j30ze0cc426.jpg)

没做过microarrary分析，具体不太清楚

![image-20190604205818219](http://ww3.sinaimg.cn/large/006tNc79gy1g3pf6wf37oj31340o8q5w.jpg)

针对topGOdata对象，获得相关信息

description函数获得GOdata的描述信息

`genes(GOdata)`获得feasible gene list

查询一组gene的score

`selGenes <- sample(genes(GOdata), 10)`

`gs <- geneScore(GOdata, whichGenes=selGenes)`

![image-20190604212557482](http://ww4.sinaimg.cn/large/006tNc79gy1g3pfznycn8j30vo0awabc.jpg)

若想更新topGOdata对象，仅包含feasible ones

`.geneList <- geneScore(GOdata, use.names=T)`

![image-20190604211529670](http://ww2.sinaimg.cn/large/006tNc79gy1g3pfosnvnzj30vk0m2ack.jpg)

`GOdata <- updateGenes(GOdata, .geneList, topDiffGenes)`

topDiffGenes，指定p值小于0.01的gene；其中226个genes是不含注释信息的(共4101)

![image-20190604212128635](http://ww1.sinaimg.cn/large/006tNc79gy1g3pfv0b2q3j30ui0mcgo4.jpg)

**这样就排除了无注释信息的226个gene，就是GOdata中不包含的genes/probes**

![image-20190604212738038](http://ww3.sinaimg.cn/large/006tNc79gy1g3pg1f752qj30km05a74r.jpg)

graph可返回GOdata中的GO term(node)数据，已经这些GO term所包含的edge数目(GO term之间的连线)

获得参与GOdata graph的所有gene数目

![image-20190604213619821](http://ww1.sinaimg.cn/large/006tNc79gy1g3pgagkzcfj30uk02c0su.jpg)

usedGO(GOdata)，对应返回GO term信息，genesInTerm(GOdata,sel.terms)，根据gel.terms返回对应的genes信息

`sel.terms <- sample(usedGO(GOdata),10)`

![image-20190604214015572](http://ww4.sinaimg.cn/large/006tNc79gy1g3pgek0jr3j30v20ce0uf.jpg)

scoresInTerm函数获得对应score

![image-20190604214217446](http://ww3.sinaimg.cn/large/006tNc79gy1g3pggnzvxjj30ti0bajsq.jpg)

使用参数use.names获得gene名称

![image-20190604214254651](http://ww3.sinaimg.cn/large/006tNc79gy1g3pgharq3gj30uu09idh0.jpg)

termStat函数返回GO term的统计信息

![image-20190604215203624](http://ww3.sinaimg.cn/large/006tNc79gy1g3pgqtj3coj30lq0a6q44.jpg)

可通过其他函数一一获得对应信息

![image-20190604215353526](http://ww2.sinaimg.cn/large/006tNc79gy1g3pgsqgo46j30uo09yta0.jpg)

Excepted是什么？？？

若直接定义一组基因为interesting gene时，对应的geneScore(GOdata)为2，未选中基因为1(`geneList <- factor(as.integer(geneNames %in% myInterestingGenes))`)

![image-20190916131706363](https://tva1.sinaimg.cn/large/006y8mN6gy1g71ab21dg4j315u07i402.jpg)

#### Running the enrichment tests

topGO package提供了多种统计检验和多种统计算法用于富集分析

* 基于gene counts，为最流行的统计家族，此时近需要输入一组感兴趣个体，无需其他信息，可采用Fisher's exact test，hypegeometric test和binomial test
* 基于gene scores或gene ranks，包含Kolmogorov-Smirnov like tests(又称为GSEA)，Gentleman's Category, t-test等
* 基于gene的expression，例如Goeman's global test或GlobalAncova, 直接作用于expression matrix

统计检验分类结构

![image-20190604220222359](http://ww2.sinaimg.cn/large/006tNc79gy1g3ph1jzbf6j31190u0qb9.jpg)

**主要用于运行GO富集分析的函数为getSigGroups，该函数需要两个参数，一个为topGOdata对象，一个为groupStats class**

* The groupStats classes，包含a gene set，指明如何进行统计检验

例如使用Fisher's exact test计算GO:0044255的富集过程，首先定义gene universe，同时获得GO:0044255所包含的genes，定义一组significant genes

`goID <- "GO:0044255"`

`gene.universe <- genes(GOdata)`

`go.genes <- genesInTerm(GOdata, goID)[[1]]`

`sig.genes <- sigGenes(GOdata)`

然后创建classicCount，就是一个2x2的列联表

`my.group <- new("classicCout", testStatistic=GOFisherTest, name="fisher",allMembers=gene.universe, groupMemebers=go.genes,sigMembers=sig.genes)`

![image-20190604221749183](http://ww1.sinaimg.cn/large/006tNc79gy1g3phhmosfqj30yi02ajro.jpg)

**contTable仅定义了根据gene count的分类，并用于根据对象构建的二维列联表**

![image-20190604221846308](http://ww2.sinaimg.cn/large/006tNc79gy1g3phim5uhtj30ig03a74g.jpg)

理解为抽样336个，其中有35个为anno

![image-20190604222433918](http://ww2.sinaimg.cn/large/006tNc79gy1g3phomxks4j30q6086aas.jpg)

**runTest根据groupStats已经定义好了统计检验方式，进行统计检验，返回值为GOFisherTest方式检出的Fisher's exact test p-value**

![image-20190604222544284](http://ww3.sinaimg.cn/large/006tNc79gy1g3phpuz12pj30j202074b.jpg)

testStatistic定义了test statistic function,包含：

GOFisherTest(object)，针对groupStats对象处理counts，基于列联表，运行Fisher's exact test，返回该检测p-value

![image-20190605110836151](http://ww4.sinaimg.cn/large/006tNc79gy1g3q3rmckq1j30gk03k3yr.jpg)

**~~GOKSTest(object)，针对groupStats对象处理scores，运行Kolmogorov-Smirnov test，返回该检验p-value~~**

GOtTest(object)，针对groupStats对象处理Socres，运行t-test，当gene scores为t-statistics或服从正态分布，返回该检验p-value

GOglobalTest, 采用Goeman's globaltest，返回该检验p-value

同样基于gene count，示例构建elimCount calss

`set.seed(123)`

`elim.genes <- sample(go.genes, length(go.genes)/4)`

`elim.group <- new("elimCount", testStatistic=GOFisherTest, name="fisher", allMembers=gene.universe, groupMembers=go.genes, sigMemebers=sig.genes, elim=elim.genes)`

![image-20190605100653608](http://ww3.sinaimg.cn/large/006tNc79gy1g3q2mlywa6j30rc0f0mye.jpg)

以上为两个groupStats class示例(my.group, elim.group)，它代表了一个gene set以及如何执行统计检验的信息！！！

* Performing the test

参数testStatistic包含了统计函数，上面例子中的GOFisherTest就采用的是Fisher's exact test。用户可以定义自己的统计函数然后应用于classic算法中，例如计算Z scores。

首先定义统计方法；然后运行统计检验，**getSigGroups，针对一个topGOdata(包含所有用于检验的数据), 以及test.stat(定义了统计检验方法)，运行统计分析**

`test.stat <- new("classicCount", testStatistic=GOFisherTest, name="Fisher test")`

`resultFisher <- getSigGroups(GOdata, test.stat)`

![image-20190605103912846](http://ww1.sinaimg.cn/large/006tNc79gy1g3q2x1bsgkj30s20biq4a.jpg)

**~~使用Kolmogorov-Smirnov test，需要提供gene-wise scoes~~**

`test.stat <- new("classicScore", testStatistic=GOKSTest, name="KS tests")`

`resultKS <- getSigGroups(GOdata, test.stat)`

![image-20190605110124929](http://ww2.sinaimg.cn/large/006tNc79gy1g3q3k5ldwcj30p6094my9.jpg)

**~~同样KS检验运行elim算法~~**

`test.stat <- new("elimScore", testStatistic=GOKSTest, name="Fisher test", cutOff=0.01)`

`resultElim <- getSigGroups(GOdata, test.stat)`

针对Fisher's exact test运行weight算法

`test.stat <- new("weightCount", testStatistic=GOFisherTest, name="Fisher test", sigRatio="ratio")`

`resultWeight <- getSigGroups(GOdata, test.stat)`

* The adjustment of p-values

getSigGroups函数返回的p-values为row p-values，这里没有多重检测矫正该值。可以自己做p-values矫正

![image-20190605123447856](http://ww4.sinaimg.cn/large/006tNc79gy1g3q69bbqlqj30oe04ojrq.jpg)

* runTest: a high-level interface of testing  推荐!!!

runTest函数仅能用于提前定义好的检验方法和算法(with a predefined set of test statistics and algorithm)，该函数有三个主要参数，topGOdata对象，algorithm，指定处理GO graph 结构的算法方式，statistic，指定统计算法

使用classic算法计算Fisher's exact test

`resultFis <- runTest(GOdata, algorithm="classic", statistic="fisher")`

多种算法可结合统计方式

![image-20190605124716837](http://ww4.sinaimg.cn/large/006tNc79gy1g3q6mamqaaj30vi0b0myz.jpg)

`weight01.fisher <- runTest(GOdata, algorithm="weight01", statistic="fisher")`

`weight01.t <- runTest(GOdata, algorithem="weight01", statistic="t")`

**~~`elim.ks <- runTest(GOdata, algorithm="elim", statistic="ks")`~~**

展示对应的算法和检验

![image-20190605125400780](http://ww2.sinaimg.cn/large/006tNc79gy1g3q6tb367ej30s405k74t.jpg)

**runTest相比于getSigGroups函数，只是更友好，使用更清晰**

####结果解释及可视化

*   The topGOresult object

getSigGroups和runTest均返回topGOresult对象

topGOresult对象结构简单，包含检验返回的p值或统计值(score)，以及test statistic和algorithm的基本信息。

score函数返回GO term的p-value，可以指定GO id，返回对应的p-values

`pvalFis <- score(resultFis)`

`hist(pvalFis, 50, xlab="p-values")`

`pvalWeight <- score(resultWeight, whichGO=names(pvalFis))`

![image-20190605142223867](http://ww3.sinaimg.cn/large/006tNc79gy1g3q9da6ty4j30rq05gq3n.jpg)

geneData函数返回topGOresult对象输入信息

![image-20190605142428475](http://ww2.sinaimg.cn/large/006tNc79gy1g3q9ffxsayj30mq03kdg1.jpg)

对应resultWeight信息

![image-20190605142900673](http://ww2.sinaimg.cn/large/006tNc79gy1g3q9k5dxahj30n605yaar.jpg)

自绘条形图，参考DESeq2，略

`colori <- c("resultFis"="khaki", "resultWeight"="powderblue")`

`h_Fis <- hist(pvalFis,plot=F)`

`h_Weight <- hist(pvalWeight, plot=F)`

`barplot(height=rbind(h_Fis$counts, h_Weight$counts), col=colori, space=0, ylab="p_value")`

`text(x=c(0, length(h_Fis$counts)), y =0, label=paste(c(0,1), adj=c(0.5,1.7), xpad=NA)`

`legend("topright", fill=rev(colori), legend=rev(names(colori)))`

* Summarising the results

GenTable函数返回topGOdata对象的表格信息

`allRes <- GenTable(GOdata, classic=resultFis,KS=resultKS,weight=resultWeight, orderBy="weight",ranksOf="classic",topNodes=20)`

orderBy表示根据weight内的p-value顺序排序，rank显示在calssic中的顺序，topNodes表示显示的GO terms数目

* Analysising individual GOs

查询感兴趣GOterm注释的gene分析，期待显著性富集GO term的注释gene具有更高的gene score相对于gene universe的平均gene score

showGroupDensity函数绘制GO term内的gene score/rank的分布，使用ranks将会取代scores，rm.one=T，移除p-value为1的gene

`goID <- allRes[1,"GO.ID"]`

`print(showGroupDensity(GOdata, goID, ranks=T))`

![image-20190605153939212](http://ww2.sinaimg.cn/large/006tNc79gy1g3qblnuucsj31540r0tbx.jpg)

对应获得该GO term的score信息，rm.one默认为T，因此去掉3个为1的gene，剩余9个点；complementary点对应为其他未注释到该GO term上的genes的p值分布

![image-20190605154030456](http://ww1.sinaimg.cn/large/006tNc79gy1g3qbmj8b40j30w009e0u0.jpg)

对应significatn genes为8，满足p-value <0.01

![image-20190605154239848](http://ww4.sinaimg.cn/large/006tNc79gy1g3qbosbp60j30wy08mwfo.jpg)

printGenes函数对应打印映射到指定GO term的gene/probe信息

`goID <- allRes[10, "GO.ID"]`

`gt <- printGenes(GOdata, whichTerm=goID, chip=affyLib, numChar=40)`

![image-20190605170636547](http://ww4.sinaimg.cn/large/006tNc79gy1g3qe44lp85j30xs09gmys.jpg)

* Visualising the GO structure

展示GO graph显著性GO term，showSigOfNodes展示subgraph，printGraph将showSigOfNodes保存本地

`showSigOfNodes(GOdata, score(resultFis), firstSigNodes=5, useInfo="all")`

`showSigOfNodes(GOdata, score(resultWeight), firstSigNodes=5, useInfo="all")`

![image-20190605171456111](http://ww2.sinaimg.cn/large/006tNc79gy1g3qecsbogkj313v0u0afy.jpg)

`printGraph(GOdata, resultFis, firstSigNodes = 5, fn.prefix = "tGO", useInfo = "all", pdfSW = TRUE)`

`printGraph(GOdata, resultWeight, firstSigNodes=5, fn.prefix="tGO", useInfo="all", pdfSW=T)`

图中significant nodes为方形，颜色表示相对显著性，由深到浅显著性下降，黑色箭头表示is-a-relationships，红色箭头表示part-of relationships

**了解不同的富集方式以及理解哪些显著性GO term是感兴趣的非常重要**

使用printGraph函数强调两种方式差异

`printGraph(GOdata, resultWeight, firstSigNodes=10, resultFis, fn.prefix="tGO", useInfo="def")`

`printGraph(GOdata, resultElim, firstSigNodes=15, resultFis, fn.prefix="tGO",useInfo="all")`

***

### 示列

* Quick start guide

1. Data preparation: gene id, gene scores, differentially expressed genes, selected genes based on their scores, gene-to-GO annotations
2. Running the enrichment tests: statistic method and algorithm
3.  Analysis of the results: summarize and visualize the results

* Data preparation

`library(toGO)`

`library(ALL)`

`data(ALL)`

`data(geneList)`

`affyLib <- paste(annotation(ALL), "db", sep=".")`

`library(package=affyLib, character.only=TRUE)`

`sum(topDiffGenes(geneList))`

topDiffGenes，选出显著性小于0.01的gene

创建topGOdata

`sampleGOdata <- new("topGOdata", description="Simple session", ontology="BP", allGenes=geneList, genesel=topDiffGenes, nodeSize=10, annot=annFUN.db, affyLib=affyLib)`

* Performing the enrichment tests

**Fisher's exact test是基于gene counts，genes分类为差异表达和非差异表达； Kolmogorov-Smirnov like test是基于gene scores(GSEA)，gene scores代表表达gene的差异程度**。runTest函数指定特殊的统计检验类型用于数据。

`resultFisher <- runTest(sampleGOdata, algorithm="classic", statistic="fisher")`

runTest返回对象topGOresult，同时使用Kolmogorov-Smirnov test检验富集

`resultKS <-  runTest(sampleGOdata, algorithm="classic",statistic="ks")`

`resultKS.elim <- runTest(sampleGOdata, algorithm="elim", statistic="ks")`

![image-20190605221439275](http://ww1.sinaimg.cn/large/006tNc79ly1g3qn0nv0d5j31120imq5h.jpg)

这里返回的p-value示未经过矫正过的多重检验值

* Analysis of results

`allRes <- GenTable(sampleGOdata, calssicFisher=resultFisher, classicKS=resultKS, elimKS=resultKS.elim, orderBy="elimKS", ranksOf="classicFisher", topNodes=10)`

![image-20190606085524522](http://ww4.sinaimg.cn/large/006tNc79gy1g3r5jcilqkj31720p2thz.jpg)

**score函数返回topGOresult对象的p-values，查看classic和elim方式返回值的差异，elim方式相对于classic方式会更保守，~~GO term根据"elimKS"返回p值排序，秩序值是该GOterm在classicFisher中排序~~**

`pValue.classic <- score(resultKS)`

`pValue.elim <- score(resultKS.elim)[names(pValue.classic)]`

`gstat <- termStat(sampleGOdata, names(pValue.classic))`

![image-20190605221815585](http://ww4.sinaimg.cn/large/006tNc79ly1g3qn4ejimaj30la070dgh.jpg)

`gSize <- gstat$Annotated/max(gstat$Annotated)*4`

`plot(pValue.classic , pValue.elim, xlab="p-value classic", ylab="p-value elim", pch=19, cex=gSize,)`

![image-20190606090109065](http://ww4.sinaimg.cn/large/006tNc79gy1g3r5pbgki2j313z0u0431.jpg)

可见elim返回的p值比classic更保守，同时也有一些GO term由classic返回相比elim保守，查看这些信息

`sel.go <-names(pValue.classic)[pValue.elim < pValue.classic]`

![image-20190606090715801](http://ww3.sinaimg.cn/large/006tNc79gy1g3r5vodrp7j31bw064wha.jpg)

可见这个4个GO terms的p-value不够显著，同时elim和classic相差无几

展示显著性nodes图

`showSigOfNodes(sampleGOdata, score(resultKS.elim), firstSigNodes=5, useInfo="all")`

![image-20190606091054298](http://ww2.sinaimg.cn/large/006tNc79gy1g3r5zgkaynj314v0u0dnz.jpg)

椭圆或者方框内信息为：第一行，GO ID；第二行，GO名称，第三行，初始p-value；第四行，该GO term显著性/总genes。颜色从深到亮黄，依次表示显著性降低。

***

#### emapper 结果GO分析（错误,目前无法找到predicted genes 对应的 EntrezID信息，同时需加载AnnotationHub对应sqlite文件注释信息）

#####使用org.EcK12.eg.db包注释

1. 从emapper的38588_prodigal_emapper_output.emapper.annotations中挑选具有GO terms的行，同时去除重复的行，获得predicted gene name 对应GO terms信息
2. R读取该信息，加载topGO和模式生物包org.EcK12.eg.db

`library(topGO)`

`library(org.Eck12.eg.db)` ##使用该org进行测试分析

`ecoli_db <- org.Eck12.eg.db`

`ecoli_allgens <- keys(ecoli_db)`

`genes_entrezid < select(ecoli_db, keys=gos, keytype="GO", columns=c("ENTREZID"))` ##gos为emapper获得的所有GO terms

构建geneList向量

`geneList <- factor(as.integer(ecoli_allgenes %in% genes_entrezid))`

`names(geneList) <- ecoli_allgenes`

构建GOdata

`sampleGOdata <- new("topGOdata",ontology="BP",allGenes=geneList,nodeSize=10,annot=annFUN.org, mapping="org.EcK12.eg.db",ID="entrez")`

![image-20190611150251876](http://ww3.sinaimg.cn/large/006tNc79gy1g3x898xhc9j30ww0k2tas.jpg)

使用classic算法计算Fisher's exact test

`resultFis <- runTest(sampleGOdata, algorithm="classic",statistic="fisher")`

![image-20190611152922506](http://ww3.sinaimg.cn/large/006tNc79gy1g3x90t6dtjj30rm09a0tq.jpg)

图示

由于数据虚假

`showGroupDensity(sampleGOdata,whichGO=goID,rm.one=F)`

![image-20190611160011421](http://ww2.sinaimg.cn/large/006tNc79gy1g3x9wuyvdoj31040u00vb.jpg)

`showSigOfNodes(sampleGOdata,score(resultFis),firstSigNodes=5,useInfo="all")`

![image-20190611160059433](http://ww2.sinaimg.cn/large/006tNc79gy1g3x9xp34wrj312k0s6q5i.jpg)

***

