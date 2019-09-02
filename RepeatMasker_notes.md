#### Introduction

重复序列识别并mask是基因组注释的第一步骤。未经mask的重复序列将导致上百万个错误的BLAST比对，带来假的基因注释，更甚者，对于基因预测软件(Augustus, genescan, snap)，存在许多转座子(transposon open reading frames, ORFs)开放阅读框类似基因，导致部分转座子ORFs被预测为外显子部分。对于准确注释蛋白编码基因而言，好的重复序列mask是很重要的。

Repeatmasker用于查询DNA序列中的重复和低复杂度序列。

基因组散布重复序列，根据特征分为5类：

1. Simple Repeats，一组简单DNA碱基(一般1-5bp)的重复，例如A, CA, CGG等
2. Tandem Repeats，一般存在着丝点和端粒中，以更复杂的100-200个碱基序列的重复出现
3. Segmental Duplications，以10-300kb的规格存在，常在基因组的不同区域出现重复
4. Interspersed Repeats
   * Processed Pseudogenes, Retrotranscripts, SINES-非功能性RNA基因重复，在反转录酶的帮助下整合到基因组内
   * DNA Transposons
   * Retrovirus Retrotransponsons
   * Non-Retrovirus Retrotransposons(LINES)



















