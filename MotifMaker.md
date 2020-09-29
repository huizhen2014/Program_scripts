#### [MotifMaker][https://github.com/PacificBiosciences/MotifMaker]

Find methylated motifs in prokaryotic genomes : http://pacb.com/basemod

MotifMaker是一个用于在原核基因组内识别和DNA修饰相关的motifs的工具. 原核生物中DNA的修饰常源于restriction-modificaition系统, 在特殊的序列moitf甲基化特殊的碱基. 原核生物可能拥有大量有活性的restriciton-modificaiton系统, 从而产生负载的序列motifs混合存在.

##### Algorithm

现存的moitf搜索算法例如MEME-chip和YMF为该甲基化motif搜索的次级选择:

1. 它们搜索单个motif, 而不是识别复杂的motifs组合
2. 它们一般步接受比对的motifs的注释 - 输入为参考序列内的一个包含moitf的窗口范围, 而不是单个位于中点的修饰位置
3. 它们一般采用Markov model of the reference(MEME-chip), 或根据reference进行准确计算, but place restrictions on the size and complexity of the motifs that can be discovered.

MotifMaker的搜索方法如下:

定义一个moitf为一套元组(a set of tuples, position relative to methylation, required base). 给定一个基因组序列和一系列修饰检出, 采用一下方法定义moitfs:

Motif score(moitf) = (# of detections matching motif) / (# of genome sites matching moitf) * (Sum of log-pvalue of detections matching moitf) = (fraction methylated) * (sum of log-pvalues of matches)

搜索所有可能的motifs, 使用branch-and-branch搜索来检测逐渐搜索更长的moitfs.

##### Usage

`find`, 用于根据参考基因fasta和modifications.gff(.gz)文件来搜索moitf

`reprocess` 用于对moitf信息注释gff信息

`java -jar MotifMaker-assembly-0.3.1.jar find -f /Data_analysis/RNA_analysis/dpnM_methylation_analysis/Assembled_Genome_43_denovo.fa -g /Data_analysis/RNA_analysis/dpnM_methylation_analysis/motifs_43_denovo.gff -o 43_denovo_motif.results`

`java -jar MotifMaker-assembly-0.3.1.jar reprocess -m 43_denovo_motif.results -f /Data_analysis/RNA_analysis/dpnM_methylation_analysis/Assembled_Genome_43_denovo.fa -g /Data_analysis/RNA_analysis/dpnM_methylation_analysis/motifs_43_denovo.gff -o 43_denovo_motif.reprocess`

***

 

