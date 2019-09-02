1. [下载Swiss-Prot蛋白序列构建用于diamond数据库](https://www.uniprot.org/downloads)

Swiss-prot是由欧洲生物信息研究说(EBI)维护的人工注释审核的高质量非冗余蛋白数据库。其注释包括蛋白功能，结构域，转录后修饰，变异位点等，

[下载地址](ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz)

[序列条目结果说明](https://web.expasy.org/docs/userman.html#entrystruc)

![image-20190613164750962](http://ww3.sinaimg.cn/large/006tNc79gy1g3zmj2k615j30um0u0wkz.jpg)

累述下ID/AC，swiss-prot entry names，格式为X_Y，其中x为蛋白名称，例如，B2MG为beta-2-microglobulin，HBA为Hemoglobin alpha chain；Y为物种识别字符，一般前3个字母种属，后2个为物种，例如PSEPU，为Pseudomonas putida

AC(accession number)为该entry的accession number，格式为AC AC_number_1; [AC_number_2;]…，该accession number提供了稳定的识别方式，建议使用accession number来对应到起始数据资源。

[Uniprot_sprot名称与其他数据库对应文件](ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/idmapping/)

[NCBI基因名称与其对应文件](ftp://ftp.ncbi.nih.gov//gene/DATA/gene_refseq_uniprotkb_collab.gz)

完成下载后diamond makedb构建查询数据库

`diamond makedb --in uniprot_sprot.fasta -d swiss_prot`

2. blastp搜索比对，这里只输出1条最佳比对结果

`diamond blastp --db swiss_prot.dmnd -e 1e-5 --max-target-seqs 1 --sensitive --outfmt 6 qseqid qstart qend sseqid sstart send length pident mismatch gapopen bitscore evalue btop --query 38588_prodigal.faa --out 38588_prodigal_diamond_uniprot.m8 >38588_prodigal_diamond_uniprot.log 2>&1 `

outfmt6默认格式：qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore



