####[PacBio][https://www.jianshu.com/p/15dd0baca47c]

![15455040-df20a055e3cac3c6](https://tva1.sinaimg.cn/large/006y8mN6gy1g95yjjwaslj30ma0c8gwe.jpg)



PacBio数据的文库模型是两端加街头的哑铃型结构, 测序时会环绕着文库进行持续的进行, 由此得到的测序片段称为polymerase reads, 即一条含接头的测序序列, 其长度由反应酶的活性和上机时间决定. 

![15455040-0699da4bf72bb6c9](https://tva1.sinaimg.cn/large/006y8mN6gy1g95ypvpofxj30fe03jt9e.jpg)

polymerase reads是需要进行一定的处理才能获得用于后续分析的数据的. 该过程首先去除低质量序列和接头序列:

![15455040-674604d2963748d6](https://tva1.sinaimg.cn/large/006y8mN6gy1g95yp18okej30fd054jro.jpg)

处理后得到的序列称为subreads, 根据不同文库的插入片段长度, subreads的类型也有所不同.

在用于基因组denovo组装时, 通常会构建10kb/20kb的文库, 对长长插入片段文库的测序基本时少于2 passes的(pass即环绕测序的次数, 两个adapters之间就是一个pass). 这时得到的reads也称为Continuous Long Reads(CLR), 这样的reads测序错误率等同于原始的测序错误率.

![image-20191121204215508](https://tva1.sinaimg.cn/large/006y8mN6gy1g95y2l7lg6j31ca06odiu.jpg)

而对于全长转录本或全长16s测序, 构建的文库插入片段较短, 测序会产生多个passes, 这时会对多个reads进行一致性校正, 得到一个唯一的read, 也称为Circular Consensus Sequencing(CCS) Reads, 这样的reads测序准确率会有显著的提升.

![image-20191121204509273](https://tva1.sinaimg.cn/large/006y8mN6gy1g95y5lssscj31ay08gdj3.jpg)

不同于二代测序的碱基质量标准Q20/Q30, 三代测序由于其随机分布的碱基错误率, 其单碱基的准确性不能直接用于衡量数据质量.

最直接的方法就是看长度. 长度短的测序数据不一定差(与文库大小有关), 但差的数据长度一定短. 上游实验环节, 最关键影响因素时文库的构建, 高质量的文库产出的数据长度长, 质量好; 而低质量的文库产出的数据长度短, 质量差. 另外其测序错误时随机的, 不像二代测序技术那样存在测序错误的偏向, 因而可以通过多次测序来进行有效纠错.

![15455040-b9511cd72c43ba9f](https://tva1.sinaimg.cn/large/006y8mN6gy1g95yqbt25aj30fd06eta8.jpg)

其次, 看比率. 需关注两个比例, 一个是subreads与polymerase reads数据量的比例, 比例过低反应测序过程中的低质量的序列较多; 一个是zmw孔载入的比率, 根据孔中载入的DNA片段数分为P0, P1, P2. P1合理的比例在40%-60%之间. 上样浓度异常会导致P0或P2比例过高, 有效数据量减少. 需要注意的是P2比例过低时, 可能存在P2转P1的情况, 测序结果包含较多的嵌合型reads.

![15455040-58762878c133adc2](https://tva1.sinaimg.cn/large/006y8mN6gy1g95yqu3pkcj30fd08kjt1.jpg)

通过检测相邻两个碱基之间的测序时间, 来检测一些碱基修饰情况, 即如果碱基存在修饰, 则通过聚合酶时的速度会减慢, 相邻两峰之间的距离增大, 可以通过这个来直接检测甲基化等信息.

![15455040-659857f5afa35691](https://tva1.sinaimg.cn/large/006y8mN6gy1g95ymufz93j30no0cmtfr.jpg)

#### 组装

PacBio-only de novo assembly: 只使用PacBio产生的long reads进行拼接, 在拼接之前要进行预处理, 然后采用Overlap-Layout-Consensus算法进行拼接

Hybrid de novo assembly: 结合PacBio的长reads和二代的短reads

Gap filling: 使用二代的短reads拼接得到的scaffold, 然后用PacBio的长reads进行补洞

Scaffolding: 用二代的短reads拼接得到的contigs/scaffold, 用PacBio的长reads确定contigs/scaffold之间的位置关系

![15455040-3bf03959b596fc9e](https://tva1.sinaimg.cn/large/006y8mN6gy1g95yuh8xtrj311k0hbdgt.jpg)

不同组装策略可选用工具:

PacBio-only

HGCA: 先进行reads的预组装(preassembly), 然后用Celera Assembler进行进一步组装, 最后用Quiver进行校正

Canu: 以Celera Assambler为基础, 为三代单分子测序而开发的分支工具

Celera Assembler: Celera Assembler 8.1已经可以直接用于subreads的组装

Hybrid

SPAdes: 3.0版本后增加了对PacBio的混合组装支持

Gap Filling

PBJelly2: 对已经组装后的基因组, 用PacBio的long reads进行补洞

![15455040-5a9505bda7afed07](https://tva1.sinaimg.cn/large/006y8mN6gy1g96r9v700oj30y60oh10l.jpg)

三代单分子测序会产生较高的随机错误, 平均正确率在82.1%-84.6%, 这么高的错误率显然不能直接用于后续的分析, 需要进行错误校正:

* 多测几个pass: 由于测序序列时发夹结构, 可以进行多轮的滚环测序, 靠覆盖度来自我交错, 如果通量不是限制因素, 那么PacBio时目前最准确的测序方式: 错误率可以无限接近罕见突变的发生率(即无法分辨时测序错误还是罕见突变), 不过这会极大缩短有效测序的插入序列长度
* 用二代的短reads校正: 2012年冷泉港实验室的Michael Schatz开发了一种纠错算法, 用二代测序的短读长高精确数据对三代读长数据进行接错, 这种称为"混合纠错拼接"(PBcR (PacBio corrected Reads)algorithm)

* Map short reads to long reads
* Trim long reads at coverage gaps
* Computer consensus for each long read

![15455040-b0aaff1586cd4009](https://tva1.sinaimg.cn/large/006y8mN6gy1g96rgnn0gbj30s614xtej.jpg)















































