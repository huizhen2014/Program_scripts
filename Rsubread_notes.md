#### Subread

Subread package包含了一套用于高通量测序软件用于处理下一代测序数据，主要包含：

align： 用于比对DNA或 RNA测序reads；针对RAN-seq实验检测gene表达水平发现差异表达基因，推荐使用subread aligner，针对RNA-seq reads使用局部比对

subjunc：针对RNA-seq reads比对，同时检出exon-exon junctions，而subread aligner和它主要不同就是不会检出exon-exon juncitons。 

sublong：用于比对长reads的DNA-seq测序数据，例如来自Nanopore, PacBo，

subindel : 针对局部比对来检测长插入和缺失， 首先需完成reads mapping

featureCounts：计算比对后的reads或片段(成对reads)到genomic features， 例如genes， exons， promoters

exactSNP：通过测量candidat snp的局部背景噪音来准确检测snps

****

#### Quick start

1. building an index

提供单个fasta文件，包含所有参考序列，可以是gzipped文件

`library(Rsubread)`

`buildindex(basename="my_index", reference="genome.fa")`

2. aligning the reads

仅执行差异表达分析使用subread aligner

读取目录下所有单端read文件为read_single.txt

使用for脚本依次比对

`for(input in as.vector(read.table("read_single.txt",col.names="single_file")[,1])){`

`output <- sub(".fastq", ".bam", input , fixed=T)`

`align(index="my_index", readfile1=input, output_file=output, type="rna")`

`cat(input, "\t", output, "\t","finished", "\n")}`

读取目录下双端read文件，分别为read_paired_1.txt, read_paired_2.txt

`read1 <- read.table("read_paired_1.txt", stringsAsFactors=F)`

`read2 <- read.table("read_paired_2.txt", stringsAsFactors=F)`

`read <- cbind(read1,read2, stingsAsFactors=F)`

`for ( i in 1:nrow(read)){`

`left=read[i,1]`

`right=read[i,2]`

`output=sub("_1.fastq", ".bam", left, fixed=T)`

`align(index="my_index", readfile1=left, readfile2=ritht, output_file=output, type="rna")`

`cat(left, "\t", right, "\t", "finished", "\n")}`

或者使用subjunc比对

`subjunc(index="my_index", readfile1="rnaseq-reads.fq.gz", output_file="output.bam")`

subjunc将额外输出bed文件(".junction.bed")，记录exon-exon junctions 位置

同时检测到的短的indels将会保存在text文件(".indel")

3. read summarization/quantification

输入为mapped后的read，输出为count table， 记录read比对到每个feature的次数，同时reference genome和GTF/GFF文件需要为相同的基因组，Rsubread包含了几个内建注释基因组：hg38，hg19，mm10和mm9；

a feature为参考基因组的一个区间(一段范围)，meta-feature为一组features，例如genes；而features就是exon，同时推荐使用NCBI Entrez gene id，避免genes名称带来的重复；针对双端reads，featureCounts将会使用fragments而不是reads来计算counts，且会自动根据name对bam文件排序；可以设定-minOverlap：指定最小重叠碱基数目；-fracOverlap指定最小的重叠比例，来计算每个features的counts；

针对多重比对的read(比对到参考基因组超过一个地方)，可以指定-M来计算多重比对，-fraction来报告比对比率(1/x,x为多重比对数目)；**针对多重重叠的read(read重叠了超过一个meta-feature，或feature)，推荐针对RNA-experiments，不计算此类reads。**

`mapping_results_se.bam <- grep("[^_pe].bam$",list.files(),value=T))`

`fc_se <- featureCounts(mapping_results_se.bam,annot.ext="Drosophila_melanogaster.BDGP6.22.43.gtf",isGTFAnnotationFile=T, GTF.featureType="gene",GTF.attrType="gene_id")`

`mapping_results_pe.bam <- grep("_pe.bam$",list.files(),value=T)`

`fc_pe <- featureCounts(mapping_results_pe.bam,annot.ext="Drosophila_melanogaster.BDGP6.22.43.gtf",isGTFAnnotationFile=T,GTF.featureType="gene",GTF.attrType="gene_id",isPairedEnd=T)`

`> names(fc_pe)
[1] "counts"     "annotation" "targets"    "stat"`

4. exactSNP

测量背景噪音，使用Fisher's Exact tests检测snps；输入bam/sam，和参考基因组，可选及可信的snp数据库资源。

readFile：输入文件bam/sam，对应isBAM=TRUE

refGenomeFile：参考基因序列(FASTA 格式)

SNPAnnotationFile：可选的公开数据库，例如dbSNP，将会用于有助于call snps

`exactSNP("SRR031708.bam",isBAM=T,refGenomeFile="Drosophila_melanogaster.BDGP6.22.dna.toplevel.fa",outputFile="SRR031708.snp.vcf")`

****





