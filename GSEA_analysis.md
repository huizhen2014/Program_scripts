####GSEA analysis

#### [针对非模式生物][https://mp.weixin.qq.com/s/awieqE2LAk7YKZNkNQr9VQ]

- ORA:Over-Representation Analysis(ORA)

超几何分布(Classic Fisher Test)：例如在芯片中共有10000个基因，其中通路S含有200个基因(占芯片基因的2%)；同时有50个基因位于"distiguished"列表中(挑选出来的显著差异基因)，实际上通路S在本次实验中共有6个基因位于distiguished列表中。此时理论情况下50*2%=1个基因位于通路S，那么现有6个基因位于S。使用超几何分布求得该事件的p值(也就是随机情况下有6个或者6个以上的distingushed基因位于S的概率) p=0.00045

![image-20190901141320307](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cwijn8j30qj059mym.jpg)

Fisher精确检验：

![image-20190831175544831](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cmpig6j31420gedhp.jpg)

超几何分布：

![image-20190901143650175](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0csqrksj30ui0220su.jpg)

- GSEA: Gene Set Enrichment Analysis

![image-20190831183834501](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cu4zouj311w09kabu.jpg)

该分析解决了ORA分析过程中仅考虑差异大的基因，而忽略了差异较小但是一致性表达的一组相关基因的问题。该分析将所有基因均用于GSEA分析，GSEA整合gene set中每个基因的统计值，检测提前定义的gene set中所有基因发生小且一致性改变的情况。因为，可能出现许多表型差异与一组变化较小但是变化一致的基因所联系起来的情况。

![image-20190831180720128](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cxhhw1j30ze0om77y.jpg)

根据表型对基因排秩序，针对一套给定prior的gene set S(eg. genes sharing the same GO category)，GSEA分析目的在于判断S中的基因是否随机分布在排完秩序后的gene list(L)中，或主要分布在list的top或bottom。

富集值(ES)代表了一组基因S(存在于同一GO类别)位于经过排秩序后gene list(L)的top或bottom的程度(也就是在top或bottom过表达程度)。通过统计L中出现S的情况，计算得到ES值，最终通过统计换算计算相对于null distribution的ES的p-value。

![image-20190831181138788](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cyf0qxj30z00p4n1s.jpg)

- GSEA分析构建prerank gene list

~~[使用topGO针对DESeq2分析后结果做GSEA][https://www.biostars.org/p/279097/]，KS可尝试！！！~~

![image-20190831183057554](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cvzmwzj30zo09c3zu.jpg)

**[tt为exactTest检出的针对表型差异的所有基因][https://github.com/BaderLab/Cytoscape_workflows/blob/master/EnrichmentMapPipeline/supplemental_protocol1_rnaseq.Rmd]**

https://github.com/BaderLab/Cytoscape_workflows

https://baderlab.github.io/Cytoscape_workflows/EnrichmentMapPipeline/Protocol2_createEM.html

![image-20190831181733210](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cq2by4j31fg05sgmo.jpg)

[针对GSEA软件][https://www.biostars.org/p/266073/]：

![image-20190831182448697](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cnks3cj315q06ajsy.jpg)

RNA: Ranked list file format(*.rnk)

R语言构建rnk文件

![image-20190831192637748](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0co8uqpj31g50u043c.jpg)

![image-20190831204456755](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cxtywzj30s007i74u.jpg)

linux针对GO和gene关系构建gmt文件

![image-20190831204556849](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cqqnkhj31ii0u0aiw.jpg)

![image-20190831204524940](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cpl82qj30z608umyc.jpg)

#### GSEA analysis

![image-20190831204636439](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cumndqj31fi0dy0vp.jpg)

[结果解释][http://www.gsea-msigdb.org/gsea/doc/GSEAUserGuideFrame.html?_Interpreting_GSEA_Results]

- ES: Enrichment Scores

**Gene Set Enrichement Analysis的主要结果是enrichment score(ES)，该值反映了一个gene set在排秩序后的gene list中位于top或bottom中过表达的程度。**GSEA沿着排序后的gene list移动，遇到位于gene set中的gene时增加running-sum，否则减少。因此，running-sum增加的级别和基因与表型相关性有关。ES为在gene list中获得和zero最大的偏差值。正数值表示该gene set在排序后的top富集，负数值表示该gene set在排序后的bottom的富集。

![image-20190901114023337](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cruw3lj31cq0i875y.jpg)

图中第一部分展示了沿着排序后gene list移动时，ES的变化；图中第二部分展示了gene set中的gene在排序后的gene list中位置，gene set 的 leading edge subset为对ES贡献最大的gene set部分；图中第三部分展示了沿着排序后gene list移动时ranking metric 值变化情况，正数值表示和表型相关，负数值表示与表型无关或负相关。

- Normalized Enrichement Score(NES)

**NES值为解释gene set富集结果的主要统计值。通过标准化富集值，GSEA标准化gene set大小和gene sets与表达数据之间的差异，因此标准化后的富集值能用于在不同的gene set间比较:**

![image-20190901115026747](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0ctoo9bj316c030mx7.jpg)

permutation: [/'pɝmjʊ'teʃən/] (一组事物可能的一种)序列, 排列; 排列中的任一组数字或文字
NES是基于针对所有数据的排列的gene set富集值, 因此, 改变排列方式, 排列数目或表达数据大小都会影响NES值。考虑两种分析: 分析表达数据，GSEA生成了ranked list且分析ranked list；使用GSEAPreranked分析由第一种分析生成的ranked list。若使用相同的参数设置，得到富集值是一致的。然而，NES会反映不同数据用于排序的差异(the expression dataset versus the ranked list of genes)

![image-20190901115929092](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0com29uj31ee0ekdja.jpg)

- False Discovery Rate(FDR)

FDR为针对gene set在给定NES时为假阳性的可能性。例如, FDR为25%表明75%的结果是有效的。**GSEA报告最高的同时含小于25%的ES值的gene set为感兴趣结果，同时针对给gene set进行下一步分析，但是针对所有gene set都提供分析结果。**(However, if you have a small number of samples and use gene_set permutation (rather than phenotype permutation) for your analysis, you are using a less stringent assessment of significance and would then want to use a more stringent FDR cutoff, such as 5%.)

- Nominal P Value

名义上的p值评估了单个gene set富集值的显著程度。FDR值根据gene set大小和多重假设检验进行调整，而p值没有。**当一个top gene set拥有一个小的p值和高的FDR值时，则表示根据empirical null 分布，该gene set和其他gene sets相比并没有那么显著。这可能因为，没有足够的样本, biological signal 微弱，或该gene sets并不能很好的解释生物问题。另一方面，FDR是基于所有gene sets的两分布，假如许多gene sets中的一个富集，同时该gene set可能拥有很高的FDR值。最终，拥有很好名义p值和低的FDR值的top gene set一般表示阴性结果: 该gene set本身不够显著同时其他gene sets 显著性更差**。(In the "Interpreting GSEA Results" section, under "Nominal P Value", the last paragraph states: In the GSEA report, a p value of zero (0.0) indicates an actual p value of less than 1/number-of-permutations. For example, if the analysis performed 100 permutations, a reported p value of 0.0 indicates an actual p value of less than 0.01. For a more accurate p value, increase the number of permutations performed by the analysis. Typically, you will want to perform 1000 permutations (phenotype or gene_set). (If you attempt to perform significantly more than 1000 permutations, GSEA may run out of memory.) [参考文章][http://www.gsea-msigdb.org/gsea/doc/subramanian_tamayo_gsea_pnas.pdf]

![image-20190901123219000](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cscbv1j31gu07wjw3.jpg)

#### Running a Leading Edge Analysis

Leading-edge subset为位于ES值前的gene集合，leading-edge subset可解释为解释gene set富集信号的核心genes。运行完gene set enrichment analysis后，使用leading edge analysis来检测位于富集的gene sets的leading-edge subset中的genes。位于多个leading-edge subset中的gene更可能是感兴趣的gene。可选择正调控或负调控的多个gene sets(GO items)进行分析:

![image-20190901131939100](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0ctb4nbj31cw0pitdp.jpg)

[结果解释][http://www.gsea-msigdb.org/gsea/doc/GSEAUserGuideFrame.html?_Interpreting_GSEA_Results]

- Heat Map

![image-20190901132654885](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cvl49pj312s0csq46.jpg)

热图展示了位于leadng-edge subsets中的genes(clustered)。改图使用颜色(red, pink, light blue, dark blue)表示表达值(expression values)的范围(high, moderate, low, lowest)。

- Set-to-Set

![image-20190901133032213](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cwzwpxj31620cymy7.jpg)

改图使用颜色强度来表示subsets间的重叠程度。颜色越深，重叠程度越强。

- Gene in Subsets

![image-20190901133402874](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0creyo8j31840fiq4h.jpg)

改图展示了每个基因以及它所出现的subsets的数目

- Histogram

![image-20190901134058623](https://tva1.sinaimg.cn/large/006y8mN6gy1g6k0cv2ropj316q0fkwfa.jpg)

Jacquard is the intersection divided by the union for a pair of leading edge subsets。Number of Occurences is the number of leading edge subset pairs in a particular bin。略！

***

#### [fgsea][https://github.com/ctlab/fgsea]

1. 构建genes列表

基因排列: `-sign(avg_fold)*log10(pvalue)`

![image-20200220160935149](https://tva1.sinaimg.cn/large/0082zybpgy1gc2xkxlx50j312q02ygm7.jpg)

2. 构建注释文件

![image-20200220161213262](https://tva1.sinaimg.cn/large/0082zybpgy1gc2xnn2kq8j316i098772.jpg)

3. 分析

`fgseaMultilevelRes <- fgseaMultilevel(pathways=Ann_list, stats = gene_ranks, minSize=5, maxSize=500)`

`head(fgseaMultilevelRes[order(pval),])`

![image-20200220161620698](https://tva1.sinaimg.cn/large/0082zybpgy1gc2xrxknj1j317o0ei0y4.jpg)

`plotEnrichment(pathway=Ann_list[["map00364_Fluorobenzoate degradation"]], stats=gene_ranks, gseaParam = 1) + labs(title="Fluorobenzoate degradation")`

![image-20200220161556527](https://tva1.sinaimg.cn/large/0082zybpgy1gc2xrile44j318k0fiq4r.jpg)

`topPathwaysUp <- fgseaMultilevelRes[ES > 0][head(order(pval), n =10), pathway]`

`topPathwaysDown <- fgseaMultilevelRes[ES < 0][head(order(pval), n=10), pathway]`

`topPathways <- c(topPathwaysUp, rev(topPathwaysDown))`

`plotGseaTable(Ann_list[topPathways], gene_ranks, fgseaMultilevelRes, gseaParam=0.5)`

![image-20200220161912094](https://tva1.sinaimg.cn/large/0082zybpgy1gc2xuwttnaj31ce0kydn9.jpg)

collapsedPathways:

![image-20200220162754927](https://tva1.sinaimg.cn/large/0082zybpgy1gc2y3z4vtxj312m02gwey.jpg)

Fwrite:

![image-20200220162830080](https://tva1.sinaimg.cn/large/0082zybpgy1gc2y4l7an5j312i028wer.jpg)

***

#### [pathview][http://www.bioconductor.org/packages/release/bioc/html/pathview.html] : pathway based data integration and visualization

Pathview是基于数据整合和可视化的通路工具组合. 根据用户提供的基因和化合物数据比对到指定的通路上. Pathview自该动下载通路图像数据, 解析数据文件, 比对用户提供的数据. 同时提供KEGG原始的图形和Graphviz图形(keggview.native and kegg.graph are the two viewer functions, and pathview is the main function proving a unified interface to downloader, parser, mapper and viewer functions). 

#####Parameter

![image-20200224084700280](https://tva1.sinaimg.cn/large/0082zybpgy1gc779r87ouj311i08ugom.jpg)

`gene.data`: 单个样本向量或多个样本矩阵. 向量需要为数字, 同时gene IDs为其名称(基因IDs也可以是字符). gene IDs为遗传概念, 包含多重唯一比对到KEGG  gene IDs的gene/transcript/protein名称类型.

`gene.idtype`: gene.data数据ID类型

`cpd.data`: 同`gene.data`, 但是名称为可比对KEGG compound IDs的IDs名称

`cpm.idtype`: cpd.data数据ID类型

`pathway.id`: KEGG pathway ID.

`species`: 物种. kegg code/common name

`kegg.dir`: KEGG pathway data file(.xml)和image file(.png)路径

`kegg.native`: 是否提供原始KEGG图像(`.png`)/ graphvie为`.pdf`

`expand.node`: 是否将多重基因nodes扩展为单个基因node, 默认FLASE

`split.group`: 是否将多重node groups分成单个的node(each split member nodes inherits all edges from the node group).

`map.symbol`: 是否比对gene IDs到symbols来表示节点(This option is only effective for kegg.native=FALSE or same.layer=FALSE when kegg.native=TRUE)

`map.cpdname`: 是否比对compoud IDs到正式名称来表示compound节点标签, 或使用来自KGML文件(kEGG compound accessions)的图像名称(This option is only effective for kegg.native=FALSE)

`node.sum`: 当多重genes或compouds比对到一个节点时, 用于计算node summary的方法: 'sum', 'mean', 'median', 'max', max.abs', 'random'. 默认为node.sum='sum'

`sign.pos`: 控制通路签名的位置: bottomleft/bottomright/topleft/topright

`key.pos`: 控制颜色图例位置: bottomleft/bottomright/topleft/topright

  ...

##### Value

`kegg.names`: 比对到节点的标准KEGG IDs/Names. 为Entez Gene ID或KEGG Compound Accessions

`labels`: 节点标签

`all.mapped`: 所有比对到该节点的所有分子(gene or compound) IDs

`type`: 节点类型, 当前4种: 'gene', 'enzyme', 'compound', 'ortholog'

`x`: 原始KEGG通路图的x坐标

`y`: 原始KEGG通路图的y坐标

`width`: 原始KEGG通路图的node宽度

`height`: 原始KEGG通路图的node高度

`other columns`: 比对的gene/compound数据的列, 和对应样本的pseudo-color codes

#####Tutorial

`pathview`自动下载通路图像数据(pathway graph data), 解析数据文件, 在通路(pathway)上比对用户的数据, 同时提供包含比对了数据后到通路图像.

`pathview`可分为4个功能模块: the Downloader, Parser, Mapper, Viewer.  最重要的是, `pathview`比对并提交用户的数据到相关的通路图像上.

当前`pathview`仅能使用KEGG的通路数据.

`pathview`对于数据整合提供了强有力支持. 1) 包含可比对到通路的, 所有必要的生物数据类型; 2)  支持超过10中基因或蛋白ID类型, 20种化合物或代谢物ID类型; 3) 包含约4800个物种和KEGG orthology的通路; 4) 支持多种数据属性和格式, 例如, 连续/离散数据, 矩阵/向量, 单个/多个样本等.

`BiocManager::install("pathview")`

`BiocManager::install(c("Rgraphviz", "png", "KEGGgraph", "org.Hs.eg.db"))`

加载查看帮助:

`library(pathview)`

`library(help=pathview)`

一般可视化操作:

`filename <- system.file("extdata/gse16873.demo", package="pathview")`

`gse16873 <- read.delim(filename,row.names=1)`

`gse16873.d <- gse16873[,2*(1:6)] - gse16873[,2*(1:6)-1]`

`data(demo.paths)`

`i <- 1`

`pv.out <- pathview(gene.data = gse16873.d[,1], pathway.id = demo.paths$sel.paths[i], species = "hsa", out.suffix = "gse16873", kegg.native =TRUE)`

![image-20200224144341285](/Users/carlos/Library/Application Support/typora-user-images/image-20200224144341285.png)

根据返回结果重构`gene.data`文件, 对应提供向量名称, gene IDs:

`tmp <- head(gse16873.d[,1],92)`

`names(tmp) <- pv.out$plot.data.gene$kegg.names`  #(gene.idtype="ENTREZID")或者

`#names(tmp) <- pv.out$plot.data.gene$labels` #(gene.idtype="SYMBOL")

`pv.out <- pathview(gene.data = tmp, gene.idtype="ENTREZID", pathway.id = demo.path$sel.paths[i], species="hsa",out.suffix="gse16873",kegg.native=TRUE)`

![image-20200224165528696](https://tva1.sinaimg.cn/large/0082zybpgy1gc7ldzmar5j31610iajtx.jpg)

`str(pv.out)`

![image-20200224170133200](https://tva1.sinaimg.cn/large/0082zybpgy1gc7lkiaxe3j310s0dcn0n.jpg)

或者使用Graphviz显示de novo pathway graph, 图像拥有相同的nodes和edges, 但是使用不用的形式显示:

`pv.out <- pathview(gene.data="tmp", pathway.id=demo.paths$sel.paths[i], species="hsa", out.suffix="gse16873", kegg.native=F, sign.pos="bottomleft")`

![image-20200224170555157](https://tva1.sinaimg.cn/large/0082zybpgy1gc7low89wkj30xn0gp0v2.jpg)

可以通过设置参数`same.layer=FASLE`将图和图例显示在不同的页面, 略!

**在原始的KEGG view, 一个基因node可能代表具有相似或重复功能角色的基因/蛋白. 将其当成一个node来对待是为了更清晰地显示在图中.**

在使用Graphviz查看时, 可将node groups分为individual detached nodes; 或者将multiple-gene nodes扩展到individual genes, 这两种方式都会继承unsplit group/unexpanded nodes的edges信息.

**默认将涉及到相同反应的基因自动聚集到一起, split.group=FALSE**

`pv.out <- pathview(gene.data=tmp, pathway.id=demo.paths$sel.paths[i], species="hsa", out.suffix="ges16873.split", kegg.native=F, sign.pos="bottomleft", split.group=TURE)`

![image-20200224172326174](https://tva1.sinaimg.cn/large/0082zybpgy1gc7m70pa5dj314r0g10zh.jpg)

扩展multiple-gene nodes到individual genes

`pv.out <- pathview(gene.data=tmp, pathway.id=demo.paths$sel.paths[i], species="hsa", out.suffix="gse16873.split.expanded", kegg.native=FALSE, sign.pos ="bottomleft", split.group=TRUE, expand.nodes=TREU)`

![image-20200224173313898](https://tva1.sinaimg.cn/large/0082zybpgy1gc7mhc5ek7j312g0euaeh.jpg)

`str(pv.out)`

![image-20200224173454402](https://tva1.sinaimg.cn/large/0082zybpgy1gc7mj0nmxwj315s0cemzx.jpg)

**pathview拥有强大的数据整合能力, 可用于整合, 分析, 可视化多种生物数据: 基因表达, 蛋白表达, 遗传相关性, 代谢, 基因组数据, 文献和其他可以比对到通路的数据类型**

**化合物和基因数据**

查看代谢通路, 因此除了gene nodes外, 还有compound nodes. 因此在代谢通路中整合gene和compound数据.

![image-20200224174510060](https://tva1.sinaimg.cn/large/0082zybpgy1gc7mtnz0ufj30y801uglx.jpg)

`sim.cpd.data <- sim.mol.data(mol.type="cpd",nmol=3000)` #模拟cpd数据

`tmp <- sample(tmp,25)`

`names(tmp) <- pv.out$plot.data.gene$kegg.names`

`pv.out <- pathview(gene.data=tmp, cpd.data=sim.cpd.data, pathway.id=demo.paths$sel.paths[3], speceis="hsa", out.suffix="gse16873.cpd", keys.align="y", kegg.native=TREU, key.pos="topright")`

![image-20200224175852867](https://tva1.sinaimg.cn/large/0082zybpgy1gc7n7yhvzyj310c0efjtm.jpg)

`str(pv.out)`

![image-20200224180045214](https://tva1.sinaimg.cn/large/0082zybpgy1gc7n9xr88uj31eu0m2dl7.jpg)

使用Graphviz查看, `cpd.lab.offset` 指定高过默认compoud labels的程度

`pv.out <- pathview(gene.data=tmp, cpd.data=sim.cpd.data, pathway.id=demo.paths$sel.paths[3], speceis="hsa", out.suffix="gse16873.cpd", keys.align="y", kegg.native=FALSE, key.pos="topright", cpd.lab.offset="-1")`

![image-20200224180555554](https://tva1.sinaimg.cn/large/0082zybpgy1gc7nfg29f3j30xn0eata2.jpg)

**多重条件或样本**





































