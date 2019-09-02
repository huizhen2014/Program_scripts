#### Instruction

ABACAS用于根据参考基因组快速快速连接(align, order, orientate)，查看并设计引物用于contigs之间gaps的填充。根据参考基因组，使用mummer查询比对位置并识别共线性。输出结果使用N代表contigs之间的重叠和gaps，contigs之间的重叠重由于contigs末端的低质量以及低复杂度区域。同时，ABACAS能自动提取gaps，并设计引物用于gaps填充，设计引物的特异性可通过mummer比对查看。

#### Usage

`abacas -r <reference> -q <contigs> -p <nucmer|promer>`

ABACAS将会输出多个不同结果文件，使用ACT进行比较。

-c，参考序列为环状

-i，最小一致性比对，默认40%，值越小，比对contigs更多

-v，最小contigs覆盖度，默认40%

-V，最小contigs覆盖度差异，0表示contigs多重比对时，随机放置多重contigs

-t，针对未使用的contigs(.bin文件中)，采用tblastx比对；使用-b生成该文件

-N，不使用N对contigs间的重叠以及gaps进行填充

使用默认参数将会输出以下文件：

经过排序和排列方向的序列文件(reference_query.fasta or prefix.fasta)，如果发现contigs比对到了反向链，那么.fasta文件中的contigs为反向互补排列(**输出中所有对应的定向为“-”都经过了个反向互补输出**)，然而ACT中将显示contigs初始方向。

特征文件(reference_query.tab or prefix.tab)

Bin文件，包含没有用于排序的contigs(reference_query.bin or prefix.bin)

比较文件(reference_query.crunch or prefix.crunch)

Gap信息(reference_query.gaps or prefix.gaps)

关于有比对信息但是没有用于排序的contigs信息(unused_contigs.out)

-m，输出经过排序和重定向的多重fasta格式文件

-b，输出包含未比对的contigs的多重fasta文件

-g，输出reference上的多重fasta文件对应gaps

#### Output

![image-20190624095018775](http://ww1.sinaimg.cn/large/006tNc79gy1g4c0a0tglgj30zk06otao.jpg)

Comparison file(.crunch file)：7列对应，覆盖度，一致性，pseudomolecule起点，终点，contig ID，reference起点，终点

![image-20190624095242535](http://ww4.sinaimg.cn/large/006tNc79gy1g4c0ci41j3j30um06swg0.jpg)

Gap file(.gaps)：2-6列表，gap大小，pseudomolecule起点，终点，reference起点，终点

![image-20190624095351472](http://ww3.sinaimg.cn/large/006tNc79gy1g4c0dpciy1j30t006mt9z.jpg)

Bin file(.bin)：未能用于生成pseudomolecule的contigs名称

![image-20190624095451312](http://ww3.sinaimg.cn/large/006tNc79gy1g4c0eqrv8jj30tw06qt9i.jpg)

经过排序和重定向后contigs生成的pseudomolecule文件，重叠contigs使用100个N进行分割，同时gaps也使用N表示

`abacas -v 5 -c -N -m -g ref_query_gaps -b -r ASM24018v2_chromosomal_seq.fna -q 39401_scaffolds_filtered_500_30.fasta -p nucmer -o ref_query_5`

![image-20190624193323468](http://ww4.sinaimg.cn/large/006tNc79gy1g4ch4pdr79j30ys09g75i.jpg)