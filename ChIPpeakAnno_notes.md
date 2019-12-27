#### [ChIPpeakAnno][http://bioconductor.org/packages/release/bioc/html/ChIPpeakAnno.html]

1. Introduction

该包可用于发现富集峰最近的基因, 外显子, miRNA或定制的features(例如用户提供的保守单元或其他转录因子结合位点), 查询peak附近的序列, 获得富集的GO或通路.

ChIPpeakAnno一个重要功能就是根据已知的基因组特征注释peaks, 例如TSS, 5'UTR, 3'UTR等. 因此构建和选择合适的注释数据至关重要.

针对常见模式生物, 已经构建了一系列的转录起点注释信息, 例如TSS.human.NCBI36, TSS.human.GRCh37... 对于峰注释其他基因组信息, 可使用`getAnnotation`选择对应的featuretye, 'Exon'用于最近的外显子, 'miRNA'用于最近的miRNA, '5utr','3utr'来定位‘5UTR','3UTR'的重叠.

此外, 针对自定义注释数据, 例如GRanges, 可用于`annotatePeakInBath`, 这里通过`toGRanges`函数将定义的注释数据转换为其他格式, 例如USCS BED/GFF格式. GRanges对象可通过`toGRanges`从EnsDB或TxDb对象构建而来.

而TxDb/EnsDB对象可通过GenomicFeature包从UCSC Genome Bioinformatics/BioMart下载, 或使用`makeTxDbFromGRanges`/`makeTxDbFromGFF`创建.

2. Quick start

`library(ChIPpeakAnno)`

`macs <- system.file("extdata","MACS_peaks.xls",package="ChIPpeakAnno")`

`macsOutput <- toGRanges(macs, format="MACS")`

使用ensembl 注释

`data(TSS.human.GRCh38)`

`macs.anno <- annotationPeakInBatch(macsOutput, AnnotationData=TSS.human.GRCh.38)`

加入基因symbol

`library(org.Hs.eg.db)`

`macs.anno <- addGeneIDs(annotatedPeak=macs.anno, orgAnn="org.Hs.eg.db", IDs2Add="symbol")`

3. An examle of ChIP-seq analysis workflow using ChIPpeakAnno

输入为一系列来自ChIP-seq实验识别的峰. 在ChIPpeakAnno中, 峰是以GRanges的格式表示的. 使用函数`toGRanges`将峰文件格式, 例如BED, GFF或MACS格式转换为Granges.

该流程用于将BED/GFF格式转换为GRanges, 然后在两组峰中查询重叠的峰, 使用Venn图查看.

读取峰文件

`bed <- system.file("extdata","MACS_output.bed",package="ChIPpeakAnno")`

`gr1 <- toGRanges(bed, format="BED",header=FALSE)`

也可使用`rtracklayer`包的`import`函数转换格式为GRanges

`library(rtracklayer)`

`gr1.import <- import(bed, format="BED")`

`identical(start(gr1), start(gr1.import))`

`gff <- system.file("extdata","GFF_peaks.gff",package="ChIPpeakAnno")`

`gr2 <- toGRanges(gff, format="GFF",header=FALSE,skip=3)`

![image-20191224202600610](https://tva1.sinaimg.cn/large/006tNbRwgy1ga831w179vj30m703ugmi.jpg)

**针对GFF文件, 建议先导入为TxDb对象, 再使用toGRanges转换**

查询重叠区域, 绘制文式图和饼图

`ol <- findOverlapsOfPeaks(gr1, gr2)`

`makeVenDiagram(ol, fill=c("#009E73","#F0E442"), col=c("#D55E00","#0072B2"), cat.col=c("#D55E00","#0072B2"))`

`pie1(table(ol$overlappingPeaks[["gr1///gr2"]]$overlapFeatures))`

![image-20191224202810714](https://tva1.sinaimg.cn/large/006tNbRwgy1ga83438wsij30jh0bdgmk.jpg)

![](https://tva1.sinaimg.cn/large/006tNbRwgy1ga834eplftj30kt0awjsa.jpg)

查询到重叠峰后, 根据AnnotationData中的基因组信息, 使用`annotatePeakInBatch`注释重叠的峰其5000bp内的特征信息, with certain distance away specified by maxgap, which is 5kb in the following example.

`overlaps <- ol$peaklist[["gr1///gr2"]]`

`library(EnsDb.Hsapiens.v75)`

使用EnsDb/TxDb构建注释文件

`annoData <- toGRanges(EnsDb.Hsapiens.v75, feature="gene")`

`overlaps.anno <- annotatePeakInBatch(overlaps, AnnotationData=annoData, output="overlapping", maxgap=5000L)`

`overlaps.anno$gene_name <- annoData$gene_name[match(overlaps.anno$feature, names(annoData))]`

![image-20191224204808606](https://tva1.sinaimg.cn/large/006tNbRwgy1ga83owb6eej30m50dcgps.jpg)

完成峰的注释后, **距离最近的基因组特征信息, 例如转录起始点(TSS)可绘制**

`gr1.copy <- gr1`

`gr1.copy$score <- 1`

`binOverFeature(gr1, gr1.copy, annotationData=annoData, radius=5000, nbins=10, FUN=c(sum, length), ylab=c("score","sum"),main=c("Distribution of aggregated peak score around TSS", "Distribution of aggregated peak numbers around TSS'))`

![image-20191226191655543](https://tva1.sinaimg.cn/large/006tNbRwgy1gaacami09tj30td0ieta4.jpg)

**绘制峰跨越外显子, 内含子, 增强子(enhancer), proximal promoter, 5' UTR, 3' UTR的分布图**

`if(require(TxDb.Hsapiens.UCSC.hg19.knownGene)){aCR <- assignChromosomeRegion(gr1, nucleotideLevel=FALSE, percedence=c("Promoters","immediateDownstream","fiveUTRs","threeUTRs","Exons","Introns"),TxDb=TxDb.Hsapiens.UCSC.hg19.knownGene)`

`barplot(aCR$percentage)}`

![image-20191226192850515](https://tva1.sinaimg.cn/large/006tNbRwgy1gaacmz86vsj30sv0hsmxn.jpg)

4. Detailed Use Cases and Scenarios



