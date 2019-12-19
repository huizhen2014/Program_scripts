####[ChIPQC][http://www.bioconductor.org/packages/release/bioc/html/ChIPQC.html]

简单生成ChIP-seq实验或者样本的QC报告:

`samples` 包含样本sheet

![image-20191219192648852](https://tva1.sinaimg.cn/large/006tNbRwgy1ga298phu7jj30t202y0t0.jpg)

默认条件下, HTML报告以及相关图片将会输出至子目录, `ChIPQCreport`, [例如][http://chipqc.starkhome.com/Reports/tamoxifen/ChIPQC.html]

或者单个bam文件

![image-20191219193007340](https://tva1.sinaimg.cn/large/006tNbRwgy1ga29c5hsh8j317p04c3z6.jpg)

1. Experiment sample sheet

第一步时构建样本sheet, 描述ChIP-seq实验. 可以是一个数据框或保存为一个csv文件. 同样该实验可以使用DiffBind包构建为DBA对象

![image-20191219193447425](https://tva1.sinaimg.cn/large/006tNbRwgy1ga29h0n4jrj31cs07wgoj.jpg)

该样本sheet详述了实验数据, 同时也包含文件路径, 比对reads和called peaks. 另外, 若为csv格式文件, 可直接传递給`ChIPQC`

2. Constructing a `ChIPQCexperiment` object

`ChIPQC`接受一个样本sheet和一些可选参数, 针对每个样本计算质量值. It does this using the BiocParallel package, which by default will run in parallel, using all available cores on your machine.

`annotation` 指明分析的基因组

`chromosomes`指明需分析计算的染色体

`mapQCth` 表明过滤比对质量的阈值, 默认为15

`blacklist` 为一个文件或`GRanges`对象, 表示将这些区域的reads过滤掉

`exampleExp <- ChIPQC(samples, annotation="hg19")`

3. Quality metrics summary

![image-20191219195839121](https://tva1.sinaimg.cn/large/006tNbRwgy1ga2a5ukdioj30zc0fcdjc.jpg)

第一行描述样本数量, 以下信息可通过函数`QCmetrics(exampleExp)`获得

![image-20191219200627117](https://tva1.sinaimg.cn/large/006tNbRwgy1ga2adyhil4j30ya07qdhw.jpg)

`Dup%`: 至少包含一个其他read比对到基因组确切位置的read比率(The percentage of reads that map to the exact position in the genome as at least one other read is the reported). 上图, 可见重复率具有很大的变异, **好的ChIPs质量数据,期待狭窄地结合的转录因子拥有很高的富集度的区域, 该区域将包含来自相同位置的片段. 当因子具有很高的结合性时, 就会产生具有生物学意义的'duplicate'片段.**

read长度, 源于bam文件数据, 随后为评估的平均片段长度. 片段长度是通过chipseq包, 系统性相互朝向地shift每条链上的reads直到实现最小的基因组覆盖度(estimated by methods in implemented in the chipseq package by systematically shifting the reads on each strand towards each other until minimum genome coverage is achived). 

`RelCC`为`RelativeCC`, 通过比较maximum cross coverage peak(at the shift size corresponding to the fragment length)和 the cross coverage at a shift size corresponding to the read length, 较高的值代表好的实验(一般大于等于1)

`SSD` 为htSeq Tools采用的另一个富集证据. It is computed by looking at the standard deviation of signal pile-up along the genome normalised to the total number of reads. 富集的样本典型性拥有显著性pile-up区域, 因此更高的SSD值越能代表好的富集结果.

`RiP%` 代表了跨越called peak的reads的百分率(也称为FRIP). 可认为是'signal-to-noise' 比值, 表示来自结合位置的片段reads比上背景reads. `RiP%`值针对ChIPs一般在5%或更高表示富集成功.

`RiBL%` 为reads落在blacklist区域的reads比率. 来自blacklisted的信号能够混淆peak callers和片段长度评估...

![image-20191219204038509](https://tva1.sinaimg.cn/large/006tNbRwgy1ga2bdj0cxdj30oh079myo.jpg)

4. Generating a summary QC report for experimental sample groups

`ChIPQCreport(exampleExp)`

[Report][http://ChIPQC.starkhome.com/ Reports/exampleExp/ChIPQC.html.]







