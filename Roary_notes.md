[Roary][https://github.com/sanger-pathogens/Roary]是一个快速计算pan genome软件，将输入gff3格式文件(prokka输出的gff文件)根据序列相似性分类，计算pan genome。首先将输入文件的编码区域提取出来，然后翻译成对应的蛋白序列文件，过滤掉部分的序列，然后使用CD-HIT对其进行迭代聚类，这将在很大程度上减少蛋白序列内容；然后根据设定的序列一致性(默认为95%)对所有序列使用BLASTP进行比对；接着使用MCL进行聚类；最后将CD-HIT聚类后的结果和MCL聚类后的结果汇总，得到pan genome蛋白序列。

![image-20190709163727439](http://ww2.sinaimg.cn/large/006tNc79gy1g4toc9u77pj31d80u0tz2.jpg)

Paralogs

![homologs](http://ww2.sinaimg.cn/large/006tNc79gy1g4tosi78asj30g60b2gm4.jpg)

#### Usage

`roary *.gff`

使用8线程生成核心基因比对

`roary -e --mafft -p 8 *.gff`

检测软件是否正确安装

`roary -a`

-o clusters输出文件名[clustered_proteins]

-f 输出文件路径[.]

**-e 如果不使用--mafft，则使用PRANK针对使用codon aware alignment构建core genes的multiFASTA比对，速度慢但是准确**

**-n 和-e一起使用MAFFT执行核酸的比对快速构建core gene，快速但是准确性不高**

**以上core_gene_alignment.aln(不能排除重组)可用于输入构建系统发育树，可使用snp_sites先过滤，以减少运行时间和内存**

-i blastp比对的最小一致性[95]

-cd 基因存在于该比例的isloates中时判定为core[99]

-r 创建R图，需求R和ggplot2

-s 不进行paralogs split

-t 翻译蛋白密码表[11]

-ap 允许paralogs存在于core aligment

####Output

gene_presence_absence.csv 每个isolate中基因在每个group内存在分布

![image-20190709165556248](http://ww4.sinaimg.cn/large/006tNc79gy1g4tovho4jbj31ws0a6wje.jpg)

core_gene_alignment.aln 核心保守基因的multi-FASTA比对

![image-20190709165744391](http://ww4.sinaimg.cn/large/006tNc79gy1g4toxdtzxsj30t205y0tc.jpg)

`fasttree -nt -gtr core_gene_alignment.aln > my_core_gene_alignmnt.newick`

clustered_proteins 一个cluster一行，包含序列ID

![image-20190709165924174](http://ww4.sinaimg.cn/large/006tNc79gy1g4toz3z57hj319i06sjtj.jpg)

**Accessory_binary_genes.fa.newick accessory genome内基因分布关系的newick tree，可使用FigTree打开，查看acessory genes的对应关系图，该关系图较为粗糙**

**First of all we construct a FASTA file with the binary presence and absence of genes, where 'A' means a gene is present and 'C' means it is absent. Only the first 4000 genes in the accessory genome are considered to limit the running time and memory usage of FastTree. FastTree is then run with the fastest possible settings to produce a Newick tree.**

![image-20190709174129835](http://ww4.sinaimg.cn/large/006tNc79gy1g4tq6wgtmkj311404w3z2.jpg)

#### query_pan_genome

![image-20190709170543091](http://ww1.sinaimg.cn/large/006tNc79gy1g4tp5ohxqdj318o0h2agk.jpg)

**you need all Roary output within the same folder as the .gff files so query_pan_genome works**

查看isloates中所有基因

`query_pan_geonme -a union *.gff`

查看isolates中基因交集

`query_pan_genome -a intersection *.gff`

查看isloates中的acessory 基因

`query_pan_genome -a complement *.gff`

提取基因的序列并构建multi-FASTA文件

`query_pan_genome -a gene_multifasta -n gryA,mecA,abc *.gff`

存在于两组isolates中的基因分布差异

`query_pan_genome -a difference --input_set_one 1.gff,2.gff --input_set_two 3.gff,4.gff,5.gff`

#### Receipe for using roary

1. Annotate FASTA files with PROKKA
2. Roary -e --mafft *.gff
3. FastTree -nt -gtr core_gene_alignment.aln > my_tree.newick

***







