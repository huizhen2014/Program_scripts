#####[MEME][http://meme-suite.org/doc/meme.html?man_type=web#sp_search]

MEME用于搜索新的，无间隔(gapped)的motifs(recurring, fixed-length patterns). MEME将多种长度的模型分为两个或多个区分的motifs. motif是一个类似的序列模型, 重复出现在一组相关的序列中.

MEME展示的motifs是一个位置依赖的同时包含字符概率的矩阵, 描述一种模式中每个位置每一种可能字符在每个位置的概率. MEME motifs不包含gaps, 因此具有多种长度gap的模型将被MEME分到2个或多个不同的motif中.

MEME输入一组序列, 输出要求数目的motif. MEME使用统计模型自动选择最佳的宽度, motif出现次数.

网页版MEME可接受第二个输入序列作为control, 然后查询相对于control序列集, 在第一个序列集中富集的motifs, 称为: discriminative motif discovery



##### MEME algorithm overview

首先, 在输入序列中搜索可能的EM起点; 其次, MEME使用EM(**Expectation Maximization**)将所有这样的起点聚集起来; 再次, EM完成聚集后, MEME更新motig的宽度和深度(位置出现数目); 最终, MEME执行'soft'去除过程(用于搜索额外的motifs), 去除所有发现的潜在的最好的motif位置, 以证实该位置是真实可靠的. MEME重复执行以上4步骤查询motifs直到满足停止搜索条件.

##### Input

`<primary sequence file>`

FASTA文件格式输入, 另外需要指定序列类型, -dna, -rna, -protein或-alph. 同时, MEME支持包含weighting值的FASTA格式输入.

##### Output

输出至命名为meme_out的目录中. 可通过-o或-oc选项修改输出目录. 该路径下包含:

* meme.html 提供可读的交互式HTML文件
* meme.txt 文本文件
* meme.xml 可用于machine processing的XML文件
* logoN.png MEME分析得到的PNG/EPS图像, 包含序列logos
* logo_rcN.png 包含反向互补序列的PNG/EPS图像(complementable alphabets only)

MEME输出文件中的positon-specific probability matrix(PSPM)结果可通过FIMO/MAST搜索与之匹配序列.

##### Examples

1. 简单DNA搜素

`meme crp0.s -dna -mod oops -pal`

在包含FASTA格式的输入的DNA序列中搜索单个motif. 

跟据oops位置分布模型, MEME假设每一序列恰好包含一个该motif(该选项最快最敏感, 但是如果输入序列没有将使MEME变得’blurry'; zoops, 对应包含最多一个或没有; anr, 对应包含任意数目非重叠的motif, 可用于检测包含重复多个motif的序列); 默认假设每条序列出现1次或0次

指定pal参数, MEME仅查看存在互补序列的输入数据的回文序列. 在EM过程中, MEME将一同平均letter频率, in complementary columns of the motif(PSPM). 例如, 如果宽度为10, 第一列尾10, 第二列为9, 第三列为8, 将其平均起来; 针对DNA, 该平均过程将会包含所有碱基在一列中的频率; 默认在motif的互补列中不会平均letter频率

![image-20200115110836175](https://tva1.sinaimg.cn/large/006tNbRwgy1gax2kq9tvsj30tr0cytas.jpg)

由于没有指定宽度width, MEME自动选择motif的最佳宽度width

2. 在双链搜索DNA序列

`meme crp0.s -dna -mod oops -revcomp`

选项-revcomp指定MEME在(in a complementable datasets)输入链以及反向互补链搜索motif; 默认仅搜索给定链

3. 快速搜索DNA

`meme crp0.s -dna -mod oops -revcomp -w 2`

仅考虑宽度为20的motif

4. 使用higher-order 背景模型

`meme INO_up800.s -dna -mod anr -revcomp -bfile yeast.nc.6.freq`

参数-mod anr, 指定每个序列中motif可出现任意次数

参数-bfile, Markov model指定使用yeast.nc.6.freq用于背景模型. bfile, the name of Markov background model file, MEME使用背景模型来标准化letters分布偏差, 同时将序列中letters分组. 0-order模型用于调整单个letter偏差; 1-order模型用于调整dimer偏差(例如, DNA序列中的GC含量); 假如-markov_order选项给定了, MEME仅读取bfile中Markov模型中给定的order, 忽略更高order输入.

![image-20200115102445260](https://tva1.sinaimg.cn/large/006tNbRwgy1gax1b0iq61j30cy08ewey.jpg)

使用higher order背景模型会带来更高的检出敏感性. 因为背景模型为更准确的非motif序列, 使MEME在搜索序列时避免这些moitfs.

5. 简单蛋白例子

`meme lipocalin.s -mod oops -maxw 20 -nmotifs 2`

不指定-dna, MEME假设输入为蛋白序列.

-nmoitfs指定搜索2个motifs.

-maxw 每个motif的宽度小于或等于20.

-mod oops 每个序列中motif出现一次

6. 另一蛋白例子

`meme farntrans5.s -mod anr -maxw 40 -maxsites 50`

-maxw 40 /-maxsites 50 在整个输入序列数据中搜索宽度最多为40, 出现次数最多为50的motifs

7. 快速蛋白搜索

`meme farntrans5.s -mod anr -w 10 -maxsites 30 -nmotifs 3`

-nmotifs 指定搜索moitfs数目为3, -w 10宽度为10

8. 将sites分成3部分

`meme farntrans5.s -mod anr -maxw 12 -nsites 24 -nmotifs 3`

-nsites 24/-maxw 12 指定每一个moitf出现24次, 且之多12个字符宽

9. 包含E-value阈值的更大蛋白

`meme adh.s -mod zoops -nmotifs 20 -evt 0.01`

-nmotifs 20/-evt 0.01 查询至多20个motif, 但是当一个motif的E-value大于0.01时, 搜索终止.

***

##### [DREME][http://meme-suite.org/doc/dreme.html?man_type=web]

DREME, Discriminative Regular Expression Motif Elicitation, DREME搜索短的, 无gap的motifs(recurring, fixed-length patterns). 搜索motifs(至多8个位置)相对较短, 对照序列应该和处理序列长度相近, 如果没有提供对照序列, 程序将打乱处理序列作为对照序列. 该软件使用Fisher' Exact Test来判断搜索到的序列的显著性, 可在使用时设置显著性阈值.

##### Input

包含序列的FASTA格式文件, 且所有输入序列应几乎一样长

##### Output

如果未通过`-o`/`-oc`指定, 那么输出到dreme_out目录

* dreme.html 可读的交互式HTML输出格式
* deme.txt 文本格式
* deme.xml 用于machine processing的XML格式文件
* NAMEnc_CONSENSUS.png DREME搜索到的moitfs的序列logo PNG图片
* NAMErc_CONSENSUS.png 为motifs的反向互补序列

##### Options

`-p` primary sequence file

`-n` control sequence file

`-dna/-rna/-protein/-alph` 输入文件格式

`-norc` 仅搜索指定的primary文件; 默认搜索输入序列和其反向互补序列(when the alphabet is complementable)

`-g` 设置指定数目REs; 默认100REs

`-e/-m/-t` 指定停止搜索时条件, motif's E-value > e/ m motifs/ t seconds; 默认为e为0.05, 其余无

`-mink/-maxk/-k` 设置最小/最大/固定motif core宽度, 默认为3-7

***

##### [MEME-ChIP][http://meme-suite.org/doc/meme-chip.html?man_type=web]

`meme-chip [options] [-db <motif file>]* <primary sequence file>`

MEME-ChIP针对一组大的序列, 例如ChIP-seq/CLIP-seq实验获得的, 进行综合性的motif分析(包含motif搜索). 注意, 输入序列应该在中心的100字符区域内包含motifs(the input sequences should be centered on a 100 character region expected to contain motifs).

MEME-ChIP:

1. 在输入序列默认中心区域100bp内发现新的DNA结合motifs(with MEME and DREME)
2. 判断哪些motifs是最集中富集的(with CentriMo)
3. 分析相似性以获得结合的motifs(with Tomtom)
4. 同时, 根据相似性自动将显著性motifs聚集
5. 执行motif spacing分析(with SpaMo)

![image-20200115155626955](https://tva1.sinaimg.cn/large/006tNbRwgy1gaxaw4u2s4j30jv06dq3a.jpg)

6. 构建GFF文件用于基因组范围查看

##### Input

`[-db <motif file>]*`

推荐的可选参数, 一个或多个包含MEME formattd motifs的文件. 支持来自MEME/DREME的输出, 同时还有Minimal MEME Format. 也可以通过[脚本][http://meme-suite.org/doc/overview.html#motif_conversion_utilities]将任何motifs格式转换为MEME Motif格式. 这些motif文件将用于Tomtom和CentriMo

`<primary sequence file>`

FASTA格式序列文件. 理想条件下, 所有序列应该都是一样长, 为100-500bp且motifs位于序列中心区域. 理想输入为, 来自转录因子(TF) ChIP-seq实验的当个ChIP-seq 'peak'的临近区域. 建议采用的最小100bp为一般ChIP-seq peaks的典型分辨情况, 含有跟多的围绕序列有利于CentriMo判断motifs是否中心富集. 推荐, 'repak mask'输入序列, 同时使用'N'代替重复序列

##### Output

输出为memechip_out文件夹.

* meme-chip.html 提供可读交互式网页HTML文件
* summary.tsv 可用于脚本解析和Excel查看的TSV结果格式
* combined.meme 包含MEME Motif Format的文本文件

#####Options

`-db` 使用MEME Motif Format格式的DNA motifs文件. 该文件将用于Tomtom和CentriMo分析, 可指定多次传递多个文件; When no files are provided, Tomtom can't suggest similar motifs and CentriMo is limited to the discovered motifs.

`-neg` 查询primary序列相对于该输入文件(fasta 格式)的moitfs. 这些序列将会用做control序列输入到MEME, DREME和CentriMo. MEME使用其‘Differential Enrichement' objective函数. 当使用该选项时, primary和control序列应该是相同长度; 否则CentrioMo E-values将不会准确. 如果, primary序列为转录因子ChIP-seq peak区域, 类似的来自knockout细胞系或生物的区域为一可能的control序列选择; 默认, 没有control序列用于MEME或CentrioMo, MEME使用`Classic` objective函数. 针对DREME, positive sequences大乱, 保留双核苷酸频率, 用于构建control set.

`-psp-gen` 使[pop-gen][http://meme-suite.org/doc/psp-gen.html]构建[positon-specific prior][http://meme-suite.org/doc/psp-format.html]用于MEME分析. MEME将使用该先验值和‘Classic` objective`函数, 而不是`Differential Enrichment` objective function; 默认MEME通过`Differential Enrichment`直接采用control序列, 不构建position-specific prior. 注意, 该选项需要`-neg`参数

`-ccut` 针对MEME和DREME输入, 针对其中心区域nbp裁剪序列.(全长序列输入至CentrioMo和SpaMo). 0表示不裁剪; 默认为100

`-norc`仅在给定序列链搜索; 默认给定序列链及其互补链

##### MEME Specific Options

`-meme-minw/-meme-maxw` 最小最大motif宽度; 默认为6-30

`-meme-nmotifs` MEME搜索motifs数目, 默认为3, 指定为0将不运行MEME

`-meme-minsites/-meme-maxsites` 针对一个motif, MEME需要满足的最小/最大查询到的位置数目; 默认没限制

`-meme-pal` 限制MEME仅搜索回文序列

##### DREME Specific Options

`-dreme-e/-dreme-m` 停止搜索时的最大E-value和数目

##### CentriMo Specific Options

`-centrimo-local` CentriMo执行local motif富集分析, 计算每一个可能序列区域的富集情况; 默认仅执行central motif富集分析, 针对中心区域计算富集情况

`-centriomo-score` 接受匹配的最小值; 默认为5

`-centriomo-maxreg` 最大检测区域值; 默认为所有有效区域

`-centriomo-ethresh` 满足富集的中心区域的E值; 默认为10

##### SpaMo Specific Options

`-spamo-skip` 跳过SpaMo

##### FIMO Specific Options

`-fimo-skip` 跳过FIMO

##### Example

















































