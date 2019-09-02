#### AnnotationHub

AnnotationHub包提供了一个访问Bioconductor AnnotationHub网站资源的客户端，该网站存放来自标准机构的基因组资源文件，例如UCSC, Ensembl等的vcf,bed,wig文件资源。

`library(AnnotationHub)`

`ah <- AnnotationHub()`

使用以下函数查询AnnotationHub的信息(x为AnnotationHub objects)

hubCache(x):返回本地AnnotationHub cache的系统存放位置

removeCache(x): 删除本地AnnotationHub数据以及相关资源

hubUrl(x): 返回在线hub的url

names(x): 返回hub记录的名称，AnnotationHub unique identifiers, AH12345

fileName(x): 返回本地cache的hub记录的文件路径

mcols(x): 返回记录的metadata列信息

dbfile(x): 返回SQLite 数据的全路径

****

使用以下函数访问AnnotationHub object

**query(x, pattern, ignore.case=T, pattern.op='&'): 返回匹配pattern的AnnotationHub 对象的子集**

**使用 '[[' 下载records, 首次使用时，对应的文件和其他hub资源回从网上下载到local cache。随后就可以快速使用这些local cache文件。假如想再次下载，而不是用cache文件，则需要加上参数'force=TRUE'。**

`res <- ah[["AH67442"]]`

subset(x, subset): 返回匹配subset表达式的子集

display(x): 网页展示hub记录

keys: 返回包含在AnnotationDb对象中数据的关键字，搭配select使用

columns: 显示AnnotationDb对象所能返回的数据种类

keytypes: 显示可以供select，keys和keytype能选择的关键字类型

`head(keys(orgdb, keytype="SYMBOL"))`

**select(x, keys, columns, keytype, …)：根据keys，columns，keytype等参数以数据框的格式返回AnnotationDb对象所含内容, 而mapIds返回向量**

`trial.sample <- sample(keys(orgdb,keytype="ENTREZID"))`

`select(orgdb,keys=trial.sample,column=("SYMBOL"),keytype="ENTREZID")`

`mapIds(orgdb,keys=trial.sample,column=("SYMBOL"),keytype="ENTREZID")`

`ah_kpc <- query(ah, c("klebsiella"))`

`ah_kpc[1]`

`ah_kpc$sourceurl`

`ah_kpc$description`

`ah_kpc$title`

**mapIds(x, keys, columns, keytype,…)，同select用法，常用于返回字符向量**

* 针对无法下载的ah，例如klebsiella_res <- ah[["AH67442"]]，可选择百度网盘下载后，根据错误提示，将文件直接cp到提示文件及名称

`cp org.Klebsiella_pneumoniae.eg.sqlite /Users/carlos/.AnnotationHub/74188`

![image-20190611203440629](http://ww1.sinaimg.cn/large/006tNc79gy1g3xhugfybhj30pi0880tt.jpg)

![image-20190611205023649](http://ww1.sinaimg.cn/large/006tNc79gy1g3xiatyxirj313209i40e.jpg)

***

#### GenomicFeatures

GenomicFeatures包使用TxDb对象存储转录组数据，包括UTRs,CDSs,外显子信息等。所有TxDb对象都以SQLite database备份，包含基因组的位置，pre-processed mRNA转录本，外显子，蛋白编码序列之间关系以及它们相关基因识别符。

loadDb()：直接从合适的.sqlite数据文件读取对象

`txdb <- loadDb(samplefile.sqlite)`

或者

`library(TxDb.Hsapiens.UCSC.hg19.knownGene)`

`txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene`

seqlevels(txdb): 查看染色体水平

TxDb对象inherit from AnnotationDb对象(Just as the ChipDb and OrgDb objects)，可以使用columns, keytypes, keys,和select函数操作TxDb对象。

transcripts(txdb): 返回所包含转录本位置区间信息

exons(txdb): 返回对应外显子区间信息

transcriptsBy(txdb, by="gene"): 查看根据genes分组的转录本信息

exonsBy(txdb, by="tx"): 查看根据转录本分组的基因信息

intronsByTranscript(txdb), fiveUTRsByTranscript(txdb), threeUTRsByTranscript(txdb)同上功能

提取序列信息

`tx_seq <- extractTranscriptSeqs(Hsapiens, TxDb.Hsapiens.UCSC.hg19.knownGene, use.names=T)`

转录序列成蛋白序列

`translate(extractTranscriptSeqs(Hsapiens,txdb))`

创建新的TxDb对象

GenomicFeatures包可使用从UCSC Genome Bioinformatics或BioMart下载的数据创建TxDb对象

`supportedUCSCtables(genom="hg19")`

查看UCSC基因组hg19所包含的tables信息

`txdb_from_hg19 <- makeTxDbFromUCSC(genome="hg19",tablename="knownGene"`

使用makeTxDbFromBiomar来从BioMart获得指定mart和data set的数据

`txdb_from_biomart <- makeTxDbFromBiomart()`

`makeTxDbFromBiomart(biomart="ENSEMBL_MART_ENSEMBL",dataset="hsapiens_gene_ensembl", …)`

使用makeTxDbFromEnsembl,

`makeTxDbFromEnsembl(organism="Homo sapiens",release=NA, …)`

同样可以使用makeTxDbFromGFF, makeTxDbFromGRanges来创建TxDb对象。

保存和载入TxDb对象,由于TxDb对象以SQLite数据备份，因此保存也为该格式

一旦创建了TxDb对象，可以保存本地，避免反复创建

`saveDb(txdb, file="fileName.sqlite")`

`txdb <- loadDb("fileName.sqlite")`

***

#### BSgenome & VariantAnnotation

BSgenome包存储基因组信息及snp信息

`available.genomes()`： 查看当前基因组信息

选择加载hg19

`library(BSgenome.Hsapiens.UCSC.hg19)`

定位genes内以及周围的变异

`locateVariants(query, subject, region, …)`

query: 包含变异的IntegerRanges, Granges 或 VCF对象

subject: 用于注释的TxDb或'GRangesList'对象

region: 8种变异类型中的一个‘CodingVariants’, ‘IntronVariants’, ‘FiveUTRVariants’,
‘ThreeUTRVariants’, ‘IntergenicVariants’, ‘SpliceSiteVariants’, ‘PromoterVariants’, ‘AllVariants’.

`library(VariantAnnotation)`

`fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")`

`vcf <- readVcf(f1, "hg19")`

`library(TxDb.Hsapiens.UCSC.hg19.knownGene)`

`txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene`

`seqlevels(vcf) <- "chr22"`

`rd <- rowRanges(vcf)`

`loc <- locateVariants(rd, txdb, CodingVariants())`

预测氨基酸密码子改变

针对非同义变异, predictCoding计算氨基酸密码子的改变，只有来自subject中coding区域的query序列范围的改变才会预测，同时参考序列来自于BSgenome或有seqSource指定的fasta文件

`IntergenicVariants(upstream = 1e+06L, downstream = 1e+06L,idType=c("gene", "tx"))`

`predictCoding(query, subject, seqSource, varAllele, ..., ignore.strand=FALSE)`

query: GRanges或vcf文件，如果是GRanges文件，就需要指定varAllele参数，如果是vcf文件，那么alternate alleles就从alt(vcf)中获得

subject: 用于注释的TxDb文件

seqSource: 一个 BSgenom instance或FaFile用于序列的提取

varAllel: 包含变异等位基因的DNAStringSet

`library(BSgenome.Hsapiens.UCSC.hg19)`

`conding <- predictCoding(vcf, txdb, seqSource=Hsapiens)`

或

`rd <- rowRanges(vcf)`

`altallele <- alte(vcf)`

`eltROWS <- elementNROWS(altallele)`

`rd_exp <- rep(rd, eleROWS)`

`predictCoding(rd_exp , txdb, Hsapiens)`

使用filterVcf函数过滤变异，略！！！

***

#### biomaRt

`library(biomaRt)`

第一步检查BioMart网络服务

![image-20190611161444102](http://ww1.sinaimg.cn/large/006tNc79gy1g3xabzxvgrj30jm05a74y.jpg)

useMart()函数指定需要连接的BioMart数据库，名称由listMarts()返回

`ensembl=useMart("ensembl")`

BioMart数据库能包含多个数据集，对于Ensembl，每个物种都是一个不同的数据集，使用listDatabasets()展示可用的数据集

`datasets <- listDatasets(ensembl)`

![image-20190611162409332](http://ww2.sinaimg.cn/large/006tNc79gy1g3xalsjiyrj30va0cwq4r.jpg)

使用useDataset选择数据集，更新Mart对象

`ensembl = useDataset("hsapiens_gene_ensembl", mart=ensembl)`

或者直接使用useMart选择更新

`ensembl = useMart("ensembl", dataset="hsapines_gene_ensembl")`

构建biomaRt查询

getBM()函数拥有三个参数：filters，atrributes和values，是biomaRt的主要函数

filters定义了query的限制范围：

`filters <- listFilters(ensembl)`

![image-20190611164637674](http://ww1.sinaimg.cn/large/006tNc79gy1g3xb96zz2hj30rq06cdgb.jpg)

attributes定义了query想要查询的范围：

`attributes <- listAttributes(ensembl)`

![image-20190611164813614](http://ww4.sinaimg.cn/large/006tNc79gy1g3xbau95eej30x80603zf.jpg)

getBM()共含有4个主要参数：

* attributes，想要获得的属性向量，等同于query的输出
* filters，需要过滤掉的值的向量，对应values信息，且要一一对应
* values，filters的值的向量，可以为多重filters，为list
* mart，Mart类别对象，使用useMart()函数构建

另外一些函数如getGenes()和getSequence()函数同样可以实现getBM()功能，对应指定的属性和过滤条件。

`getBM(attributes, filters = "", values = "", mart, curl = NULL, checkFilters = TRUE, verbose = FALSE, uniqueRows = TRUE, bmHeader = FALSE, quote = "\"")`

例如，在affymetirx中查询对应EntrezGene id

`affyids <- c("202763_at", "209310_s_at", "207500_at")`

`getBM(attributes=c("affy_hg_u133_plus_2", entrezgene",), filters="taffy_hg_u133_plus_2", values=affyids, mart=ensembl)`

![image-20190611170440022](http://ww1.sinaimg.cn/large/006tNc79gy1g3xbry9b2lj313a05edgk.jpg)

针对listDatasets(), listAttributes(), listFilters()返回的长的结果内容，可以使用searchDatasets(), searchAttributes(), searchFilters()对应搜索匹配指定条目的结果, pattern为正则表达式：

`searchDatasets(mart=ensembl, pattern="hsapiens")`

![image-20190611172944286](http://ww2.sinaimg.cn/large/006tNc79gy1g3xci1edj7j30pw02qt8z.jpg)

`searchAttributes(mart=ensembl, pattern="hgnc")`

![image-20190611173126297](http://ww3.sinaimg.cn/large/006tNc79gy1g3xcjt2qe8j30q604cdgf.jpg)

使用正则表达实现具体搜索

`searchFilters(mart=ensembl, pattern="ensembl.*id")`

![image-20190611173403660](http://ww2.sinaimg.cn/large/006tNc79gy1g3xcmjbw45j30um0es0v7.jpg)

然后根据提示，具体搜索：

![image-20190611173850688](http://ww1.sinaimg.cn/large/006tNc79gy1g3xcrionqyj3136074jso.jpg)

#### 示例

1. 使用HUGO和对应基因的染色体位置注释affymatrix identifiers

`affyids <- c("202763_at", "209310_s_at", "207500_at")`

`getBM(attributes=c("affy_hg_u133_plus_2", "hgnc_symbol","chromosome_name", "start_position", "end_position", "band"), filters="affy_hg_u133_plus_2"), values=affyids, mart=ensembl)`

![image-20190611181312503](http://ww3.sinaimg.cn/large/006tNc79gy1g3xdr9g1e7j313808gq4a.jpg)

2. 使用GO注释EntrezGene ids

`entrez <- c("673", "837")`

`goids <- getBM(attributes=c("entrezgene", "go_id"), filters="entrezgene", values=entrez, mart=ensembl)`

![image-20190611182429677](http://ww3.sinaimg.cn/large/006tNc79gy1g3xe309slnj30m206omxs.jpg)

3. 查询位于17/20/Y染色体上属于指定GO条目的HUGO gene名称

`go <- ("GO:0051330", "GO:0000080", "GO:0000114", "GO:0000082")`

`chrom <- c(17,20,"Y")`

`getBM(attributes="hgnc_symbol", filters=c("go", "chromosome_name"), values=list(go, chrom), mart=ensembl)`

![image-20190611183023442](http://ww4.sinaimg.cn/large/006tNc79gy1g3xe95eba2j313c07kq3m.jpg)

或者，去除染色体的限制，增加attributes内容输出,filter和values一一对应！

![image-20190611183514278](http://ww2.sinaimg.cn/large/006tNc79gy1g3xee6ybc8j312k06u750.jpg)

4. 使用INTERPRO蛋白结构域注释refseq ids

`refseqids <- c("NM_005359", "NM_000546")`

`ipro <- getBM(attributes=c("refseq_mrna", "interpro", "interpro_description"),filters="refseq_mrna", values=refseqids, mart=ensembl)`

![image-20190611183947262](http://ww2.sinaimg.cn/large/006tNc79gy1g3xeiwvu5hj310y0gmwgv.jpg)

5. 查询染色体固定区间的gene信息

![image-20190611185309352](http://ww4.sinaimg.cn/large/006tNc79gy1g3xewtuj6rj30y807agmp.jpg)

**filters信息要和values信息一一对应**

6. 查询'MAP kinase activity' 相关GO term的所有HUGO基因名称

![image-20190611185419385](http://ww1.sinaimg.cn/large/006tNc79gy1g3xey1fvatj30sk06cjs6.jpg)

7. 针对指定EntrezGene ids查询启动子上游100bp序列

可直接使用getSequence()函数获取序列信息

`getSequence(chromosome, start, end, id, type, seqType,upstream, downstream, mart, verbose = FALSE)`

![image-20190611190040548](http://ww1.sinaimg.cn/large/006tNc79gy1g3xf4ncobqj30vo084t9s.jpg)

8. 查询位于3号染色体指定位置的所有5‘ utr序列

![image-20190611190639806](http://ww2.sinaimg.cn/large/006tNc79gy1g3xfaw250nj31400dumyz.jpg)

9. 查询指定entrezgene的蛋白序列

![image-20190611190833219](http://ww4.sinaimg.cn/large/006tNc79gy1g3xfcuu1tbj30xg0i876j.jpg)

10. 查询指定位置snp信息

首先使用不同的BioMart数据库

`snpmart <- useMart(biomart="ENSEMBL_MART_SNP", dataset="hsapiens_snp")`

![image-20190611191554416](http://ww2.sinaimg.cn/large/006tNc79gy1g3xfki4dioj30uu09wjst.jpg)

略！！！