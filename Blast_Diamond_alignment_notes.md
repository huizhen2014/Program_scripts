#### Blast

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

3. tblastx，在蛋白数据库搜索DNA序列

首先同样构建nucl数据库，然后再构建一个prot数据库

`makeblastdb -in blaKPC-2.fsa -hash_index -dbtype prot -out databases/blaKPC-2`

最后比对，参数同blastn

-db_genecode，指定转录方法，微生物为11

`tblastx -evalue 1e-3 -db databases/blaKPC-2 -query_gencode 11 -db_gencode 11 -query query.fasta -max_target_seqs 5 -outfmt "6 qseqid qstart qend sseqid sstart send length pident mismatch gapopen bitscore evalue btop" > query_kpc-2.tblastx`

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





