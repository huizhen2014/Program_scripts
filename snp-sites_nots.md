1. 输入文件为多重fasta比对文件，所有序列长度相同且已经比对

2. 比对文件可根据一致性的参考基因组序列比对生成，或使用多重比对工具，muscle，prank，mafft，clusta    lW生成

3. 默认输出格式为多重比对fasta文件，同时输出也可为PHYLIP格式或VCF格式

4. PHYLIP格式输出可用于RAxML软件输入，用于构建系统发育树

5. VCF格式输出保留了每个样本中SNPs位置信息，可使用BCFtools软件分析，或使用PLINK做GWAS分析

6. snp-sites运行中，每个输入序列依次读取；第一步生成consensus sequence；第二步将每个输入序列与之 比较，标记下差异位置信息。若输入序列存在未知或gap(n/N/?/-)，该碱基判定为一个非变异位置(non-variant)

* -r 输出pseudo参考序列
* -m 输出多重比对
* -v 输出vcf文件
* -p 输出phylip文件
* -o 指定输出文件前缀
* -b 输出monomorphic 位置，用于BEAST

例如创建用于BEAST的输入文件

`sup-sites -cb -o outfile.aln inputfile.aln`

实例

`muscle -in beta-KPC.fasta -out beta-KPC.align`

`sap-sites -vp -o kpc.snp beta-KPC.align`

