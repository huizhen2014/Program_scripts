

#### [Blast][https://www.ncbi.nlm.nih.gov/books/NBK279684/]

[BLAST](https://www.baidu.com/s?wd=BLAST&tn=SE_PcZhidaonwhc_ngpagmjz&rsv_dl=gh_pc_zhidao) (Basic Local Alignment Search Tool)是一套在蛋白质数据库或DNA数据库中进行相似性比较的分析工具；对一条或多条序列(可以是任何形式的序列)在一个或多个核酸或蛋白序列库中进行比对。

#### Usage

1. Create blast database

-dbtype: nucl  指定为核酸数据库

-parse_seqids: parse seqid for FASTA

-hash_index: create index of sequence hash values

`makeblastdb -in blaKPC-2.fsa -hash_index -dbtype nucl -out databases/blaKPC-2`

2. blastn，搜索核酸数据库

-evalue: 1e-3，表示10的-3次方，e表这是一种指数形式的计数方法。由数符、十进制数、阶码标志'E'或'e'以及阶符和阶码组成

S: S值表示两个序列的同源性，分值越高，表示它们之间的相似程度越大

E: E值表示S值的可靠性，表示随机条件下，其他序列能和目标序列相似程度大于S值的可能行，所以该值越小越好

`E=K*m*n(e^-lambada*S), K和lambada与数据库及算法有关，常量；m代表目标序列的长度，n代表数据库的大小，S就是前面提到的S值`

E值局限性：1. 当目标序列过小是，E值偏大，因无法的到较高S值；2. 在有gap情况下，两序列同源性高，但S值会下降；3. 序列非功能区域的有较低随机性，可能会导致两序列较高同源性

btop: 简述比对情况，数字表示匹配；GA表示G变成了A；-表示gap；* tblastx表示gap

-outfmt，0表示成对比较输出；6/7/8可额外指定输出格式

-sorthits，指定hits的排序，0表evalue，1表bit score，2表total score，3表一致性比率，4表覆盖度

-max_target_seqs，选择输出匹配数目，推荐5条或更多

`blastn -evalue 1e-5 -max_target_seqs 1 -db databases/blaKPC-2 -query query.fasta -outfmt "6 qseqid qstart qend sseqid sstart send length pident mismatch gapopen bitscore evalue btop" > query_kp-2.blastn `

3. tblastx，在蛋白数据库搜索DNA序列(nucletode vs nucletide by peptides)

首先同样构建nucl数据库，然后再构建一个prot数据库

`makeblastdb -in blaKPC-2.fsa -hash_index -dbtype prot -out databases/blaKPC-2`

最后比对，参数同blastn

-query_genecode, 指定query转录方式，微生物为11

-db_genecode，指定subject转录方法，微生物为11

`tblastx -evalue 1e-3 -db databases/blaKPC-2 -query_gencode 11 -db_gencode 11 -query query.fasta -max_target_seqs 5 -outfmt "6 qseqid qlen qstart qend sseqid slen sstart send length pident mismatch gapopen bitscore evalue btop" > query_kpc-2.tblastx`

#### Diamond

DIAMOND用于蛋白和转录后的DNA序列比对，用于测序数据：

* 成对比较蛋白和转录后到DNA序列，速度是BLAST的500到20000倍
* 可针对长read分析做移码比对
* 多种输出格式，包括BLAST pairwise, tabular和XML

#### Usage

使用方法类似blast

1. makedb，从fasta个数输入文件构建DIAMOND格式的参考数据库

-db/-d file 指定输出数据库文件

`diamond makedb --in nr.faa -d nr`

2. blastp，比对蛋白输入序列；blastx，比对转录后的DNA输入序列，默认输出BLAST tabular格式

--query-gencode，指定blastx用于转录的遗传密码子

--strand，both/plus/minus，指定query序列的链用于比对，默认为both

--min-orf/-l，忽略转录后包含小于该长度ORF的序列，设置为1将取消该参数作用

--sensitive，该比对方式敏感性更佳，用于长read比对；默认方式用于短read比对，例如30-40氨基酸序列，显著性比对>50 bits；—more-sensitive，更敏感比对

--frameshift/-F，针对DNA-vs-protein比对的移码罚分，数值在15作用。该参数推荐用于长，倾向于发生indel的序列，例如MinION reads，\和/对应转录方向+1/-1的移码

--matrix，打分矩阵，默认为BLOSUM62

--outfmt/-f，输出格式同blast参数，0表示BLAST pairwise格式，5表BLAST XML格式，6表示BLAST tabular可选参数，100表DIAMOND alignment archive(DAA)，该二进制格式可通过view命令生成其他输出格式

--evalue/-e，指定期待值(默认0.001)

--top，例如10，指定输出最大score到90% * 最大score之间的比对(setting this to 10 will report all alignments whose score is at most 10% lower than the best alignment score for a query)

--min-score，指定最小bit score

--id，指定最小一致性比例

--max-target-seqs，输出最大的匹配数目

`diamond blastx -d nr -q reads.fna --id 90 --query-gencode 11 --max-target-seqs 1 --outfmt 6 qseqid qlen qstart qend sseqid slen sstart send length pident mismatch gapopen bitscore evalue btop -o matches.m8`

默认输出tabular：`qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore. `

3. view，从DAA文件生成格式化输出

--daa/-a，指定输入DAA格式文件

--out/-o，指定输出文件，同样可采用--outfmt指定输出格式

4. dbinfo，查看数据库文件信息

***

#### The Genetic Codes

https://www.ncbi.nlm.nih.gov/Taxonomy/Utils/wprintgc.cgi

#### Systematic Range and Comments:

Table 11 is used for Bacteria, Archaea, prokaryotic viruses and chloroplast proteins. As in the standard code, initiation is most efficient at AUG. In addition, GUG and UUG starts are documented in Archaea and Bacteria . In E. coli, UUG is estimated to serve as initiator for about 3% of the bacterium's proteins. CUG is known to function as an initiator for one plasmid-encoded protein (RepA) in Escherichia coli. In addition to the NUG initiations, in rare cases Bacteria can initiate translation from an AUU codon as e.g. in the case of poly(A) polymerase PcnB and the InfC gene that codes for translation initiation factor IF3. The internal assignments are the same as in the standard code though UGA codes at low efficiency for Trp in Bacillus subtilis and, presumably, in Escherichia coli .



![9_blastxxxx](https://tva1.sinaimg.cn/large/006tNbRwgy1g9sr4afappj316s0pkwhg.jpg)

#### Evaluation criteria

![1](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqqq1sovj30qn0iugoj.jpg)

![2](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqqwynclj30qn0iu778.jpg)

![3](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqr4s3d1j30qn0iu0wp.jpg)

![4](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqraltzfj30qn0iuq5r.jpg)

![5](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqrg8op5j30qn0iuacx.jpg)

![6](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqrl71j8j30qn0iu78k.jpg)

![7](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqrqkqqvj30qn0iudii.jpg)

![8](https://tva1.sinaimg.cn/large/00831rSTgy1gcwqrvhnh7j30qn0iu77t.jpg)

***

#### [blastpgp][http://etutorials.org/Misc/blast/Part+V+BLAST+Reference/Chapter+13.+NCBI-BLAST+Reference/13.8+blastpgp+Parameters+PSI-BLAST+and+PHI-BLAST/]

`blastpgp`用于PSI-BLAST和PHI-BLAST搜索. 对于标准的blasts, 这两个程序为更为敏感的蛋白blast搜索程序.

PSI-BLAST再搜索显著性hits时考虑位置特异性信息; PHI-BLAST使用pattern, 或profile来搜索比对.

##### PSI-BLAST

Position-specific iterated blast(`psiblast`), 通过制定的打分矩阵(scoring matrix)将query序列中的每个位置給予分值(基于搜索的连续迭代定义的比对情况). 指定的矩阵为位置特异性打分矩阵(position-specific scoring matrix, PSSM), 针对该位置的每一个氨基酸给予一个分值:

![image-20200317111736975](https://tva1.sinaimg.cn/large/00831rSTgy1gcwr9c7257j30gs046wey.jpg)

如图, 根据coelacanth Hoxa11蛋白(AAG39070)计算而来的PSSM. 查询序列位于左侧列, 每行是针对20种氨基酸给予的位置特异性分值. 针对1/7/8行的Y, 若是常规的blast算法, 这3个位置的Y将会拥有相同的分值.

PSSM, 或为checkpoint文件, 是由PSI-BLAST内部生成的, 同时也可以使用参数`-C`导出为一个文件. 该参数很有用. 该checkpoint文件用于随后的PSI-BLAST(`blastpgp`)搜索, 或作为RPS-BLAST程序的数据库输入文件. 同时也用在blastall(a specifialized tblastn serach)搜索, `-p psitblastn`, 使用`-R <checkpoint file>`.

运行PSI-BLAST时, 参数`-j`需设置为大于1的值. 默认的`-j 1`表示不实用迭代搜索, 和单个BLASTP搜索一样. 通过`-j`参数指定最大的迭代数目, 程序会在出现convergence时停止. 当没有新的序列发现优于`-h`设置的阈值时, 搜索终止.

![image-20200317113502235](https://tva1.sinaimg.cn/large/00831rSTgy1gcwrra2ln6j30qa01rdfs.jpg)

##### PHI-BLAST

Pattern-hit initiated BLAST, 使用输入序列定义pattern, 然后在蛋白数据中查询. 使用[PROSITE][http://ca.expasy.org/prosite/]格式定义pattern, 且用于比对的seed. 不同于用于seeding比对的words:

![image-20200317114037049](https://tva1.sinaimg.cn/large/00831rSTgy1gcwrx3o17qj30k201dglf.jpg)

以ID起始的行, 随后两空格跟随pattern的名称. 下一行以PA起始, 随后两个空格, 接着为PROSITE格式pattern. dash(-)用于分隔字符, X表示任意字符, 方括号指定一个氨基酸的选择. 如果一个pattern出现超过一次, 可能需要限制其发生发的次数, 可通过HI(hit initiation)标签指定它在pattern文件中的位置. 例如, 指定143位置出现的pattern经被使用:

![image-20200317114612656](https://tva1.sinaimg.cn/large/00831rSTgy1gcws2woxxtj30is01vq2s.jpg)

[规则][https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=BlastHelp#phi_pattern]:

![image-20200317143605536](https://tva1.sinaimg.cn/large/00831rSTgy1gcwwzrigpij30oz0a4myg.jpg)

例如:

![image-20200317143738002](https://tva1.sinaimg.cn/large/00831rSTgy1gcwx1aciztj30ky04n3z1.jpg)

解释:

![image-20200317143804811](https://tva1.sinaimg.cn/large/00831rSTgy1gcwx1xctlhj30lg0cydgj.jpg)

例如:

![image-20200317144036483](https://tva1.sinaimg.cn/large/00831rSTgy1gcwx4dr0e8j30b80203yd.jpg)

解释: 使用HI指定pattern出现的位置区间一个为19-22; 第二个为201-204

***

#### [Practices][http://bioinf-hpc.ibun.unal.edu.co/cgi-bin/emboss/help/phiblast#input]

![image-20200317162208344](https://tva1.sinaimg.cn/large/00831rSTgy1gcx021hxvtj30gq0bfmym.jpg)















