[FastTree][http://microbesonline.org/fasttree/]用于从核酸或者蛋白比对中推到最大化相似性系统发育树。FastTree能处理上百万的序列比对文件，针对大量比对，比RAxML快100-1000倍。

**FastTree使用Jukes-Cantor或generalized time-reversible(GTR)模型用于评估核酸进化**

**使用JTT, WAG或LG模型用于氨基酸进化分析**

**针对varying rates of evolution across sites, FastTree使用single rate for each site(CAT)**

可使用[MUSCLE][http://www.drive5.com/muscle/]来创建多重比对输出；针对大的蛋白家族，推荐使用hmmalign, [HMMer package][http://hmmer.janelia.org/]；针对大的RNA家族，推荐使用[Infernal][http://infernal.janelia.org/]。

FastTree仅能识别两套字符，核酸为ATCG, T可被U取代；还有就是20种标准的氨基酸(ARNDCQEGHILKMFPSTWYV)。对于比对中包含的gaps，使用"-"字符表示。

* Running FastTree

FastTree输入文件位fasta格式多重比对或interleaved phylip格式

对蛋白比对使用JTT+CAT模型推到tree，默认为蛋白序列输入

`FastTree < alignment.file > tree_file`

`FastTree alignment.file > tree_file`

使用-wag或-lg选项使用WAG+CAT或LG+CAT模型。使用GTR+CAT模型对核酸比对推导tree

`FastTree -gtr -nt < alignment.file > tree_file`

`FastTree -gtr -nt alignment.file > tree_file`

若没指定-gtr，则使用默认Jukes-Cantor+CAT模型。

若希望rescale the branch lengths并且计算基于Gamma20的相似性，使用-gamma参数(将会慢约5%)

输出格式为Newick格式

















