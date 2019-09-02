#### [Spine][http://vfsmspineagent.fsm.northwestern.edu/index_age.html]

Spine用于识别细菌或其他小基因组物种的保守核心基因序列

#### Usage

`perl spine.pl -f genome_files.txt`

-f 输入序列文件，可以为fasta序列(fasta)，包含genebank序列和注释文件的genebank格式文件(gbk)，或分开的fasta文件伴有对应的gff3格式注释文件(comb)

![image-20190709115814526](http://ww3.sinaimg.cn/large/006tNc79gy1g4tg9r57glj31co03saao.jpg)

![image-20190709115936261](http://ww1.sinaimg.cn/large/006tNc79gy1g4tgb672a5j31ac056abk.jpg)

-a/--pctcore 输入基因组序列被认定核心基因组区域的最小百分比，默认为100

-g/--maxdist 核心基因组segments之间的最大距离，相邻segments之间小于该距离将合并成combined fragments，之间使用N填充；否则就分为两个或多个fragments，默认10

-r/--refs 作为主要输出的参考基因组序列，参考基因组序列将作为主要的backbone序列来源；通过整数值来对应输入文件的基因组顺序，可使用逗号隔开多个输入值，例如:1,3，序列1位具有最好的优先性，序列3位第二优先参考序列。默认参考基因组的优势排序同输入文件中基因组的排序，第一个基因组拥有最好的参考优势

--mini 仅输出backbone序列，来源于参考基因组。当仅需要backbone序列去获得accessory sequences时，开采用该选型以节约时间。默认针对所有包含的基因组，输出core和accessory序列集

--pangenome 输出pangenome序列，默认不输出

-o/--prefix 输出结果前缀

-p/--pctid 判定为同源性的最小的一致性区域，默认85

-s/--minout 输出的最小的核心区域的大小，单位base，默认10

输出文件

statistics.txt 

![image-20190709131245574](http://ww3.sinaimg.cn/large/006tNc79gy1g4tifablo0j31lw0e6gpg.jpg)

coords.txt 基因组序列的坐标位置，包含：".accessory_coords.txt", ".core_coords.txt", "backbone_coords.txt", "pan genome_coords.txt"

![image-20190709132054652](http://ww1.sinaimg.cn/large/006tNc79gy1g4tinrlgczj30xw06wgn7.jpg)

*.fasta 输出基因组片段的核酸序列文件

![image-20190709132156268](http://ww2.sinaimg.cn/large/006tNc79gy1g4tiotzcszj311606sdgw.jpg)

loci.txt 核心基因组中的coding序列，包含".accessory_loci.txt", ".core_loci.txt", "pangenome_loci.txt", "backbone_loci.txt"

![image-20190709132302592](http://ww2.sinaimg.cn/large/006tNc79gy1g4tipz58bpj31vy07gdir.jpg)

position_counts.txt 

***

#### [AGEnt][https://github.com/egonozer/AGEnt]

AGEnt用于从core genome中识别accessory genomic elements

#### Usage

`perl AGEnt.pl -r core_genome.fasta -q query_genome.fasta`

-q fasta格式或者genebank格式的输入query序列文件。如果使用注释后的genebank格式文件，AGEnt将会提取CDS坐标来将gene分至core或acessory groups。如果时genebank文件，CDS坐标必须拥有"locus_id"标签用于gene信息提取。针对RAST输出，不含"locus_id"标签，可使用[gbk_reformat][http://vfsmspineagent.fsm.northwestern.edu/download.html]程序

![image-20190709134512990](http://ww1.sinaimg.cn/large/006tNc79gy1g4tjd1qnugj31bs07mq56.jpg)

-r core/referenc序列，fasta格式或genebank格式

-b 同时输出core 序列和坐标，默认仅输出accessory 序列和坐标

-c 包含query genome中的基因名称和坐标文件路径，将输出一个文件将基因分配到core和accessory中，默认文件格式为"glimmer"格式：

![image-20190709133830383](http://ww1.sinaimg.cn/large/006tNc79gy1g4tj62efhyj31ag07sq4e.jpg)

同时可采用-q/-c指定输入序列及注释信息

![image-20190709133949490](http://ww4.sinaimg.cn/large/006tNc79gy1g4tj7gxbmfj314e02oaa9.jpg)

![image-20190709134003816](http://ww2.sinaimg.cn/large/006tNc79gy1g4tj7ownwij311i02sdg2.jpg)

-f 由-c选项指定的ORF坐标文件格式：'glimmer', 'genebank', prodigal', 'gff'，默认为glimmer

-m 将query序列判定为core时，query和reference之间最小的比对一致性，默认为85

-o 输出文件前缀，默认为'output'

-p 输出序列的前缀，默认同-o指定前缀

-s 最小输出片段的大小，单位base，默认10

输出文件

statistics.txt，coords.txt，'*.fasta'，loci.txt同spine和ClustAGE

***

#### [ClustAGE][https://sourceforge.net/projects/clustage/files/]

ClustAGE将一组来自细菌或其他小的基因组物种的accessory genomic element(AGEs)聚类并识别最小的accessory genomic elements，同时识别这些elements在所提供基因组的序列中的分布情况。

#### Usage

`perl ClustAGE.pl -f age_files.txt`

`ClustAGE.pl -f ClustAGE_input.txt --annot ClustAGE_annot.txt -p --graph_se -o clustage_graphs`

-f accessory genome elements fasta 文件

![image-20190709101354168](http://ww3.sinaimg.cn/large/006tNc79gy1g4td99hbmlj3138030gm8.jpg)

其中rank时指定strain的数值，可以是实际数字或者相对数字，同时该rank值可选。如果rank值设定为"R"，那么改序列将指定为reference，且属于改基因组的序列不会用于作为bin representatives，但是该基因组针对bin representatives的比对序列将会报出

--annot 可选输入文件，该注释信息将包含在输出文件中

![image-20190709101900595](http://ww1.sinaimg.cn/large/006tNc79gy1g4tdehmzi1j312s02y0t7.jpg)

该注释文件应为Spine或AGEnt的输出格式文件, "loci.txt"

`locusID<tab>Source contig ID<tab>Source start<tab>Source stop<tab>Strand<tab>Accessory sequence ID<tab>Accessory start<tab>Accessory stop<tab>% of gene<tab>Overlap<tab>Gene product`

同时该注释文件genome_name应该和-f参数指定输入文件的genome_name一样

--age 为用作bin representatives的fasta格式的AGE序列，如果指定该文件，那么-f文件将不会用与识别新的bin representatives，且-f指定文件将比对到--age文件

-e/--evalue 最大的BLAST e-value cutoff，默认1e-6

-i/--pctid 最小的核酸序列一致性(%)，默认85%

--dustoff 取消默认使用blast针对低复杂度序列进行过滤。该选项用于含有大量低复杂度序列的物种，默认(dust masking on)

-a/--maxaign 用于报告的最小数目的blast比对。太小的值将导致不正确结果，尤其是在比较大量序列数目时，默认100000

-x/--min_age 最小的acessory size，单位bp。为用于ClustAGE指定bin representative的最短的可能序列，默认为200

-o/--out 输出文件前缀，默认out

-p/--graph 输出AGEs的图像，包含AGE在输入输入文件中的分布信息

--graph_se 输出图像包含subelement dividers信息

输出文件

AGEs.key.txt 为acessory genomic element representative的特征

![image-20190709112931370](http://ww1.sinaimg.cn/large/006tNc79gy1g4tffv96rgj315a07g0ui.jpg)

bin_id为representative序列的唯一ID，对应AGE.fasta中的ID

AGEs.fasta 为representative AGE序列中的核酸序列

![image-20190709113135484](http://ww4.sinaimg.cn/large/006tNc79gy1g4tfi0t2zej312a07iq4d.jpg)

AGEs.annotations.txt representative accessory regions内的基因注释内容

![image-20190709113433757](http://ww2.sinaimg.cn/large/006tNc79gy1g4tfl3rxn0j311606mdhn.jpg)

bin_id对应AGEs.fasta和AGEs.key.txt文件名称；annotation(s)对应所包含基因信息（对应为each entry)和百分率(对应该基因核酸长度): PA2185[100%]"non-heme catalase KatN", PA2186[100%]"heyothetical protein"

Subelements.key.txt AGEs的subelements的特性，subelements为AGEs基于AGE在输入文件中的分布的subdivisions

![image-20190709114019568](http://ww3.sinaimg.cn/large/006tNc79gy1g4tfr3l4stj31rg08edir.jpg)

subelements.fasta subelements序列的核酸序列文件，默认对应输出至少100bp的长度序列，可有参数--min_se_seq选项调整

![image-20190709114156039](http://ww4.sinaimg.cn/large/006tNc79gy1g4tfsry2uij311g08awfj.jpg)

subelements.annotations.txt 包含在subelement区域的基因信息

![image-20190709114245579](http://ww1.sinaimg.cn/large/006tNc79gy1g4tftmz29aj311e084mzb.jpg)

subelements.csv 输入文件中的subelement分析信息

![image-20190709114349716](http://ww2.sinaimg.cn/large/006tNc79gy1g4tfur8hu4j311a060aay.jpg)

subelements.alignments.txt 包含在每个输入genome的subelements的来源

![image-20190709114509416](http://ww1.sinaimg.cn/large/006tNc79gy1g4tfw5dx5wj311e08cgnd.jpg)

graphs folder 包含输出的AGE的分布图

![image-20190709114813627](http://ww2.sinaimg.cn/large/006tNc79gy1g4tfzc3t7pj31wk0e6k06.jpg)

![image-20190709115520400](http://ww2.sinaimg.cn/large/006tNc79gy1g4tg6rwzlkj31w40e27ea.jpg)

***





