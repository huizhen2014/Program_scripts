####Introduction

 MUMmer软件用于快速比对非大的DNA或者氨基酸序列。该软件使用suffix tree data structure进行有效地模式匹配。该软件包含5个最常用的包，mummer, nucmer, promer, run-mummer1, run-mummer3。

#### Program descriptions

1. Maximal exact matching

mummer流程均有3个主要部分组成，首次在两输入之间识别明确的最大程度的完整匹配，然后将这些匹配聚集成群构建优质的比对anchors，最后在这些聚集成群的比对之间延伸比对实现最终的gapped比对。These match lists have great versatility because they contain huge amounts of information and can be passed forward to other interpretation programs for clustering, analysis, searching, etc.

* mummer， 用于另序列间查询最大的唯一匹配。最适合生成点图描述一系列精确匹配信息。使用至少包含一个ref文件和一个query文件，其都应为multi-Fasta格式，比对过程中区分大小写。

`mummer [options] <reference file> <query file1> … [query file32]`

计算MUMs, Maximal Unique Matcher；默认为-mumreference，三选一

-mum，计算同时满足ref和query的唯一匹配序列

-mumreference，计算ref上唯一匹配，query无需唯一匹配序列

-maxmatch，不考虑ref和query唯一性的条件下，计算匹配序列

当处理masking DNA序列时，使用-n选型可避免匹配到masking字符

-b/-r/-c，-b表示针对正向和反向互补，-r仅反向互补互补序列匹配，-c为描述query反向互补位置时，使用相对于query序列正向的位置；默认仅输出正向的匹配

-F，第一列输出reference的ID

-s，输出匹配序列字符信息

-L，输出匹配query长度

输出头为query名称后Reverse表反向互补匹配，接着为query序列长度；下一行四列分别为，ref ID，ref起点，query起点，延伸长度；再下一行表对应match序列，参数使用为 -s -F -b -L；

![image-20190615225718749](http://ww4.sinaimg.cn/large/006tNc79ly1g428g40r88j30oa052t9h.jpg)

* repeat-match

用于查询单个输入序列中的最大准确重复序列，因此输入文件经针对第一个序列查询重复序列

`repeat-match [options] <sequence file>`

-f，表仅针对正向序列，默认报告正向和反向互补序列匹配情况

-n，指定最小的匹配长度，默认为20

输出文件三列，分别为重复序列的第一，第二位置，以及长度；反向互补重复时，第二位置后加r，表相对于序列正向的位置

![image-20190615225210046](http://ww2.sinaimg.cn/large/006tNc79ly1g428aqy1nlj30ke038aa9.jpg)

* exact-tandems

类似repeat-match，查询单条序列串联重复序列

`exact-tandems <sequence file> <min length>`

![image-20190615225955282](http://ww4.sinaimg.cn/large/006tNc79ly1g428iufn39j30q006odgk.jpg)

输出为tandem起点，重复延伸长度，重复单元长度，重复次数

2. Clustering

MUMmer的clustering算法用于将小的个体匹配聚集成大的匹配。可以绘制对应点图，来查看匹配情况。

* gaps，为run-mummer1主要的clustering算法，实际上更类似一个排序的过程。gaps使用LIS(longest increasing subset)算法来从两序列的匹配中提取最大的连续匹配集合，从而生成单个clustering "straight-line"，不包含重排和颠倒匹配情况。因此run-mummer1适用不包含大量变异的非常类似的两序列文件，仅适用与1对1的序列比对。**如下图仅红色框包含在LIS中，空白框会被丢弃，因此gaps最适合用于比较几乎相同的序列来查询SNPs和indels。**

![image-20190615231034428](http://ww4.sinaimg.cn/large/006tNc79ly1g428twp3fbj30z2076wfe.jpg)

* mgaps用于更好的处理包含大规模重排和重复的序列比对，不同于gaps，mgaps使用full clustering算法，能够输出多重一致性顺序的匹配集合。mgaps主要的优势在于能够识别保守的"islnads"序列，因此可帮助识别大规模重排，重复以及基因家族等，适用与1对多的序列比对。**下图描述的每一独立的clustering使用独立的颜色表示，因此mgaps更使用于整体比对而不是局部位置突变检测。**

![image-20190615232526692](http://ww3.sinaimg.cn/large/006tNc79ly1g4299dgfeqj30y406oab0.jpg)

3. Aliganment generators

实现以上两个步骤maximal exact matching和clustering后，就可以进行alignment过程了。以下程序均独立完成matching和clustering步骤，然后针对每个cluster生成pair-wise比对。每个cluster中的每一个match被用作alignment过程中的anchors，且仅match中的错配才使用Smith-Waterman动态矩阵处理。

* NUCmer

用于比对两个多重近源核酸序列(multiple closely related nuclotiede sequences)。**nucmer常用于决定一套序列contigs相对于ref genome的位置和方向。**该程序首先使用mummer识别Maxima exact matching，然后使用mgaps对个体matches进行clustering，最后自clustering向外延伸增加整体比对覆盖度。

`nucmer [options] <reference file> <query file>`

--mum,--mumreference,--maxmatch，说明同mummer，默认为--mumreference

--mincluster, --minmatch，降低该值将会增加比对敏感性，从而产生一些可信度降低的比对

--maxgap，显著性增加该值(1000)，应用于差异较大的基因组比对

--noextend，会阻止cluster的延伸，从而增加运行速度

--nodelta，将进一步提速，阻止cluster间的比对

--nosimplify，用于非准确性重复序列的检出

nucmer和promer输出同样格式文件，后缀delta

![image-20190616113654133](http://ww3.sinaimg.cn/large/006tNc79ly1g42uegdchwj31bm08kab8.jpg)

第1行为输入比对文件名

第2行为使用的比对程序nucmer/promer

第3行为参与比对的ref和query序列名称，及各自长度

第4行为ref起点终点，query起点终点，如果终点大于起点表示比对到了反向链，接着3列表示，错配数目(indels+snps)，类似错配数目(non-positive match scores，该值针对promer有特殊意义)，终止密码子数目(nucmer时均为0；针对promer输出，对应为起始密码子和终止密码子位置，满足(end-start+1)%3 =0。

接下来的几行描述了插入缺失的之间的距离，正值表示ref出现插入；负值表示ref出现缺失(即query出现插入)。例如promer：1 ， -3 ， 4 ， 0，表示相互之间的距离

![image-20190616114418290](http://ww1.sinaimg.cn/large/006tNc79ly1g42um5kpwfj30mi05kq3g.jpg)

表示ref在1位置出现插入，A；query在位置3出现插入，C；ref在位置7出现了插入，B。

* PROmer

用于比对距离偏远的核酸序列(multiple somewhat divergetn nucleotide sequences)。运行类似nucmer，不同的是首先将输入核酸序列按照6种方式转录成氨基酸序列，敏感度高于nucmer。为保证比对精确性，可能需要mask输入序列避免比对到不感兴趣的序列位置，或者改变uniqueness constraints减少重复带来的比对情况。

`promer [options] <reference file> <query file>`

参数选型类似nucmer，输出格式为delta

--masklen，将位于终止密码子之间的指定数目的氨基酸mask，例如设为4，纳米将mask等于或大于4的长度

`…AAA*AAAA*AAA…` 将mask为 `…AAA*XXXX*AAA…`

--matrix，设置BLOSUM矩阵用于错配打分，1假设量序列差异很大，3假设差异很小

* run-mummer1

同nucmer/promer，matching/clustering/extension，只是run-mummer1采用gaps用于clustering步骤，不允许重排。因此，**更适用于检出SNP和indel**。

`run-mummer1 <reference file> <query file> <prefix> [-r]`

-r，仅比对query反向互补序列，默认为仅比对query的正向序列，ref均为正向序列

**ref和query文件需为fasta格式同时仅含一条序列**，run-mummer1使用简化的打分函数无法识别masking 字符，不推荐对输入文件masking。输出4个文件，分别为out, gaps, errorsgaps, align文件

out文件格式同mumer输出文件，只是不含头文件：

![image-20190616173741496](http://ww3.sinaimg.cn/large/006tNc79gy1g434tuts3fj30nm05sgm6.jpg)

gaps文件：

![image-20190616174022373](http://ww3.sinaimg.cn/large/006tNc79gy1g434wn2k1qj30s807kdgw.jpg)

第一行为参考文件名

第二行前3列通mummer输出

第二行后3列为与上一个match之间的重合信息；当前ref的match起点和上一个match终点之间的gap距离；当前match的match起点和上一个match终点之间的gap距离

**当gap大小为1时，表两序列之间出现了snp；an overlap like seen in the last line of the Consistent matchesindicates the existence of a tandem repeat，这里个人理解为存在"-79"的串联重复序列； "-"表示gap大小无法计算**

![image-20190616180258771](http://ww4.sinaimg.cn/large/006tNc79gy1g435k6medbj30q403e0t5.jpg)

Other matches显示了不包含在LIS中的匹配(like the white boxes in the above image)

errorsgaps文件：

该输出文件为gaps格式的注释版本，可能时run-mummer1用于识别SNPs的最有用文件，最后一列的1表示snp，"-"表示距离太大无法计算

![image-20190616180939834](http://ww2.sinaimg.cn/large/006tNc79gy1g435r5499cj30ry07gjsg.jpg)

align文件：

包含比对信息，可通过"^"字符识别错配，如果比对太大无法显示，则表示为`"*** Too long ***"`，每个错配前后均显示10bp序列。

![image-20190616181352606](http://ww1.sinaimg.cn/large/006tNc79gy1g435vhrqkaj30rm072t99.jpg)

* run-mummer3

run-mummer3的matching和clustering过程同nucmer和promer，只是采用了不同的extension处理。run-mummer3仅能处理单个ref序列，但是query文件可包含多重序列，同时能够检出大大重排。输出格式同run-mummer1，只是align文件中使用"="表示MUM部分。

#### Utilities

* delta-filter

用于出列nucmer和promer输出的delta编码的比对文件。

`delta-filter [options] <delta file> < filtered delat file>`

![image-20190616185948105](http://ww3.sinaimg.cn/large/006tNc79gy1g4377afh6aj31bu05ijsv.jpg)

-g选项输出最长的一致性比对(determine the longest mutually cosistent set of matches)；-r和-q仅要求匹配和ref或query一致即可，主要不同为，-g不允许inversions和translocations，然而-r和-q允许，但是该3个选项均不允许多重重复拷贝。-g参数保证整体一致性；-r保证ref到query的最佳比对(1对多)；-q保证query到ref的最佳比对(多对1)，-r和-q同时使用保证了ref到query1对1的比对。

* show-aligns

show-aligns解析nucmer和promer的delta输出，展示成对比对情况，适合识别准确错配位置，查找两序列间的snps。

`show-aligns [options] <delta file> <IdR> <IdQ>`

IdR为目的ref序列的头标签，IdQ为目的query序列的的头标签

`show-aligns ref_168.delta NC_016845.1 NODE_1_length_366384_cov_31.240309`

![image-20190616190757290](http://ww3.sinaimg.cn/large/006tNc79gy1g437frlrhbj31be0cu40a.jpg)

![image-20190616191047818](http://ww2.sinaimg.cn/large/006tNc79gy1g437iq0qttj30x807ejs5.jpg)

promer输出类似nucmer输出，空白表错配，"+"表相似(positive alignment scores)，"*"表示插入删除。

* show-coords

常用于分析delta输出，用于展示位置，一致性等信息。

`show-coors [options] <delta file>`

-c选项显示覆盖度，-l选项显示线序列长度，在比对两组装contigs时可帮助查看是否比对跨越整个contig

-b选项可帮助识别另基因组间的syntenic区域， biologists usually refer to synteny as the conservation of blocks of order within two sets of chromosomes that are being compared with each other

-g选项仅显示包含在longest ascending subset中的比对信息，推荐和-r或-q一起使用，当在完整的序列上比对代表性reads时有用。(-g option comes in handy when comparing sequences that share a linear alignment relationship, that is there are no rearrangements)

![image-20190616193624473](http://ww1.sinaimg.cn/large/006tNc79gy1g4389df34pj31g809676g.jpg)

* show-snps

用于展示promer/nucmer输出delta文件中包含的snp信息，它将delta文件中的所有snp和indel进行分类。

`show-snps [options] <delta file>`

-c选项将限制输出信息，避免输出重复区域的snps信息，该区域展示的snp是有问题的，可能由于simple repeats，tandem repeats导致，大多数情况应使用-c

-H,-T选项适用于进一步分析

-x用于打印指定ref和query位置位置两侧的序列信息数目，"."表示删除，"-"表示序列末端

![image-20190616195016985](http://ww3.sinaimg.cn/large/006tNc79gy1g438ntbpa4j31v209etbj.jpg)

[p1]为ref上snp位置，若为indel，位置描述为indel前的一个位置，例如，开始位置描述为0；若处在反向互补链，位置描述为反向互补链上indel前一个位置在正向链的位置，例如，反向互补链末端的indel，将描述为1；[P2]对应为query位置

[SUB]对应描述ref和query该位置信息

[BUFF]描述同一比对上该位置到最近错配距离

[DIST]描述该snp到最近序列末端距离

[R]多少个重复比对包含该ref位置； [Q]多少重复比对包含该query位置

[LEN R]ref序列长度；[LEN Q]query序列长度

[FRM]序列或者reading frame方向

以上所有位置均为相对于DNA输入序列正链的位置。

* show-tiling

构建query contigs比对到ref序列的tiling路径，将决定每个query contig的最佳比对位置。由于每个contig将被tiled一次，因此重复区域将该分析过程带来困难。

`show-tiling [options] <delta file>`

-c假设参考序列为环状，同时允许tiled contigs跨越参考序列起点

-i指定最小一致性，nucmer默认90%，promer默认55%

-l指定最小contig长度，默认1

-v设定最小的contig比对覆盖度，nucmer默认90%，promer默认55%；-V设定判断contig一个map优于另一个map的差异值，nucmer默认10%，promer默认30%；为包含最可能的contigs，设置-V为0，同时降低-i和-v值

-u指定输出文件包含为使用的contigs比对信息，格式略!

![image-20190616203851836](http://ww4.sinaimg.cn/large/006tNc79gy1g43a2d43bjj310i0as773.jpg)

![image-20190616205152661](http://ww3.sinaimg.cn/large/006tNc79gy1g43afwjv39j310y08ygnw.jpg)

第1/2列为ref起始终止位置

第3列，该contig和下一contig之间第gap长度

第4/5/6列为该conitg的长度，覆盖度及一致性百分比

第7/8列为contig方向(-表示反向互补序列)和ID

起点位置为负值表示该contig包围了该ref序列起点位置

#### Usage

- 比对两连续序列，然后使用mummerplot查看整体比对情况

`mummer -num -b -c ref.fasta qry.fasta > ref_qry.nums`

`mummerplot --postscript --prefix=ref_qry ref_qry.mums`

`gnuplot ref_qry.gp`

- 比对高度相似无重排序列，用于检测snp和小的indel，同时ref和query仅包含1条序列

`run-mummer1 ref.fasta qry.fasta ref_qry`

`run-mummer1 ref.fasta qry.fasta ref_qry -r `

同样可以使用nucmer进行snp检出

- 含重排的高度相似序列比对，两序列可能含有大段序列重排，颠倒或插入等，ref仅含1条序列，query可含多条序列

`run-mummer3 ref.fasta qry.fasta ref_qry`

- 相当相似的序列比较，run-mummer*着重于差异，而nucmer着重于相似；同时重排，倒置，重复都会被nucmer识别，ref和query可包含多重序列

`nucmer --maxgap=500 --mincluster=100 --prefix=ref_qry ref.fasta qry.fasta`

`show-coords -r ref_qry.delta > ref_qry.coords`

`show-aligns ref_qry.delta refname qryname > ref_qry.aligns`

refname和qryname为fasta序列IDs，同时可使用mummerplot查看，delta-filter过滤输出，例如选择1对1的比对

`delta-filter -q -r ref_qry.delta > ref_qry.filter`

`mummerplot ref_qry.filter -R ref.fasta -Q qry.fasta`

- 相当不相似的序列，promer将转录DNA，然后用于比对，ref和query可包含多重序列

`promer --prefix=ref_qry ref.fasta qry.fasta`

`show-coords -r ref_qry.delta > ref_qry.coords`

`show-aligns -r ref_qry.delta refname qryname > ref_qry.aligns`

以上使用-k选项将输出多重比对的最佳情形；同样可使用mummerplot查看，deleta-filter过滤输出，例如选择1对1的比对

`delta-filter -q -r ref_qry.delta > ref_qry.filter`

`mummerplot ref_qry.filter -R ref.fasta -Q qry.fasta`

- 比对两基因组组装序列，可使用nucmer或promer，分别针对相似或不相似的两fasta文件

`nucmer --prefix=ref_qry ref.fasta qry.fasta`

`show-coords -rcl ref_qry.delta > ref_qry.coords`

`show-aligns ref_qry.delta refname qryname > ref_qry.aligns`

由于多重fasta文件比对输出信息很多，使用delat-filter过滤输出，-r比对位置以ref为准，-q比对位置以query序列为准，-q -r指定输出1对1的比对，同时可使用mummerplot查看比对情况

`mummerplot ref_qry.delta -R ref.fasta -Q qry.fasta --filter —layout`

- 比对组装的scaffolds文件到参考基因组，可用于根据ref基因组判断query contig的位置和方向，帮助完成draft序列组装

`nucmer --prefix=ref_qry ref.fasta qry.fasta`

`show-coords -rcl ref_qry.delta > ref_qry.coords`

`show-aligns ref_qry.delta refname qryname > ref_qry.aligns`

`show-tiling -c ref_qry.delta > ref_qry.tiling`

当ref和query包含多重序列时，show-aligns步骤可重复运行展示比对情况。假如不想比对draft序列到重复的位置，使用delta-filter选择每个draft序列在ref上的最佳位置

`delta-filter -q ref_qry.delta > ref_qry.filter`

- 检出SNPs，比对序列，选择1对1的比对情况，检出SNP位置；nucmer可在存在多个重排的两基因组之间检出SNPs

`nucmer --prefix=ref_qry ref.fasta qry.fasta`

`show-snps -Clr ref_qry.delta > ref_qry.snps`

-C选项指定唯一比对的序列用于检出SNPs，排除了重复序列内的SNPs；或者首先排除重复序列位置；-1，表示1对1允许重排比对，适用于SNP查询

`nucmer --prefix=ref_qry ref.fasta qry.fasta`

`delta-filter -1 -r -q ref_qry.delta > ref_qry.filter`

`show-snps -Clr ref_qry.filter > ref_qry.snps`

- 非精确识别重复序列，尽管mummer并不是设计用于检测重复序列，但是可通过一些参数选择检出重复序列和串联重复序列；可以将序列与自身进行比较，同时设置参数--maxmatch/--nosimplify并且排除两输入序列相同位置的hits，进而得到重复序列输出

`nucmer --maxmatch --nosimplify --prefix=seq_seq seq.fasta seq.fasta`

`show-coords -r -b seq_seq.delta > seq_seq.coords`

查询准确重复长度不低于50的序列

`repeat-match -n 50 seq.fasta > seq.repeats`

查询准确串联重复长度不低于50的序列

`exact-tandems seq.fasta 50 > seq.tandems`





























