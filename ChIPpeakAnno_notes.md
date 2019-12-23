#### [ChIPpeakAnno][http://bioconductor.org/packages/release/bioc/html/ChIPpeakAnno.html]

该包可用于发现富集峰最近的基因, 外显子, miRNA或定制的features(例如用户提供的保守单元或其他转录因子结合位点), 查询peak附近的序列, 获得富集的GO或通路.

ChIPpeakAnno一个重要功能就是根据已知的基因组特征注释peaks, 例如TSS, 5'UTR, 3'UTR等. 因此构建和选择合适的注释数据至关重要.

针对常见模式生物, 已经构建了一系列的转录起点注释信息, 例如TSS.human.NCBI36, TSS.human.GRCh37... 对于峰注释其他基因组信息, 可使用`getAnnotation`选择对应的featuretye, 'Exon'用于最近的外显子, 'miRNA'用于最近的miRNA, '5utr','3utr'来定位‘5UTR','3UTR'的重叠.

此外, 针对自定义注释数据, 例如GRanges, 可用于`annotatePeakInBath`, 这里通过`toGRanges`函数将定义的注释数据转换为其他格式, 例如USCS BED/GFF格式. GRanges对象可通过`toGRanges`从EnsDB或TxDb对象构建而来.

而TxDb/EnsDB对象可通过GenomicFeature包从UCSC Genome Bioinformatics/BioMart下载, 或使用`makeTxDbFromGRanges`/`makeTxDbFromGFF`创建.







