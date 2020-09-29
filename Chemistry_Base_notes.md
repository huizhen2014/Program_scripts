* [Query Guide][[https://docs.chemaxon.com/display/docs/JChem_Base_User%27s_Guide.html](https://docs.chemaxon.com/display/docs/JChem_Base_User's_Guide.html)]

1. Search Types

#####Full structure search; substructure search

被检测的分子称之为target, 查找的结构称之为query, 同时一个匹配query结构的target分子称之为hit

![image-20200928093952639](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928093952639.png)

#####Other search types

除全结构和亚结构搜索外, JChem还支持相似性(similarity), 重复(duplicate), 超结构(superstructure)和全片段类型(full fragment type searches)搜索.

**Similarity**用于查找类似化学结构. 默认使用Tanimoto metric of chemical hashed fingerprints, 同时也支持其他筛选配置[JChem Screem][https://docs.chemaxon.com/display/docs/Introduction_to_Virtual_Screening.html] integration. 对于后者, 额外的descriptor tables需要添加到数据库, 和Chem table相连.

**Duplicate**主要用于在数据插入前查看给定的分子是否已经包含在数据库中. 这里所有的分子特征都必须相等, e.g., non-stereo query将仅匹配non-stereo target, etc. 

**Superstructure**是亚结构所有的相反搜索形式: 在target分子搜索出现在给定超结构query中的分子(这里, target和query分子简单的交换位置). 非query特征循序出现的query侧链.

**Full fragment**位于亚结构和全结构搜索之间: query必需完全匹配target的一个fragment. 其他fragments也可存在target中. 该搜索对于忽略taget中盐或溶剂侧链的主要结构搜索很有用.

![image-20200928095338208](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928095338208.png)

搜索特征定义:

![image-20200928095458653](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928095458653.png)

FULL and DUPLICATE search differences

![image-20200928095553385](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928095553385.png)

SUBSRUCTURE serach

![image-20200928095855291](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928095855291-20200928095955405.png)

Full fragment search

![image-20200928100101487](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928100101487.png)

Full structure search

![image-20200928100126599](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928100126599.png)

Duplicate search

![image-20200928100147648](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928100147648.png)

##### Searching in the database

数据库中搜索包含一个快速的提前过滤步骤(prefiltering step), 可筛选出许多不匹配query的target. 该步骤使用chemical hashed fingerprints. Document: [Paramters for Generating Chemical Hashed Fingerprints][https://docs.chemaxon.com/display/docs/Chemical_Hashed_Fingerprint.html].

##### Comparison levels

Graph topology

图形包含nodes和edges. 当我们比较描述为graphs的structures时, graph patterns 必需匹配. Atoms对应nodes, bonds对应edges.

Atom types

针对molecular structures. 简单比较graph patterns是不够的, atoms的类型和bonds也必须检查.

Stereo configuration

即使topology和对应的atoms, bonds类型一致, 还需要检查stereochemical configuration. 两个具有相同类型的atoms, 被相同类型bonds连接的分子可以存在stereochemical差异. 连接到chiral atoms(手性原子, R/S isomers), chiral atoms上增强的stereo labels和stereo labels位于rings或双键(cis/trans or E/Z isomers)上的相对位置决定了该分子的stereochemical configuration.

2. Similarity search

相似性搜索查询类似query structure的分子. 该相似性基于化学结构的[molecular descriptors][https://docs.chemaxon.com/display/docs/Fingerprint_and_descriptor_generation_-_GenerateMD.html]或比较的化学结构的[fingerprints][https://docs.chemaxon.com/display/docs/JChem_Chemical_Database_Concepts.html#src-1806737_JChemChemicalDatabaseConcepts-fingerprints]. molecular descriptor时一个组和分子的分子结构相关的值. 'molecular descriptor' 指的是所有类型的structure keys, hashed fingerprints, binary fingerprints, 不同类型的pharmacophore fingerprints和scalar values. 这里有多个用于计算的[metrics][https://docs.chemaxon.com/display/docs/Similarity_search.html#src-1806745_Similaritysearch-metrics].

JChem Base包含两种不同类型的内建fingerprint方法: 针对分子的chemical hashed fingerprints和针对反应的reaction fingerprints.

Similarity search in file常基于内建的chemical hashed fingerprints和reaction fingerprints用于分子和反应搜索.

Similarity search in database不仅可以基于内建的chemical hashed fingerprints, 还可以基于其他筛选方式.

Chemical Hashed Fingerprints和Reaction Fingerprints在数据导入过程中自动生成在JChem tables中; similarity搜索默认使用这些生成fingerprints.

#####Metrics

Similarity/Dissimilarity metrics for molecular

JChem提供多种metrics用于计算similairty/dissimilarity值. 一些metrics(例如Tanimoto)提供similarity值, 一些metrics(例如Eucliden)提供dissimilarity值. Similarity(S) 值可通过dissimilarity(D)值计算而来: S=1-D(Euclidean metric).

![image-20200928103046915](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928103046915.png)

Reaction fingerprint metrics

这里介绍两种类型的reaction similarity计算: structural 和 transformational. Structural 识别reactant和product sides, Transformational和3个coarseness相关. 详见: [Reaction fingerprint metrics][https://docs.chemaxon.com/display/docs/Reaction_fingerprint_RF.html#src-1806335_ReactionfingerprintRF-similmetr].

#####Hit display

Simmilarity 搜索的Hit display包含最大的公共substructure的颜色, 和所选择显示的值(similarity or dissimilarity score, query structure, other labels and boxes). 详见: [here][https://docs.chemaxon.com/display/docs/Hit_display-coloring.html#src-1806765_Hitdisplay-coloring-similar].

#####How to  perform similarity search

Similarity 搜索默认基于内建的molecular descriptors进行(chemical hashed fingerprints for molecular and reaction fingerprint for reactions). 

Search type as similarity search: [search type][https://docs.chemaxon.com/display/docs/General_search_options.html#src-1806776_Generalsearchoptions-searchtype]

![image-20200928104016964](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104016964.png)

The desired molecular descriptor/fingerprint - if they were added to the target table or the target file; the desired dissimilarity metric: [dissimmilarity metric][https://docs.chemaxon.com/display/docs/Similarity_specific_search_options.html#src-1806775_Similarityspecificsearchoptions-dissimilaritymetrics]

Dissimilarity metrics

![image-20200928104419579](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104419579.png)

Dissimilarity threshold for similarity search

![image-20200928104317564](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104317564.png)

The desired hit display options:[hitdiaplsy options for similarity search][https://docs.chemaxon.com/display/docs/Hitdisplay_specific_search_options.html#src-1806779_Hitdisplayspecificsearchoptions-similarity](similarity, query display, display labels and boxes)和如何设置: [coloring optins][https://docs.chemaxon.com/display/docs/Hitdisplay_specific_search_options.html#src-1806779_Hitdisplayspecificsearchoptions-coloring]

Alignment

![image-20200928104804150](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104804150.png)

Coloring

![image-20200928104823831](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104823831.png)

Hit color

![image-20200928104844713](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104844713.png)

Hit homology color

![image-20200928104912577](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104912577.png)

Non-hit color

![image-20200928104934332](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928104934332.png)

3. Fingerprint and descriptor generation - GenerateMD

GenerateMD是一个生成多个molecular descriptors的应用程序, 包括chemical fingerprints, 为[ChemAxon Chemical Fingerprint][https://docs.chemaxon.com/display/docs/Chemical_Hashed_Fingerprint.html]和[ECFP][https://docs.chemaxon.com/display/docs/Extended_Connectivity_Fingerprint_ECFP.html], 同时还有[2-dimensional pharmacophore fingerprints][https://docs.chemaxon.com/display/docs/Pharmacophore_Fingerprint_PF.html]和[reaction fingerprints][https://docs.chemaxon.com/display/docs/Reaction_fingerprint_RF.html], 以及分子结构的结构关键词(structural keys of molecular structures). 这些descripors可用于描述分子, 针对该化学, 结构和药理学特征搜索大的化合物文库.

##### Molecular descripors

'Molecular descriptors'指的是所有类型的结构关键词(structural keys), hashed fingerprints, 不同类型的pharmacophore fingerprints和scalar values. 一般定义为, 一组和二维或三维分子结构相关的值. 其生成过程从一个分子结构开始, 通过多种特征识别和转换步骤生成一系列值. 根据descriptor这些值可以是bits, integer或real numbers. 

'Molecular descriptors'从分子结构生成. 尽管不同的descripors使用不同的处理步骤, 该过程仍然包含许多共有步骤.

'Descriptors'属于一个分子, 可以存在相关的数据库中. 对于一个结构的descriptors数目没有限制. 不同的descriptors存在不同的structure table中. 需要记得structure table的名字对应的molecular来源的descripor名称.

##### Usage

'GenerateMD'拥有两种不同方式使用: 命令行传递参数或传递包含参数的XML配置文件.

![image-20200928113741009](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928113741009.png)

GenerateMD最典型的使用方式就是生成molecular descriptors. 同时其他一些操作也和descriptors生成相似. 当descriptors已经存储在数据库中时, 可以使用GenerateMD命令去对其处理. 此外, 高度建议不要使用general purpose database management tools, 因为structure tables的完整性和descriptors很容易被破坏.

`u` (update), 用于将新结构导入structure table中; `d` (delete) 删除不需要的descriptors

随着descriptors的生成, 一些其他信息也会存在数据库中: descriptor名称(例如 Pharma-for-H1), descriptor类型(例如 PF), 和用于描述descriptor生成的配置参数.

Input: 从文本文件或数据集获得分子. 输入文件同通过命令类型所指定. `-q/--query`定义为来自数据集的输入;  输入文件应为molecular structure 文件, MDL molfile, Compressed molfile, [SDfile][https://docs.chemaxon.com/display/docs/Tripos_SYBYL_MOL_format.html], Compressed SDfile, [SMILES][https://www.daylight.com/smiles/index.html]. 

加入输入文件为SDfile, 它可能已经包含了descriptor(或一部分), 或其他用于descriptor生成的数据(例如, pha rmacophore map, the list of pharmacophore points, 用于生成pharmacophore fingerprint). 这些存在的数据可以被使用或在descriptor生成过程中删除. 默认操作时删除, `-P/--PMAP`参与表示使用.

Output: GenerateMD可输出descriptor为文本文件(`-o/--output`), 或当定义数据集选项时输入一个数据集(`.jchem`). 若没有指定输出, 屏幕暑促可读文本.

Descriptors: 当构建或升级一个descriptors时, 必需使用`-k`参数, 后跟随Descriptor类型: CF, PF, Burden eigenvalue, descriptor(or BCUT), 以及多种scalar descriptors. 

CF: Chemical fingerprint, 将分子结构的拓扑结构编码成一个bit字符串. 

RF: [Reaction fingerprint][https://docs.chemaxon.com/display/docs/Reaction_fingerprint_RF.html], 用于反应搜索和反应类似性搜索.

File output: 在使用SDfiles输入时, SDF输出可通过参数`-S`指定. 否则输出为descriptor文件. 该descriptor文件为可读型text文件.

Database output: descritptors输出可以保存在databse tables. 自动输出合适的table. 

4. [jcsearch Command Line Tool][https://docs.chemaxon.com/jcsearch_Command_Line_Tool.html]

略！！！

Without Licensce !

5. Chemical File Format - Structure Data Format ([SDF][http://www.nonlinear.com/progenesis/sdf-studio/v0.9/faq/sdf-file-format-guidance.aspx])

SDF数据格式时表示多重化学结构记录和相关数据值的化学文件格式. 

Molfiles为文本文件包含单个分子化合物的结构信息. SDFs包含一系列molfiles, 和一些额外的关于化合物的信息. 常用于分享化合物结构数据文库.

![image-20200928173125649](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928173125649.png)

一个化合物的记录包含多个不同的部分. 首先, 是一个3行的头部分内容. 这3行可能包含: 分子名称; 生成该化合物结构的软件信息; 相关内容. 同时, 以上所有3行也可能都没有. 该例子中, 分子名称为'702', 由'-OEChem-02271511112D'生成, 其相关内容信息为空.

The Counts line

接下来是'Counts'行. 该行由12个固定长度的部分组成, 前11个为3个字符长, 最后一个为6个字符长. 其中, 前两个位置是最重要的, 表示为化合物中atoms和bonds的数目:

![image-20200928173835813](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928173835813.png)

这里表示: 9个atoms和8个bonds. 一般而言, H (hydrogens), 尤其是和carbon或oxygen相连的, 一般都被模糊省略掉(will be included based on the available valences).

The Atoms block

下一行为atoms block. 描述了counts line的第一位置的atoms信息:

![image-20200928174121889](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928174121889.png)

这里, 前3个位置, 每个为10个字符长, 描述了化合物中atom在X/Y/Z三维结构中的位置. 而后是一个空格, 和atomic symbol的三个字符(O代表氧). atomic symbol后, 两个字符为monoisotope的mass差异. 该位置仅支持-3到+4之间到值, however - the M..ISO property can be used for values outside this range.

接下来是针对charge的3个字符. 这些值意义见下表, 也可使用M..CHG property取代, which is much less confusing and also supports a wider range of values.

![image-20200928175430923](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928175430923.png)

接着会有另外10个3个字符长度的位置, 基本不会使用.

The Bonds block

Atoms block后就是它们之间的bonds. 该部分的长度由counts line中的数目所决定. 

![image-20200928175843763](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928175843763.png)

前2个位置为包含在该bond中的atoms的indexes(从1开始). 第3个位置定义了bond的类型 ,第四个为bond的stereoscopy(立体映像). 

![image-20200928220320918](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928220320918.png)

因此该例子: 在第1个和第2个atom之间, 添加单个, 非立体的bond. 此外, 还有3个位置, 每个都是3个字符, 很少使用.

Properties

![image-20200928220545557](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928220545557.png)

在M..CHG之后的第1个数字定义了该行的带电荷的数目(最多为8). 如果化合物包含超过1个电荷, 可增加额外的M..CHG行. 每个电荷记录包含2个包含由4个字符所组成的信息, 第1个为带电atom的index(从1开始计数), 第二个该atom的电荷数目. 这里为: 向第1个为+2的atom加上一个电荷.

![image-20200928221536849](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928221536849.png)

位于M..ISO之后,  第1个数目定义了该行中isotopes的数目(最多为8). 若化合物包含不止一个同位素, 可增加额外的M..ISO行. 每个isotope由包含4个字符的2个位置信息组成. 第1个为atom的index, 第二个为atom的实际mass number. 这里表示, 第1个atom拥有一个为2的atomic mass.

![image-20200928221858319](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928221858319.png)

M..END是强制性的, 必需包含在properties list的末尾.

Data fields

多种针对一个化合物的多种信息可存储在该数据位置(data field). 该位置信息以一个header开始, 以一个`>`开始. 之后数据位置信息的名称写入带角的括号中. 

![image-20200928222338190](https://gitee.com/huizhen2014/Pic/raw/master/image-20200928222338190.png)

header后, 数据位置信息可以包含一个或多个行, 每行至多200个文本字符. 这些都是数据位置信息的值.

![image-20200928222641161](https://gitee.com/huizhen2014/Pic/raw/master/20200928222641.png)

SDF separator ($$$$)

该内容不要求出现在molfiles,  SDF 数据中每个记录的最后一行近包含4个美元符号($$$$).

![image-20200928222808340](https://gitee.com/huizhen2014/Pic/raw/master/20200928222808.png)

6. [SMILES][https://archive.epa.gov/med/med_archive_03/web/html/smiles.html] 

Simplified Molecular Input Line Entry System, 是一个化学标记用于展示一种可悲计算机使用的化学结构.

SMILES拥有5个基本的必需遵守的语法规则.

Rule One: Atoms and Bonds

SMILES支持所有元素周期表中的单元. 一个元素使用其代表性的元素符号表示. 大写表示非芳香族元素, 小写表示芳香族元素. 假如元素符号拥有超过一个字符, 第二个字符必需小写.

![image-20200929134713687](https://gitee.com/huizhen2014/Pic/raw/master/20200929135232.png)

单键为默认值, 因此无需输入. 'CC'表示存在一个非芳香族C通过单键连接到另一个非芳香族C. 同时也会假设2个小写元素符号之间的键是芳香族的键. 空格表示SMILES字符终止.

Rule Two: Simple Chains

通过合并元素符号和键符号可以标注简单的链结构. 该结构省略了H. SMILES软件可以根据输入情况自动添加H.

![image-20200929135221239](https://gitee.com/huizhen2014/Pic/raw/master/20200929135221.png)

用户可以清晰识别H键, 若字符中存在一个H键, 那么SMILES将会认为输入的内容已经识别出了该分子的所有H键.

![image-20200929135422200](https://gitee.com/huizhen2014/Pic/raw/master/20200929135422.png)

由于SMILES允许所有元素周期表中单元, 因此'Sc'可能会被解释为S原子和一个芳香族c相连, 或为元素Sc(钪). SMILES优先解释为一个S原子连接一个芳香族c. 为区别, 应输入[Sc]来表示Sc(钪).

Rule Three: Branches

链的分子可以通过向括号内放置一个SMILE符号来实现. 括号中的元素表示直接相连其前一个元素. 假如连接是双或三键, 该键符号紧跟左括号.

![image-20200929140102247](https://gitee.com/huizhen2014/Pic/raw/master/20200929140102.png)

Rule Four: Rings

SMILES允许通过数字表示开或闭环原子来识别环状结构. 例如, C1CCCCC1, 第1个C拥有数字‘1’, 该C和最后一个拥有数字'1'的C通过单键连接. 这产生的结构为环己烷. 含有多个环科通过不同的环的数字来识别. 假如, 双, 单或芳香键用于一个闭环, 那么该键符号位于闭环数目前.

![image-20200929141042058](https://gitee.com/huizhen2014/Pic/raw/master/20200929141042.png)

Rule Five: Charged Atoms

一个元素的电荷可用于覆盖化合价信息. 带电荷元素的格式包含元素和随后包含电荷的大括号. 电荷数目可以明确表示为({-1})或模糊表示({-}).

![image-20200929141405722](https://gitee.com/huizhen2014/Pic/raw/master/20200929141405.png)



























