#### [TransDecoder(Find Coding Regions Witin Transcripts)][https://github.com/TransDecoder/TransDecoder/wiki]

TransDecoder用于识别转录序列中的编码区域, 例如使用trinity软件针对RNA-Seq数据de novo的组装结果, 或使用Tophat和Cufflinks基于RNA-Seq比对到基因组而来的转录序列。

TransDecoder基于以下标准识别可能的编码序列:

* 转录序列中最下的ORF长度
* 相似性log值于GeneID软件计算结果比较，两者相似度>0
* 第一位置的阅读框相比于相比于其他两个正向阅读框时，分值最高
* 当一个预测ORF完全被另一个预测ORF涵盖时, 选择较长的ORF. 然而, 单个转录本会预测多个ORFs(允许操纵子, 嵌合体, 等)
* 构建/训练/使用PSSM, 来优化其实密码子的预测
* 可选, 推测的肽链比对Pfam结构域同时满足噪音阈值

#### Runing TransDeconder

* Predicting coding regions from a transcript fasta file

1. 获取long ORF

默认条件下, TransDecoder.LongOrfs识别至少100氨基酸的ORFs, 可通过参数'-m'调整氨基酸长度, 但是越短的长度阈值将会带来越多的假阳性ORFs

-t transcripts.fasta

-m 最小蛋白长度, 默认为100

-G 遗传密码子, 默认为: universal

-S 链特意性(only analyzes top strand)

--output_dir/-O 输出文件夹, 默认为当前目录, 后缀为".transdecoder_dir"

`TransDecoder.LongOrfs -t target_transcripts.fasta`

输出结果在`Trinity.fasta.transdecoder_dir`中

`longest_orfs.pep` 不考虑编码可能性的,满足最短长度标准的所有ORFs

`longest_orfs.gffs`  在靶向转录本中所有ORFs的位置

`longest_orfs.cds`  所有检测到的ORFs的核酸编码序列

`longest_orfs.cds.top_500_longest`  最长的500个ORFs, 用于编码序列训练Markov model

`hexamer.scores`  针对k-mer(coding/random)的相似性值对数值

`longest_orfs.cds.scores`  每个ORFs的6个reading frames的相似性值对数值之和

`longest_orfs.cds.best_candidates.gff3`  转录本中选择的ORFs的位置信息

2. 通过blast或pfam识别同源ORFs

进一步是的ORFs具有功能显著性, 而不考虑编码相似性值, 可根据序列同源性在已知的蛋白中所搜索所有ORFs并保留这样的ORFs. 该过程可通过两个流行的方法实现, 在已知的蛋白数据中通过blast搜索, 在PFAM中识别共有的蛋白结构域

BlastP Search

`blastp -query transcoder_dir/longest_orfs.pep -db uniprot_sport.fasta -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 10 > blasts.outfmt6`

或使用diamond更快搜索

`ln -s /Data_analysis/Ref_database/Swiss_Prot/uniprot_sprot.fasta.gz .`

`diamond makedb --in uniprot_sprot.fasta.gz -d uniprot_sprot.fasta`

`diamond blastp -q Trinity.fasta.transdecoder_dir/longest_orfs.pep -d uniprot_sprot.fasta.dmnd --max-target-seqs 1 --outfmt 6 --evalue 1e-5 > blastp.outfmt6`

Pfam Search

`ln -s /Data_analysis/Ref_database/Pfam_database/`

`hmmscan --domtblout pfam.domtblout Pfam_database/Pfam-A.hmm Trinity.fasta.transdecoder_dir/longest_orfs.pep`

3 .将blast和pfam搜索结果整合到所选择的编码区域中

通过TransDecoder确保具有最佳blast hits或domain hits的堕胎保留在编码区域中

`TransDecoder.Predict -t trinity_assemble_results/Trinity.fasta --retain_pfam_hits pfam.domtblout --retain_blastp_hits blastp.outfmt6`

这样最终的编码区域预测将包含和blast或pfam同源的编码区域

最终输出在当前路径:

`transcripts.fasta.transdecoder.pep`  最终预测的ORFs的肽链序列, 所有包含在长ORFs中的ORFs都被去除了

`transcripts.fasta.transdecoder.cds`  最终ORFs编码区域的核酸序列

`transcripts.fasta.transdecoder.gff3`  最终选择的ORFs在转录本中的位置

`transcripts.fasta.transdecoder.bed`  可用于IGV/GenomeView查看的ORFs的位置bed文件









