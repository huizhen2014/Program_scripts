####文献背景[^Ten Years of Pathway Analysis: Current Approaches and Outstanding Challenges]
pathway analysis已经成为差异表达基因和蛋白探究潜在生物学意义的首选方式，该方法减少了复杂性的同时增加了解释能力。

在功能水平对多高通量的molecular measurements的分析具有以下作用，首先，将数千个基因，蛋白或着分子根据它们所有涉及到pathways群分，这样减少到数百个pathways能够减少分析的复杂性；其次，在不同的实验条件下识别具有差异的pathways相比简单的一列差异基因或则蛋白，更有解释意义。

pathway analysis已经应用于Gene Ontology(GO, also referred to as a 'gene' set), physical interaction networks( protein-protein interactions), kinetic simulation of pathways, steady-state pathway analysis(flux-balance analysis), and in the inference of pathways from expression and sequence data. 

这里介绍的pathway analysis具体指在当前公共的数据库的基础上例如GO, KEGG探索pathway信息。也就是，knowledge base-driven pathway analysis。

####Firste Generation: Over-Representation Analysis (ORA) Approaches

使用统计学知识评估差异表达基因中的涉及到特殊pathway的一部分基因。也值得是"2 x 2" table method。首先，对输入基因列表使用明确的阈值或标准，例如选择FDR为0.05时的过表达或低表达的基因；然后，计算差异基因所设计的pathway(例如，计算microarray上所有的基因)；最后，在输入基因列表基础上，计算每一个pathway的过表达或低表达。

最常用的统计方法为，hypergeometric，chi-square，或binomial distribution。

![image-20190514083937184](https://ws1.sinaimg.cn/large/006tNc79ly1g30jtwk39cj31i60om0zo.jpg)

具有以下局限，首先，ORA使用的不同统计方法(hypergeometic distribution, binomial distribution, chi-square distribution, etc)，都是独立的检测改变，仅仅考虑的基因的数目而没有考虑与之相关的值，例如探针的密度，因此ORA平等对待每一个基因。但是regulation的范围(fold-change, significance of a change, etc)在分配输入基因比重方面是有用的，同样还有所涉及的pathway；其次，ORA检测过程中仅仅使用了最显著的基因而忽略了其他基因，可能哪些稍微高于fold阈值或者PDR阈值的基因就会丢弃，这就可能导致信息丢失。Breitling et al. addressed this problem by proposing an ORA method for avoiding thresholds. It uses an interactive approach that adds one gene at a time to find a set of genes for which a pathway is most significant；再次，ORA假设每个基因都是独立的，平等看待每一基因，但是生物是一个复杂的设计到基因产物交互作用的过程，基因表达分析的一个目的可能就在于获得基因产物之间如何地相互作用；最后，ORA假定每个pathway都是独立存在，这也忽略了pathways之间的相互作用问题。

#### Second Generation: Functional Class Scoring(FCS) Approaches

Functional class scoring(FCS) 假设基因大的改变会对pathways产生显著效果，同时较弱且功能相关的一套基因步调一致的改变也会产生显著效果。首先，计算来molecular measurements的gene-level的统计分析，这涉及到计算差异表达的个体基因和蛋白，当前用于gene-level的统计包含具有phenotype，ANOVA，Q-statistic， signal-to-noise ratio的molecular measurements的相关性；其次，所有基因gene-level的统计分析汇聚成单个pathway-level的统计分析，该统计分析可以是多变量，计算基因间的独立性，也可以是单变量的，不考虑基因间的的相互依靠性。不考虑使用的不同统计方式，pathway-level统计能力依赖于一个pathway中差异表达基因的部分，也就是pathway的大小。Although, multivariate statistics are expected to have higher statistical power, univariate statistics show more power at stringent cutoffs when applied to real biological data(p~0.001), and equal power as multivariate statistics at less stringent cutoffs(p~0.05)；最后，评估pathway-level的统计显著性。当在计算统计显著性时，当前使用的null假设可分为两类：1）competitive null hypothesis 和2）self-contained null hypothesis。self-contained null hypothesis 变换每个样本的类别标签(i.e., phenotypes)，检测给定pathway中一套基因本身的显著性，不考虑不在其中的基因；competitive null hypothesis针对每个pathway变换基因标签，比较一套存在于pathway中的基因和一套不在pathway中的基因。

![image-20190514143524771](https://ws1.sinaimg.cn/large/006tNc79ly1g30u4igkj7j31ic0hwjvr.jpg)

FCS方法解决了ORA三个局限性，首先，不需要一个阈值将表达数据任意的分成显著性和非显著性两类，而是使用所有可以得到的molecular measurements来分析pathway；其次，ORA在识别显著性pathway时完成忽略了molecular measurements，FCS使用该信息来检测同一个pathway内一致性改变的基因；最后，通过基因表达一致性的改变，FCS能够实现pathway内基因间的依赖性，而ORA不行。

FCS局限性，首先，FCS类似ORA，独立地分析每一个pathway，pathway同基因一样，可以互相作用重叠的。当使用GO分析时，一个pathway的可能受到影响是因为与其他显著影响pathway存在基因重叠；其次，许多FCS方式针对给定pathway，使用基因表达的改变来对基因求秩序，同时对与进一步的分析不考虑其基因表达的改变信息。例如，2和20倍的改变可以是相同的秩序，虽然20倍的改变应该赋予基因更大的比重。Importantly, however, considering only the ranks of genes is also advantageous, as it is more robust to outliers. A notable exception to this scenario is approaches that use gene-level statistics (e.g., t-statistic) to compute pathway-level scores. For example, an FCS method that computes a pathway-level statistic as a sum or mean of the gene-level statistic accounts for a relative difference in measurements (e.g, Category, SAFE)。

#### Third Generation: Pathway Topology (PT)-Based Approaches

基于大量可用的公开pathway的信息，而不是每个pathway简单的基因信息，进行pathway分析。不同于GO和Molecular Signatures Database (MSigDB)，这些数据库也提供了给定pathway内基因产物相互作用的信息(e.g., activation, inhibition, etc.)，以及作用位置(e.g., cytoplasm, nucleus, etc.)。它们包括KEGG, MetaCyc, Reactome, RegulonDB, STKE, BioCarta和pantherDB。

![image-20190514143614416](https://ws2.sinaimg.cn/large/006tNc79ly1g30u4w11dmj31i806m75p.jpg)

ORA和FCS方法仅考虑pathway中基因数据，或着共表达基因来识别显著性pathway，而不考虑这些数据库额外的可行信息。Pathway topoloty (PT)-based methods，能使用这些额外的信息。PT-based 方法同FCS一样执行相同的三步分析处理。其关键差异在于，PT-based方法使用pathway topology来计算gene-level统计结果。

Rahnenfuhrer et al. 提出了ScorePAGE，计算pathway内每个基因对之间的相似性(e.g., correlation, covariance， etc.)。每个基因对之间的相似性测量类似于FCS方法中gene-level的统计，它平均地检测pathway-level的分值。然而，不同于给予所有成对相似性一样的权重，ScorePAGE根据指定pathway内成对基因发生联系所需的反应数目来划分成对相似性。尽管该过程被设计用于分析代谢pathways，理论上也适用于signaling pathways。

最近impact factor (IF)分析过程被提出分析signaling pathways。 IF通过合并一些重要的biological factors，包括基因表达差异，相互作用类型，pathway中基因的位置，来考虑整个pathway的结构和动态性。IF分析将signaling pathway模拟为图像，nodes代表基因，edges代表基因间的相互作用。进一步，定义gene-level的统计，称为一个基因的pertubation factor(PF)，为表达过程中所测量到的改变之和，和和pathway中所有gene的PF的线性方程(Further, it defines a gene-level statistic, called perturbation factor of a gene, as a sum of its measured change in expression and a linear function of the perturbation factors of all genes in a pathway)。由于每个基因的PF都是被线性公式所定义，因此整个pathway都被定义为一个线性系统。

FCS方式使用基因间的相关性，模糊地假设潜在网络，由于是被结构的相关性所定义，因此并不会随着实验条件改变而改变。

NetGSA, that accounts for the change in correlation as well as the change in network structure as experimental conditions change. Their approach, like IF analysis, models gene expression as a linear function of other genes in the network. However, it differs from IF in two aspects. First, it accounts for a gene's baseline expression by representating it as a latent variable in the model. Second, it requires that the pathways be represented as directed acyclic graphs (DAGs). If a pathway contains cycles, NetGSA requires additional latent variables affecting the nodes in the cycles. In contrast, IF analysis does not impose any constraint on the structure of a pathway.

尽管PT-based 方法难以推广，也存在多个共有不足。首先，真实的pathway topology是建立在细胞类型之上，是由于细胞特异的基因的表达轮廓和被研究的条件。然而，该信息几乎不可能获得，且在当前数据基础上被片段化了；其次，无法模拟系统的动态状态，由于较弱的pathway之间的联系无法考虑它们之间的相互作用(One obvious problem is that true pathway topology is dependent on the type of cell due to cell-specific gene expression profiles and condition being studied; the inability to model dynamic states of a system and the inability to consider interactions between pathways due to weak interpathway links to account for interdependence between pathways)。

#### Outstanding Challenges in Pathway Analysis

当前pathway anaysis的两个挑战可分为两类：1）annotation challenges；2）methodological challenges。

***

###clusterProfiler

1. Terminology

Gene sets：单纯的一列功能相关的基因，不需要指定基因之间的关系

Pathways：可以解释为特殊的一列基因，典型地代表一组在生物功能上共同作用的基因

Gene Ontology：定义了用于描述基因功能的概念或者类别，以及这些概念和类别之间的关系。其定义的功能有以下三个方面：

MF：分子功能，基因产物的分子作用

CC：细胞组成，基因产物作用的地点

BP：生物过程，pathways以及larger processes由多重基因产物的作用所构成

GO terms由带有带有方向的非循环的图形所组成，terms之间的edge代表着parent-child 关系。

KEGG：KEGG是手动绘制的，代表了分子之间的协同作用和互相作用的网络图的集合。这些pathways涵盖了大量的生物过程，可以划分为7个大的范畴：metabolism，genetic and environmental information processing, cellular processes, organismal systems, human diseases, and drug development。

GO和KEGG是最常用的功能分析。由于它们长期的收录支持以及包含了广泛的物种，因此是首要的分析选择。其他相关的gene sets有Disease Ontology(DO)，Disease Gene Network(DisGeNET), wikiPathways, Molecular Signature Database(MSigDb)。

2. Functional Enrichment Analysis Methods

**ORA(Over Representation Analysis) 广泛用于判断，在一个已知的实验所驱动的基因列中( a list of differentially expressed genes, DEGs)，已知的生物功能或过程是否over-represented(= enriched)。**

P-value 采用超几何分布计算：

![image-20190516124739006](https://ws4.sinaimg.cn/large/006tNc79gy1g3328ixj87j30zm04kt8y.jpg)

例如：Microarry study， 11812个基因用于差异表达分析，2个样本中，有202个基因发现DE，在这些DE中，有25个基因注释到了特殊的功能gene set中，该gene set包含了262个基因。则2x2四格表：

` d <- matrix(c(25, 237, 177, 11373), nrow=2, dimnames=list(c("DE","Not DE"), c("In GS", "Not in GS")))`

`fisher.test(d, alternative="greater")`

![image-20190831174755790](https://tva1.sinaimg.cn/large/006y8mN6gy1g6j07wxov3j30yo0fsq4q.jpg)

95%置信区间为4.5，而算得的率为6.774，远大于4.5，接受DE和Not DE之间存在差异。

**GSEA(Gene Set Enrichment Analysis)解决了ORA分析过程中只考虑差异大的基因，而不考虑差异较小但是一致性表达的一组相关基因的问题。所有基因均用于GSEA分析，GSEA整合gene set中每个基因的统计值，从而检测提前定义的gene set中所有基因发生小的变化，同时发生一致性改变的情况。因为，可能出现许多表型差异与一组变化较小但是一致性变化的基因所联系起来的情况。**

根据表型对基因排秩序。针对一套给定prior的gene set S(e.g., genes sharing the same GO category)，GSEA分析的目的在于判断S中的基因是否随机分布在排完秩序后的gene list(L)中或主要分布在top或bottom。

GSEA分析的三个关键要素：

Calculation of Enrichment Score

富集值(ES)代表了a set S (over-represented) 位于经过排秩序后的gene list(L)的top或bottom的程度。通过统计L中出现的S的情况，计算得ES值。

The score is calculated by walking down the list *L*, increasing a running-sum statistic when we encounter a gene in *S* and decreasing when it is not. The magnitude of the increment depends on the gene statistics (e.g., correlation of the gene with phenotype). The *ES* is the maximum deviation from zero encountered in the random walk; it corresponds to a **weighted Kolmogorov-Smirnov-like statistic**(Subramanian et al. [2005](https://yulab-smu.github.io/clusterProfiler-book/chapter2.html#ref-subramanian_gene_2005)).

Estimation of Significance Level of ES

使用permutation test计算ES的p-value。重新排列gene list L的基因标签，针对permutated data重新计算gene set的ES，针对ES生成null distribution。然后计算相对于该null distribution的ES的p-value。

Adjustment for Multiple Hypothesis Testing

当整个gene set都被评估后，DOSE针对多重假设检验调整评估的显著性水平，同时针对FDR control 计算q-value。

The false discovery rate (FDR)指的是type I 型错误的期待比率。Type I型错误就是错误拒绝null假设；换言之，就是得到了假阳性。FDR就是假阳性的数目在所有拒绝假设中的比率(拒绝 null hypothesis)。医学上，就是当你得到一个阳性检测结果但实际上并没有得病的比率，其对应面就是阳性预测值(PPV)，就是阳性结果准确性的比率。

![image-20190516103421704](https://ws1.sinaimg.cn/large/006tNc79gy1g32ydtiwaxj30qo0mywi8.jpg)

**p-value告诉我们单次检测假阳性的概率；当针对小样本进行大量数目的检测时(genomics或protoemics), 就应使用q-value了：p-value为5%意味着5%的检测将会导致加假阳性结果，q-value为5%意味着5%的显著性结果将会为假阳性。使用q-value来控制FDR的过程称为Benjamini-Hochberg procedure。**

在DOSE中，可以指定DOSE或fqsea(by="DOSE", by="fqsea")来选择相应的GSEA算法，默认DOSE选择fqsea，更快。

**Leading edge analysis and core enriched genes，leading edge分析将会报告Tags值来表明多少比率的genes贡献了enrichment score，List 来表明enrichement score处在list中的什么位置，Singnal表明enrichmen signal的强度。这也可以得到贡献了enrichment的核心富集基因，DOSE支持leading edge分析并在GSEA分析中报告core enriched genes。**

3. Universal enrichment analysis

针对过表达分析，需输入基因向量，也就是gene IDs的向量，可由DESeq2包获得。针对gene sets enrichment 分析，需要一个排秩序后的genes list，geneList包含以下特征：1. 数字向量，倍数改变或其他类型的数字变量；2. 命名向量，根据对应的gene ID命名每个数字；3. 排序后的向量，对数字进行降序排列。

`d <- read.csv(your_csv_file)`

假设第一列为ID，第二列为Fold change

`geneList <- d[,2]`

`name(geneList) <- as.character(d[,1])`

`geneList <- sort(geneList, decreasing=T)`

clusterProfiler支持超几何检验和ontology/pathway的gene set enrichment分析。clusterProfiler针对超几何检验提供enricher函数，针对gene set enrichment分析提供GSEA函数，同时接受自定义的注释。这两个函数接受2个额外的参数，TERM2GENE，TERM2NAME。TERM2GENE为一个数据框，第一列为term ID，第二列为对应的比对的基因；TERM2NAME同样为一数据框，第一列为term ID，第二列为对应的term 名称，且TERM2NAME是可选的。

WikiPathways是一个持续更新的pathway数据库。WikiPathways针对其所支持的物种每月都会更新对应的gmt文件，下载对应的gmt文件，然后生成TERM2GENE和TERM2NAME来用于enricher和GSEA函数。

`library(magrittr)`

`library(clusterProfiler)`

`data(geneList, package="DOSE")`

`gene <- names(geneList)[abs(geneList) >2]`

`wpgmtfile <- system.file("extdata/wikipathways-20180810-gmt-Homo_sapiens.gmt", package="clusterProfiler")`

`wp2gene <- read.gmt(wpgmtfile)`

`wp2gene <- wp2gene %>% tidyr::sparate(ont, c("name", "version", "wpid", "org"), "%%")`

`wpid2gene <- wp2gene %>% dplyr::select(wpid, gene)`

`wpid2name <- wp2gene %>% dplyr::select(wpid, name)`

`ewp <- enricher(gene, TERM2GENE=wpid2gene, TERM2NAME=wpid2name)`

`ewp2 <- GSEA(geneList, TERM2GENE=wpid2gene, TERM2NAME=wpid2name,verbose=F)`

使用setReadable函数将gene IDs转化位gene symbols

`library(org.Hs.eg.db)`

`ewp <- setReadable(ewp, org.Hs.eg.db, keyType="ENTREZID")`

`ewp2 <- setReadable(ewp2, org.Hs.eg.db, keyType="ENTREZID")`

Molecular Signatures Database包含8个主要单元：

1. H：hallmark gene sets
2. C1：positional gene sets
3. C2：curated gene sets
4. C3：motif gene sets
5. C4：computational gene sets
6. C5：GO gene sets
7. C6：oncogenic signatures
8. C7：immunologic signatures

可以使用从Broad Institute下载GMT文件，使用read.gmt解析后用于enricher()和GSEA()。另外msigdbr包已经包含了MSigDB gene set可直接用于clusterProfiler分析

`library(msigdbr)`

`msigdbr_show_species()`

`m_df <- msigdbr(species="Homo sapiens")`

`head(m_df, 2) %>% as.data.frame`

使用C6，oncogenic gene sets分析

`m_t2g <- msigdbr(species = "Homo sapiens", category = "C6") %>% dplyr::select(gs_name, entrez_gene)`

`head(m_t2g)`

`em <- enricher(gene, TERM2GENE = m_t2g)`

`em2 <- GSEA(geneList, TERM2GENE = m_t2g)`

`head(em)`

`head(em2)`

使用C3查看根据共有的特殊motif是否上调或下挑

`m_t2g <- msigdbr(species = "Homo sapiens", category = "C3") %>% dplyr::select(gs_name, entrez_gene)`

`head(m_t2g)`

`em3 <- GSEA(geneList, TERM2GENE = m_t2g)`

4. Disease analysis

DOSE支持Disease Ontology(DO)富集分析。enrchDO可用于识别疾病相关的基因，gseDO用于DO的gene set enrichment分析。此外，DOSE还支持Network of Cancer Gene(NCG)的富集分析和Disease Gene Network分析。

这里选择fold change 在1以上基因位差异表达基因用于分析它们的疾病关系

`library(DOSE)`

`data(geneList)`

`gene <- names(geneList)[abs(geneList) > 1.5]`

`x <- enrichDO(gene=gene, ont="DO", pavlueCutoff=0.05, pAdjustMethod="BH", universe=names(geneList), minGSSize=5, maxGSSize=500, qvalueCutoff=0.05, readable=FALSE)`

enrichGO函数需要输入entrezgene ID向量，大部分情况是gene 表达研究中的差异性genes，若需要将其他gene ID转为entrezgene ID，使用bitr函数即可。

ont参数可以为"DO"或"DOLite"，目前DOLite数据停止更新了，推荐使用ont="DO"；pvalueCutoff设置p value以及p value adjust阈值；pAdjustMethod设置p value修正方法，包含有Bonferroni correction("bonferroni")，Holm("holm")，Hochberg("hochberg")，Hommel("hommel")，Benjamini & Hochberg("BH")和Benjamini & Yekutieli("BY")，qvalueCutoff常用于控制q-values；universe设置检测的背景基因，如果没有明确指定该参数，enrichDO将使用具有DO注释的人类基因；minGSSize(和maxGSSize)指定只有超过minGSSize(同时低于maxGSSize)基因注释的DO terms才被检测；readable参数指定是否使用gene symbols代表gene IDs; 同样，可以使用setReadable函数将entrezgene IDs转换为gene symbols。

`x <- setReadable(x, "org.Hs.eg.db")`

Network of Cancer Gene(NCG)是一个手动创建的癌症基因数据库。DOSE支持分析gene list判断它们是否存在富集的基因，这些基因存在已知的突变肿瘤类型中(determine whether they are enriched in genes known to be mutated in a given cancer type)。

`gene2 <- names(geneList)[abs(geneList) < 3]`

`ncg <- enrichNCG(gene2)`

参数同enrichDO

DisGeNET是一个整合的且综合的基因疾病相关的数据库(源自公开数据资源和文献)。它包含了基因疾病关系和snp基因疾病关系。

enrichDGN支持基因基因相关的富集分析，enrichDGNv支持snp基因疾病关系分析。

`dgn <- enrichDGN(gene)`

参数同enrichDO

```R
snp <- c("rs1401296", "rs9315050", "rs5498", "rs1524668", "rs147377392","rs841", "rs909253", "rs7193343", "rs3918232", "rs3760396","rs2231137", "rs10947803", "rs17222919", "rs386602276", "rs11053646","rs1805192", "rs139564723", "rs2230806", "rs20417", "rs966221")
```

`dgnv <- enrichDGNv(snp)`

参数同enrichDGNv

DO Gene Set Enrichment Analysis

`library(DOSE)`

`data(geneList)`

`y <- gseDO(geneList, nPerm=100, minGSSize=120, pvalueCutoff=0.2, pAdjustMethod="BH",verbose=FALSE)`

nPerm: permutation numbers

NCG Gene Set Enrichment Analysis

`ncg <- gseNCG(geneList, nPerm=100, minGSSize=120, pvalueCutoff=0.2, pAdjustMethod="BH", verbose=F)`

`ncg <- setReadable(ncg, "org.Hs.eg.db")`

DisGeNET Gene Set Enrichment Analysis

`dgn <- gseDGN(geneList, nPerm=100, minGSSize=120, pvalueCutoff=0.2, pAdjustMethod="BH", verbose=F)`

`dgn <- setReadable(dgn, "org.Hs.eg.db")`

5. Gene Ontology Analysis

GO分析(groupGO(), enrichGO(), gseGO())支持具有OrgDb对象的物种。Bioconductor 现已经提供了约20种物种饿OrgDb数据，当然也可以使用AnnotationForge创建Orgdb数据，参考GOSemSim。

假如拥有GO注释数据(数据框格式，第一列为gene ID，第二列为GO ID)，可使用enricher(), gseGO()函数执行over-representation test和gene set enrichement analysis。

假如基因是通过直接注释(direction annotation)而来的，那么它们也应该被它们ancestor GO nodes所注释(indirect annotation)。假如只有direct annotaion，可将它们的注释传递给buildGOmap函数，该函数将会推导indirection annotation，生成使用与enricher()和gseGO()的数据框。

groupGO用于针对指定水平对gene基于GO分布进行分类。

`library(clusterProfiler)`

`data(geneList, package="DOSE")`

`gene <- names(geneList)[abs(geneList) > 2]`

`gene.df <- bitr(gene, fromType="ENTREZID", toType=c("ENSEMBL","SYMBOL"), OrgDb=org.Hs.eg.db)`

`ggo <- groupGO(gene=gene, OrgDb=org.Hs.eg.db, ont="CC", level=3, readable=T)`

Over-representation test

`ego <- enrichGO(gene=gene, universe=names(geneList), OrgDb=org.Hs.eg.db, ont="CC", pAdjustMethod="BH", pvalueCutoff=0.01, qvalueCutoff=0.05, readable=T)`

`ego2 <- enrichGO(gene=gene.df$ENSEMBL, OrgDb=org.Hs.eg.db, keyType="ENSEMBL", ont="CC", pAdjustMethod="BH", pvalueCutoff=0.01, qvalueCutoff=0.05)`

`ego2 <- setReadable(ego2, OrgDb=org.Hs.eg.db)`

Drop specific GO terms or level

dropGO函数可用于去除enrichGO和compareCluster结果中的特殊GOterms或GO levels。

Test GO at sepcific level

enrichGO不包含参数用于限制特殊GO level的test，但是可使用gofilter函数来限制结果到指定的GO level，用于enrichGO和compareCluster的输出的结果。

Reduce redundancy of enriched GO terms

GO是一个parent-child的结构形式，因此parent term可能会重叠它所有child terms的很大一部分，这会导致冗杂的发现输出。clusterProfiler提供了simplify函数用于减少来自enrichGO和gseGO的输出中的冗杂GO terms。通过计算GO terms之间的相似度，然后去除哪些高度相似的terms，仅保留一个代表性的term。

GO Gene Set Enrichment Analysis

Gene Set Enrichment Analysis(GSEA)

`ego3 <- gseGO(geneList=geneList, OrgDb=org.Hs.eg.db, ont="CC", nPerm=1000, minGSSize=100, maxGSSize=500, pvalueCutoff=0.05, verbose=F)`

GSEA使用permutation test， 可设定nPerm参数指定permutations数目。

GO Semantic Similarity Analysis

使用GOSemSim检测GO semantic similarity。基因genes或proteins功能上的相似性，将它们聚类，也可用来测量GO terms之间的相似性来减少GO enrichment results的冗杂程度。

GO analsysi for non-model organisms

enrichGO和gseGO函数均需要OrgDb数据，若AnnotatonHub没有该物种的OrgDb数据，可以从其他地方获得OrgDb数据，例如，biomaRt和Blast2GO。然后使用enricher或GSEA函数分析。或者，使用AnnotationForge来创建OrgDb数据。

6. KEGG analysis

KEGG.db自从2012年后就没更新了，在clusterProfiler包中，enrichKEGG(for KEGG pathway)和enrichMKEGG(for KEGG module)支持下载最新的KEGG在线版本用于富集分析。KEGG Orthology(KO)数据库也支持指定物种organism="ko"。

使用search_kegg_organism函数搜索支持的物种

`library(clusterProfiler)`

`search_kegg_organism("kpc", by="egg_code")`

`kpc <- search_kegg_organism("Klebsiella pneumoniae", by="scientific_name")`

KEGG over-representation test

`data(geneList, package="DOSE")`

`gene <- names(geneList)[abs[geneList) > 2]`

`kk <- enrichKEGG(gene=gene, organism='hsa', pvalueCutoff=0.05)`

输入的ID类型，可以是kegg，ncbi-geneid，ncbi-proteinid或uniprot。

KEGG Gene Set Enrichment Analysis

`kk2 <- gseKEGG(geneList=geneList, organism='hsa', nPerm=1000, minGSSize=120, pvalueCutoff=0.05, verbose=F)`

`head(setReadable(kk2, org.Hs.eg.db,keyType="ENTREZID"))`

KEGG Module over-representation test

KEGG Module是人工审核定义的功能单元，在一些情况下，KEGG Module具有明确直接的解释

`mkk <- enrichMKEE(gene=gene, organism='hsa')`

KEGG Module Gene Set Enrichment Analysis

`mkk2 <- gseMKEE(geneList=geneList, organism='hsa')`

7. MSigDb analsysi

`data(geneList, package="DOSE")`

`gene <- names(geneList)[abs(geneList) >2]`

`gmtfile <- system.file("extdata", "c5.cc.0.entrez.gmt", package="clusterProfiler")`

`egmt <- enricher(gene, TERM2GENE=c5)`

8. Reactome pathway analysis

ReactomePA包用于reactome pathway-based analysis. Reactome是一个开源的，开放的，人工审核记录的，经过同行审核的pathway数据库。

当前ReactomePA支持多种模式物种，包括"celegangs", "fly","human","mouse","rat","yeast"和"zabrafish"，输入的gene ID需要为Entrez gene ID，推荐使用clusterProfiler::bitr来转换IDs。

`library(ReactomePA)`

`data(geneList)`

`de <- names(geneList)[abs(geneList) > 1.5]`

`x <- enrichPathway(gene=de, pvalueCutoff=0.05, readable=T)`

Gene Set Enrichment Analysis

`y <- gsePathway(geneList, nPerm=10000,pvalueCutoff=0.2,pAdjustMethod="BH",verbose=F)`

`res <- as.data.frame(y)`

9. MeSH Enrichment Analysis

10. Funcitonal enrichment analysis of genomic coordinations

Pathway analysis of NGS data(RNA-Seq, ChIP-Seq)，来自NGS数据的pathway分析可以被ChIPseeker包，通过连接编码区和非编码到coding genes实现。ChIPseeker包可以注释基因组区域到距离它最近的基因，管家基因，和侧翼基因。此外，它还提供了函数seq2gene，它可以同时考虑来自基因间区的管家基因，启动子区域和侧翼基因，这些区域可能被顺式调控所调节。

11. Biological theme comparison

clusterProfiler可进行biological theme comparision分析，compareCluster，自动计算每个gene clusters的enriched functional categories。

输入的geneCluster参数需要是gene IDs的名称列表

`data(gcSample)`

`ck <- compareCluster(geneCluster=gcSample,fun="enrichKEGG")`

Formula inerface of compareCluster

compareCluster同样支持传递公式类型的比较, Enterz ~ group或者Entrez ~ group + othergroup

`mydf <- data.frame(Entrez=names(geneList), FC=geneList)`

`mydf <- mydf[abs(mydf$FC) > 1,]`

`mydf$group <- "upregulated"`

`mydf$group[mydf$FC<0] <- "downregulated"`

`mydf$othergroup <-"A"`

`mydf$othergroup[abs(mydf$FC) > 2] <- "B"`

`formula_res <- comparaCluster(Entrez ~ group + othergroup, data=mydf, fun="enrichKEGG")`

Visulization of profile comparison

`dotplot(ck)`

`dotplot(formula_res)`

`dotplot(formula_res, x=~group) + ggplot2::facet_grid(~othergroup)`

12. Visualization of Functional Enrichment Result

enrichplot包提供了多种可视化模型来帮助解释富集结果，它支持来自DOSE, clusterProfiler, ReactomePA和meshes包的富集结果，ORA和GSEA分析结果都支持。

Bar Plot

条形图是最广泛用于查看enriched terms的方式，它能表现出富集值(p value)，gene count或ratio作为bar的高度和颜色。

`de <- names(geneList)[abs(geneList) > 2]`

`edo <- enrichDGN(de)`

`library(enrichplot)`

`barplot(edo, showCategory=20)`

Dot plot

点图类似条形图，能够其他score作为点的大小

`edo2 <- gseNCG(geneList, nPerm=100000)`

`p1 <- dotplot(edo, showCategory=30) + ggtitile("dotplot for ORA")`

`p2 <- dotplot(edo2, showCategory=30) + ggtitle("dotplot for GSEA")`

`plot_grid(p1,p2,ncol=2)`

Gene-Concept Network

barplot和dotplot只能显示最显著enriched terms，但时用户可能想要看到哪些基因参与到了这些显著terms。为了考虑到潜在的生物学复杂性，哪些基因可能属于多个注释类别，同时提供多个改变的信息。cnetplot函数可以提取这些基因之间的的复杂关系。cnetplot函数通过网络描绘了基因和生物概念(GO terms或KEGG pathway)之间的联系。

`edox <- setReadable(edo, "org.Hs.eg.db", "ENTREZID")`

`cnetplot(edox, foldChange=geneList)`

使用pvalue或geneNum对categorySize进行scale

`cnetplot(edox, categorySize="pvalue", foldChange=geneList)`

`cnetplot(edox, foldChange=geneList, circular=TRUE, colorEdge=TRUE)`

Heatmap-like functional classification

heatplot类似于cnetplot，以heatmap形式展示相关性。

`heatplot(edox)`

`heatplot(edox, foldChange=geneList)`

Enrichment Map

Enrichment map将每一个term组织到网络结构中，每个edge都连接着重叠的gene   sets。共同重叠的gene sets就倾向于聚到一起，容易识别fuctional mudule。

`emapplot(edo)`

UpSet Plot

upsetplot是cnetplot的另一种形式，用于展示genes和gene sets之间的复杂关系，它强调不同gene sets之间的gene重叠。

ridgeline plot for expression distribution of GSEA result

ridgeplot用于展示GSEA富集的类别核心富集基因的表达分布，帮助识别上调或者下调的pathways。

running score and preranked list of  GSEA result

Running score and preranked list are traditional methods for visualizing GSEA result. The enrichplot package supports both of them to visulaize the distribution of the gene set and the enrichment score.

`gseaplot(edo2,  geneSetID=1, by="runningScore", title=edo2$Description[1])`

`gseaplot(edo2, geneSetID=1, by="preranked", title=edo2$Description[1])`

`gseaplot(edo2, geneSetID=1, title=edo2$Description[1])`

`gseaplot2(edo2, geneSetID=1, title=edo2$Description[1])`

mutile gene sets to be displayed

`gseaplot2(edo2, geneSetID=1:3)`

display the pvalue

`gseaplot2(edo2, geneSetID=1:3, pvalue_table=TRUE, color=c("#E495A5", "#86B875", "#7DB0DD"), ES_geom="dot")`

display the subplot

`gseaplot(edo2, geneSetID=1:3, subplots=1)`

`gseaplot(edo2, geneSetID=1:3, subplots=1:2)`

gsearank plot the ranked list of genes belong to the specific gene set

`gsearnak(edo2, title=edo2[1, "Description"])`

mutiple gene sets can be aligned using cowplot

`library(ggplot2)`

`library(cowplot)`

`pp <- labpply(1:3, function(i){`

`anno <- edo2[i, c("NES","pvalue","p.adjust")]`

`Lab <- paste0(names(anno), "=", round(anno, 3), collapse="\n")`

`gsearank(edo2, i, edo2[i, 2] + xlab(NULL) + ylab(NULL) + annotate("text", 0, edo2[i, "enrichmentScore"] * 0.9, label=lab, hjust=0, vjust=0)})`

`plot_grid(plotlist=pp, ncol=1)`

pubmed trend of enriched terms

富集分析需要解决的一个问题就是寻找进一步研究的pathways。pmcplot函数可以帮忙绘制出PubMed Central的查询结果的发布趋势。

`terms <- edo$Description[1:3]`

`p <- pmcplot(terms, 2010:2017)`

`p2 <- pmcplot(terms, 2010:2017, proportion=F)`

`plot_grid(p, p2, ncol=2)`

goplot

`gopot(ego)`

browseKEGG

`browseKEGG(kk, 'hsa04110')`

pathview from pathview package

clusterProfiler用户可是使用pathview函数来查看KEGG pathway

`library(pathview)`

`hsa04110 <- pathview(gene.data=geneList, pathway.id = 'hsa04110', species='hsa', limit=list(gene=max(abs(geneList)), cpd=1))`





































