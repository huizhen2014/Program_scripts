#### [BUSCO][https://busco.ezlab.org]

BUSCO 采用benchmarking universal single-copy orthologs数据集来评估完整性(www.orthodb.org), 提供基因组组装, 注释基因集, 期待基因的转录本的完整性的量化信息. Genes that make up the BUSCO sets for each major lineage are selected from orthologous groups with genes present as single-copy orthologs in at least 90% of the species. While allowing for rare gene duplications for losses, this establishes an evolutionarily-informed expectation that these genes should be found as single-copy othologs in any newly-sequenced genome.

##### quick start BUSCO assessments

-m / --mode 评估模式: genome/ proteins/ transcriptome

基因组组装评估: `busco -i sequence_file -o output_name -l lineage -m geno`

对应其他模式为:proteins/prot; transcriptiome/tran

lineage: 为所使用的BUSCO lineage数据(http://busco.ezlab.org/  ; eukaryote_odb9/vertebrata_odb9/fungi_odb9)

运行时间:

![image-20191203200837330](https://tva1.sinaimg.cn/large/006tNbRwgy1g9jsjadf8zj30n807976n.jpg)

-c N / --cpu N 指定线程或核, 默认1

-e N / --evalue N 指定blast搜索的E-value, 默认0.001/1e-3

-f / --force 强制写入现存文件或目录

-sp SEPCIES / --species SPECIES 现存Augustus 物种基因查询参数名称, 每个leneage拥有一默认物种, 推荐选择最相关的物种

-t PATH / --tmp PATH 临时文件存储位置, 默认: ./tmp

-z / --tarzip 输出文件tarzipped

-r / --restart  从最近完成的步骤开始重新运行BUSCO

--limit REGION_LIMIT 考虑多少候选区域, 整数, 默认为3

--long 开启augustus最佳运行模式, 用于自我训练, 会增加运行时间, 默认为off

##### Output

short_summary_XXXX.txt 包含BUSCO注释文件

full_table_XXXX.tsv 表格形式完整结果

missing_buscos_list_XXXX.tsv 包含一系列缺失BUSCOs信息

其他略

![image-20191203202056315](https://tva1.sinaimg.cn/large/006tNbRwgy1g9jsw362h6j30j206jjs8.jpg)

例如: short_summary_TEST.txt

![image-20191203202214973](https://tva1.sinaimg.cn/large/006tNbRwgy1g9jsxgql7cj30pe0ao40p.jpg)

***

#### [QUAST][http://quast.bioinf.spbau.ru/manual.html]

QUAST为Quality Assessment Tool. 通过计算不同的metrics评估基因组组装. QUAST用于基因组组装, MetaQUAST为metagenomic数据组装, QUAST-LG为大基因组组装评估(例如, 哺乳动物), Icarus, interactive visualizer for these tools.

QUAST default pipeline utilizes [Minimap2](https://github.com/lh3/minimap2). Functional elements prediction modules use [GeneMarkS](http://exon.gatech.edu/GeneMark/), [GeneMark-ES](http://exon.gatech.edu/GeneMark/gmes_instructions.html), [GlimmerHMM](http://cbcb.umd.edu/software/glimmerhmm/),[Barrnap](https://github.com/tseemann/barrnap), and [BUSCO](http://busco.ezlab.org/). QUAST module for finding structural variations applies [BWA](https://github.com/lh3/bwa), [Sambamba](https://github.com/lomereiter/sambamba), and [GRIDSS](https://github.com/PapenfussLab/gridss). Also we use [bedtools](http://bedtools.readthedocs.io/) for calculating raw and physical read coverage, which is shown in Icarus contig alignment viewer. Icarus also can use [Circos](http://circos.ca/) if it is installed in PATH. QUAST-LG introduced modules requiring [KMC](http://http//sun.aei.polsl.pl/kmc) and [Red](http://toolsmith.ens.utulsa.edu/). In addition, MetaQUAST uses [MetaGeneMark](http://exon.gatech.edu/GeneMark/meta_gmhmmp_instructions.html), [Krona tools](http://sourceforge.net/p/krona/home/krona/), [BLAST](http://blast.ncbi.nlm.nih.gov/Blast.cgi), and [SILVA](http://www.arb-silva.de/) 16S rRNA database.

#####Running QUAST

```bash
./quast.py test_data/contigs_1.fasta \
               test_data/contigs_2.fasta \
               -r test_data/reference.fasta.gz \
               -g test_data/genes.gff
```

查看输出:

```bash
less quast_results/latest/report.txt
```

##### Input data

1. sequences, 组装序列和fasta格式的参考基因组, 可以是zip, gzip, bzip2压缩格式
2. reads, fastq格式的Illumina, PacBio, Nanopore reads, 或者SAM/BAM比对格式文件
3. Genes and Operons, 可指定包含参考基因组中的基因和operon位置文件, QUAST将会计算全部和部分比对区域, 输出total values as well as cumulative plots

![image-20191203204310536](https://tva1.sinaimg.cn/large/006tNbRwgy1g9jtj87mhzj30xo08yaby.jpg)

##### Command line options

-o <output_dir> 输出目录, 默认为quast_results/results_<data_time>

-r \<path> 参考基因组文件, 可选参数, metrics在缺少参考基因组时无法实现

--features (or -g) \<path> 参考基因组的feature位置信息文件: 若仅计算gff文件中的指定feature信息:

--features CDS:~/data/my_genome_annotation.gff

--features gene:./test_data/genes.gff

默认为所有features

--min-contig (or -m) \<int> 最短contig长度阈值(bp), 默认为500

--threads (or -t) \<int> 线程

其他略

##### QUAST output

输出包含:

![image-20191203205012034](https://tva1.sinaimg.cn/large/006tNbRwgy1g9jtqk2qypj31de0ksafj.jpg)

其他略



