#### [MACS2][https://github.com/taoliu/MACS]

Model-based Analysis of ChIP-Seq(MACS), 识别转录因子结合位点. 通过集合序列标签位置和方向提高结合位置的空间分辨率. 可简单用于单个ChIP-Seq数据或通过指控样本增加检出特异性.

![macs2_workflow](https://tva1.sinaimg.cn/large/006tNbRwgy1g9juaibaidj30qf0k4jtw.jpg)

Moreove, as a general peak-caller, MACS can also be applied to any 'DNA enrichment assays' if the question to be asked is simply: where we can find significant reads coverage than the random backgound.

##### Usage

```bash
macs2 [-h] [--version]
    {callpeak,bdgpeakcall,bdgbroadcall,bdgcmp,bdgopt,cmbreps,bdgdiff,filterdup,predictd,pileup,randsample,refinepeak}
```

![ChIP_seq_mechanism](https://tva1.sinaimg.cn/large/006tNbRwgy1g9juc0k927j307l08tdfy.jpg)

ChIP-Seq的分析方法可以鉴定两种类型的富集模式:broad domains和narrow peaks. broad domains, 如组蛋白修饰在整个基因body区域的分布; narrow peak, 如转录因子的结合. narrow peak相对于broad或分散的marks更易被检测到. 也有一些混合的结合图谱, 如Poll包括narrow和broad信号.

regular peak calling:

`macs2 callpeak -t ChIP.bam -c Control.bam -f BAM -g hs -n test -B -q 0.01`

broad peak calling:

`macs2 callpeak -t ChIP.bam -c Control.bam --broad -g hs --broad-cutoff 0.1`

MACS2包含12个功能, 略, 这里仅介绍`callpeak`, 其余`macs2 COMMAND -H`

##### Enssential Options

-t / --treatment FILENAME 是MACS唯一的查询参数, 其文件支持格式通过`--format`参数指定, 多个比对文件`-t A B C`, MACS将这三个文件一起处理

-c / --control control或mock数据文件. 同`-t / --treatment`

-n / --name 实验的名称. MACS使用该NAME创建输出文件名: NAME_peaks.xls, NAME_negative_peaks.xls, NAME_peaks.bed, NAME_summits.bed, NAME_modle.r 

--outdir 指定输出文件夹

-f / --format FORMAT tag文件的格式, 可以为:ELAND, BED, ELANDNULTI, ELANDEXPORT, ELANDMULTIPER(for pair-end tags), SAM, BAM, BOWTIE, BAMPE, BEDPE. 默认为AUTO, MACS自动识别, 尤其当同时包含多个输入时.

当前最常用的为BED或SAM/BAM

###### [BED][http://genome.ucsc.edu/FAQ/FAQformat#format1]

该格式需要至少包含, 1s: chromome name, 2nd: start position(The first base in a chromosome is numbered 0), 3rd: end position, 6th: strand

###### [SAM/BAM][http://www.htslib.org/doc/samtools.html]

若为BAM的paired-end数据, MACS

###### BEDPE/BAMPE

此时, MACS2将BAM/BED文件看作paired-end数据. MACS2使用实际插入片段构建fragment pileup, 而不是根据正/负方向reads的二项式分布来预测插入片段长度. BAMPE格式为包含paired-end比对信息的BAM格式文件, 源自BWA或BOWTIE

可使用MACS2 randsample将paired-end信息的BAM文件转换为BEDPE格式:

```bash
macs2 randsample -i the_BAMPE_file.bam -f BAMPE -p 100 -o the_BEDPE_file.bed
```

-g / --gsize 根据实际情况设置该参数, 用于指定比对基因组大小或有效基因组大小. 由于存在重复序列, 因此实际基因组大小会比原始大小要小, 约等其基因组大小的90%或70%. 可使用k-mer工具(jellyfish)来计算有效基因组长度, 些许差异不会带来很大影响...

-s / --tsize 测序标签(sequencing tags)的大小, 若未指定, MACS使用前10个序列来判断标签长度大小(uniquely mapped read)

-q / --qvalue 显著性区域的q-value(minimum FDR)阈值, 默认为0.05. Q-values是使用Benjamini-Hochberg处理p-values得来的

-p / --pvalue p-value阈值, 未指定, 将使用p-value而不是q-value

-m / --mfold MFOLD MFOLD 选择富集差异位于该范围内的区域用于构建model, 预测d值. 默认为5 50;可选-m 10 30 

--min-length / --max-gap 用于指定peak的最小长度和合并两个临近区域之间允许的最大gap长度. 默认采用预测的片段长度为min-length, max-gap为reads长度. 针对BROAD peak calling, 尝试大的值例如500bp, 也可以使用‘--cutoff-analysis’加默认设置, 选择合理的min-length值

--nolambda 使用该参数时, MACS使用backgroud lambda作为local lambda. 这意味着MACS不会考虑peak candidate区域local bias(泊松分布,期望和方差均为$\lambda$)

--slocal, --llocal These two parameters control which two levels of regions will be checked around the peak regions to calculate the maximum lambda as local lambda. By default, MACS will considers 1000bp for small local region(--slocal), and 10000bps for large local region(--llocal) which captures the bias from a long-range like an open chromatin domain. **You can tweak these according to your project. Remember that if the region is set too small, a sharp spike in the input data may kill a significant peak. **

--nomodel 使用该参数, MACS将绕开构建shifting model 环节

--extsize 当设置--nomodel时, MACS使用该参数向reads的5‘-3’方向延伸至fix-sized fragments. 例如, 针对转录因子的结合区域的大小为200bp, 同时想要取消MACS构建model, 该参数可被设置为200. 该选项只有当设置--nomodel时才有效, 或当MACS构建model失败同时--fix-bimodal选项开启

--shift  这里可以选择任意shift bp长度. 当使用非0时需要酌情处理(other than the default value, 0). 当`--nomodel`设置时, MACS使用该值去除ends(5'), 接着使用`-extsize`从5‘到3’方向延伸(when --nomodel is set, MACS will use this value to move cutting ends(5') then apply `--extsize` from 5‘ to 3' direction to extend them to fragments. When this value is negative, ends will be moved toward 3'-5' direction, otherwise 5'-3' direction). 推荐在使用ChIP-Seq数据时保持默认值0), or -1 * half of EXTSIZE together with `--extsize` option for detecting enriched cutting loci such as certain DNAsel-Seq datasets. Note, you can't set values other than 0 if the format is BAMPE or BEDPE for paired-end data. The dafult is 0

--keep-dup 在相同位置(相同的方向和相同的链), MACS将保留的duplicate tags数目. 默认时在相同位置保留一个, default:1

--broad 当选择该选项时, 通过采用宽松阈值将附近高富集区域放进一个broad区域来尝试构成broad regions in BED12(a gene-model-like format). Broad region 通过另一个阈值`--broad-cutoff`来控制. broad region的最大长度为MACS的d的4倍. 默认为:False

--broad-off broad region的阈值. 只有设置了`--broad`  时该选项才有意义.  若设置了`-p` , 为p-value阈值, 否则, 为q-value阈值. 默认为: 0.1

--scale-to <large|small> 当设置为'large'时, 将较小的数据集线性成为较大的数据集. 默认或设置为'small'时, 更大的数据集将会缩小的更小的数据集. 注意, 将小数据集扩大可能带来假阳性

-B / --bdg 若设置该选线, MACS will store the fragment pileup, control lambda in bedGraph files. The bedGraph files will be stored in the current directory names `NAME_treat_pileup.bdg` for treatment data, `NAME_control_lambda.bdg` for local lambda values from control. 

--call-summits MACS will now reanalyze the shape of signal profile(p or q-score depending on the cutoff setting) to deconvolve subpeaks within each peak called from the general procedure. It's highly recommanded to detect adjacent binding events. While used, the output sub peaks of a big peak region will have the same peak boundaries, and different scores and peak summit positions

#### Output files

`NAME_peaks.xls`为包含检测峰的表格信息:

* 染色体名称
* 峰起点
* 峰终点
* 峰区域长度
* 峰顶点绝对位置
* 峰顶点的堆积高度
* 峰顶点的-log10(pvalue)
* 该峰顶点相对于随机泊松分布(with local lambda)的富集倍数
* 峰顶点的-log10(qvalue)

该xls文件中位置为1-based, 不同于BED文件; 当采用`--broad`参数时, 用于检出broad peak, 那么pileup, p-value, q-value, fold change将会是这个整个峰区域的平均值, 因为在检出broad peaks时不会检出峰顶点

`NAME_peaks.narrowPeak` 为BED6+4格式文件, 包含峰位置和峰顶点信息, p-value, q-value:

![image-20191204194036947](https://tva1.sinaimg.cn/large/006tNbRwgy1g9kxci3mkoj30ov06lgnb.jpg)

可直接使用[UCSC genome browser][http://hgdownload.cse.ucsc.edu/admin/exe/macOSX.x86_64/]读取. Remove the beginning track line if you want to analyze it by other tools

`NAME_summits.bed` BED格式, 包含所有峰的峰顶点位置. 其中第5th列同`NAME_peaks.narrowPeak`. 推荐使用该文件查询结合位点的motif. 该文件也可以使用UCSC genome browser读取. Remove the beginning track line if you want to analyze it by other tools

`NAME_peaks.broadPeak` 为BED6+3格式, 类似`narrowPeak`文件,但不含邮第十行的峰顶点的注释信息. 该文件和`gappedPeak`仅当`--broad`选项使用时才会生成.

`NAME_peaks.gappedPeak` 为BED12+3格式, 包含broad region和narrow peaks.:

![image-20191204194644465](https://tva1.sinaimg.cn/large/006tNbRwgy1g9kxitrds1j30pj04wq4o.jpg)

`NAME_model.r` 为R脚本, 用于生成PDF图像文件展示model: `R NAME_model.r`

`NAME_treat_pileup.bdg`和`NAME_control_lambda.bdg`文件为bedGraph格式, 可导入UCSC genome browser或转换为更小的bigWig文件:
![image-20191204195010111](https://tva1.sinaimg.cn/large/006tNbRwgy1g9kxmdzmiqj30pw043gn3.jpg)

#### Tips of fine-tuning peak calling

1. `bdgcmp`可用于`*_treat_pileup.bdg`和`*_control_lambda.bdg`或其他来源的bedGraph文件, 计算score track
2. `bdgpeakcall`可用于`*_treat_pvalue.bdg`或其他bdgcmp/bedGraph文件生成的文件, 根据指定阈值, 最大gap距离, 最小峰长度来检出峰. bdgbroadcall和bdgpeakcall用法类似, 只是输出BED12格式的`_broad_peaks.bed`
3. 差异检出工具`bdgdiff`, 可用于4个bedGraph文件, 包含treatment1/control1, treatment2/control2, treatment1/treatment2, treatment2/treatment1 比值. 根据最短长度, 最大gap和阈值输出一致性和唯一位置
4. You can combine subcommands to do a step-by-step peak calling. Read detail at [MACS2 wikipage][https://github.com/taoliu/MACS/wiki/Advanced%3A-Call-peaks-using-MACS2-subcommands]

#### Miscellaneous

![1](https://tva1.sinaimg.cn/large/006tNbRwgy1g9kxyti2orj30fd09877p.jpg)

#####Call peaks

![call_peaks](https://tva1.sinaimg.cn/large/006tNbRwgy1g9ky040lj8j30bw0bsgnj.jpg)

#####Peaks / d

![peaks_d](https://tva1.sinaimg.cn/large/006tNbRwgy1g9ky13cirtj30c30903za.jpg)

***

#### [Evaluating ChIP-seq data][ChIP-seq guidelines and practices of the ENCODE and modENCODE consortia ]

##### Browser inspection and previously known sites

使用IGV查看, 尽管无法定量, 但是对于一个已知的结合位点, 相对于对照的read分布可用来检查. 真实的信号将显示一个非对称的reads比对分布. 可利用该方法检查有限个最强的信号位点.

##### Library complexity

NRF: 数据集中nonredundant mapped reads的比例

![image-20191209155055528](https://tva1.sinaimg.cn/large/006tNbRwgy1g9qit0e7cxj30uh09imzp.jpg)

##### Measuring global ChIP enrichment(FRiP)

一般而言, 只有少部分reads比对到了显著性富集区域. 因此, 比对到峰区域的reads比例为一简单的指控指标, 称为: fraction of reads in peaks, FRiP. **一般而言, FRiP值和所检出区域正比且线性相关,  使用MACS默认参数检验哺乳动物时, FRiP富集比例在1%以上.** 但是, 高于该阈值并不意味着实验成功, 低于该阈值也不意味着实验失败.

![image-20191209151406638](https://tva1.sinaimg.cn/large/006tNbRwgy1g9qhqpf8klj30el0d443k.jpg)

##### Cross-correlation analysis

ChIP-seq一个有用的质控指标是检出峰独立性且是链交叉相关的(strand cross-correlation). 也就是说, 显著性富集位点富集的DNA序列tags标签(富集区域的reads)是以结合位点为中心, 同时分布比对到正负链的. 因此, 该质控标准基于基因组范围上tags的密度来量化其片段的聚集(IP clustering). 其计算为Crick链和Watson链的Person线性相关性.

![image-20191209100409383](https://tva1.sinaimg.cn/large/006tNbRwgy1g9q8s8ap1yj30ey08fmy8.jpg)

It is computated as the Person linear correlation between the Crick and the Waston strand, after shifting Waston by $k$ base pairs. **This typically produces two peaks when cross-correlation is plotted against the shift value: a peak of enrichment corresponding to the predominant fragment length and a peak corresponding to the read length("phantom" peak).**

**Reads are shifted in the direction of the strand they map to by an increasing number of base pairs and the Person correlaiton between the per-position read count vectors for each strand is calculated.** 也就是每个链每个位置的read count的向量之间的相关性系数:

链移动为0时: Person=0.539

![NSC_1](https://tva1.sinaimg.cn/large/006tNbRwgy1g9qdyma2kvj30u00fedgf.jpg)

链位移5bp时: Person=0.931

![NSC_2](https://tva1.sinaimg.cn/large/006tNbRwgy1g9qdzciovvj30u00f7gm7.jpg)

fragment-length cross-correlation peak 和 background cross-correlation(normalized strand coefficient, NSC)标准化后的比例, fragment-length peak and the read-length peak(relative strand correlation, RSC)标准化后比例, 是ChIP-Seq有力的信噪比指标. 高质量的测序数据集倾向于较大的fragment-length peak 比 read-length peak. 

![image-20191209101744860](https://tva1.sinaimg.cn/large/006tNbRwgy1g9q96c90ecj30oh09ljvg.jpg)

**ENCODE: NSC > 1.05 and RSC > 0.8 for point source TFs.**

##### Consistency of replicates: Analysis using IDR

DR, irreproducible discovery rate

给定一对重复数据集, 它们检出的峰可以根据显著性(p-value, q-value), ChIP-to-input enrichment, 或者每个峰的reads覆盖度排序(be ranked). 假如两个重复样本位于相同的生物条件下, 最显著性的峰(likely to be genuine signals) 应该具有最高的一致性, 而低显著性的峰(likely to be noise), 应表现出低的一致性. 

![image-20191209114209730](https://tva1.sinaimg.cn/large/006tNbRwgy1g9qbm6e9j3j30mq07dn23.jpg)

This consistency transition provides an internal indicator of the change from signal to noise and suggests how many peaks have been reliably detected.

**Increased consistency comes from the fact that IDR uses information from replicates, whereas the FDR is computed on each replicate independently.**



  

























