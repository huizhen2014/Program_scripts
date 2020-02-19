#### [KEGG PATHWAY Database][https://www.genome.jp/kegg/pathway.html]

#####[Pathway Maps][https://www.genome.jp/kegg/pathway.html]

KEGG PATHWAY是人工审核的代表分子间相互作用, 反应和相互关系的网络图:

* Metabolism: [Global/overview](https://www.genome.jp/kegg/pathway.html#global)  [Carbohydrate](https://www.genome.jp/kegg/pathway.html#carbohydrate)  [Energy](https://www.genome.jp/kegg/pathway.html#energy)  [Lipid](https://www.genome.jp/kegg/pathway.html#lipid)  [Nucleotide](https://www.genome.jp/kegg/pathway.html#nucleotide)  [Amino acid](https://www.genome.jp/kegg/pathway.html#amino)  [Other amino](https://www.genome.jp/kegg/pathway.html#other)  [Glycan](https://www.genome.jp/kegg/pathway.html#glycan)  [Cofactor/vitamin](https://www.genome.jp/kegg/pathway.html#cofactor)  [Terpenoid/PK](https://www.genome.jp/kegg/pathway.html#pk)  [Other secondary metabolite](https://www.genome.jp/kegg/pathway.html#secondary)  [Xenobiotics](https://www.genome.jp/kegg/pathway.html#xenobiotics)  [Chemical structure](https://www.genome.jp/kegg/pathway.html#chemical) 
* Genetic Information Processing
* Environmental Information Processing
* Celluar Processes
* Organismal Systems
* Human Diseases
* Drug Developement

KEGG PATHWAY是[KEGG Mapper][https://www.genome.jp/kegg/mapper.html] 用于pathway mapping的参考数据库; 其中各个PATHWAY又细分为多个项

##### Pathway Identifiers

![image-20200218192326015](https://tva1.sinaimg.cn/large/0082zybpgy1gc0rxzhb7ej313m0duadb.jpg)

##### [Functional Hierarchies][https://www.genome.jp/kegg/brite.html]

KEGG BRITE是一个等级分类系统, 包含多种生物对象(biological objects)的功能性等级分类. 这些生物对象生物实体, 从分子到更高水平的被KEGG所收录的数据, 例如基因和蛋白, 小分子, 反应, 通路, 疾病和药物.

KEGG BRITE集合了多种不同类型的关系:

[**1. Genes and Proteins**](https://www.genome.jp/kegg/brite.html#gene)
[**2. Compounds and Reactions**](https://www.genome.jp/kegg/brite.html#compound)
[**3. Drugs**](https://www.genome.jp/kegg/brite.html#drug)
[**4. Diseases**](https://www.genome.jp/kegg/brite.html#disease)
[**5. Organisms and Cells**](https://www.genome.jp/kegg/brite.html#organism)

KEGG BRITE是[KEGG Mapper][https://www.genome.jp/kegg/mapper.html]用于brite mapping的参考数据库

#####Brite Identifiers

![image-20200218193633369](https://tva1.sinaimg.cn/large/0082zybpgy1gc0sbn0qyfj313g06iabj.jpg)

##### [KEGG MODULE Database][https://www.genome.jp/kegg/module.html]

KEGG MODULE database目前正改变为主要针对于代谢通路.

1. 非代谢通路的模型和分子复合体都被去除. 相同数据可以在KEGG BRITE数据中得到, 同时KEGG Mapper的Reconstruct Pathway tool可用于完整性检测.
2. 通过RM numbers识别的Reaction modules被合并到MODULE flat文件中, 供DBGET搜索系统使用. 在html文件中仍可查询到反应模型的实际内容.
3. MODULE flat文件不再包含物种特异性的完整模型. 所有模型, 完整或不完整的, 和物种特异性的, 仍然可在module map界面查询到

**KEGG MODULE数据目前由KEGG modules, 由M number代表, 和KEGG reaction modules, 由RM number代表, 所组成. 它们是人工审核定义的基因集和反应集的功能单元. KEGG modules进一步划分为pathway modules和signature modules.**

* pathway modules: 基因集, 包括分子复合体, 在代谢通路中的功能单元
* signature modules: 表现出表型特征的基因集的功能单元
* reaction modules: 代谢通路中连续性反应步骤的功能单元

完整的KEGG modules和KEGG reaction modules可在BRITE hierarchy 文件中查看到:

[KEGG modules](https://www.genome.jp/kegg-bin/get_htext?ko00002.keg)/[KEGG reaction modules](https://www.genome.jp/kegg-bin/get_htext?ko00003.keg)

##### [KO][https://www.kegg.jp/kegg/ko.html]

**KO(KEGG Orthology)数据库是一个分子功能数据库, 以functional othologs来表示. functional ortholog是人工定义的KEGG 分子网络内容, 也就是KEGG pathway maps, BRITE hierarchies和KEGG modules. 例如, 当一个通路图被绘制, 每个box为给定的一个KO identifier(K number), 同时特异性的物种的实验验证的基因和蛋白被用来在其他物种中搜索orthologs. **

KO system是一个基于网络的KOs分类, 包含6个KEGG pathway maps大类, 一个BRITE hierarchies大类和其他没包含在以上两大类的一个类别. 

KO Assignment and KEGG Mapping: KEGG中的基因组注释包含两个独立的方向, ortholog注释和network重构.

Otholog annotaion(KO assignment): 储存在KO(KEGG Orthology)数据库中的分子功能包含了实验验证了的基因/蛋白的同系物; KEGG中的基因组的注释为关联基因组中基因到KO identifier(KO number).

Network reconstruction(KEGG mapping): Functional othologs定义为KEGG pathway maps和其他分子网络, 均通过K number节点构建成网络; 通过KEGG mapping, 基因组注释过程将基因组中的一个基因集转换为一个K number集, 用于自动重建KEGG pathways和其他网络, 使之能够解释高水平功能(不分物种搜索).

![image-20200218225727377](https://tva1.sinaimg.cn/large/0082zybpgy1gc0y4ptufrj312u05u0tz.jpg)

##### [KEGG Mapper][https://www.genome.jp/kegg/mapper.html]

KEGG Mapper是用于KEGG mapping的工具集, 包含最流行的KEGG pathway mapping, 还有BRITE mapping和MODULE mapping. 'Reconstruct Pathway', 'Search Pathway'和'Search&Color Patway'允许同时进行多重比多操作. 'Color Pathway'和'Join Brite'用于比对单个pathway map或单个birte hierarchy/table 文件.

#####General mapping tools against multiple databases

[Reconstruct Pathway][https://www.genome.jp/kegg/tool/map_pathway.html]为基本的比对工具, 支持基因组和metagenome注释. 用于处理KO annotation(K number assignment)数据, 可在内部针对KEGG GENES, 外部使用[BlastKOALA][https://www.kegg.jp/blastkoala/]服务器, 以及其他注释服务器. **输入数据为针对单个物种的单个基因列表或者针对多重物种的多个基因列表; 每个基因列表格式为`gene_id	K number`; 通过K numbers将其进行pathway maps/brite hierarchies/brite tables/modules比对.**

[Search Pathway](https://www.genome.jp/kegg/tool/map_pathway1.html) 和 [Search&Color Pathway](https://www.genome.jp/kegg/tool/map_pathway2.html) 为KEGG 项目开始使用的传统工具, 但是其数据库已经得到扩展. 当对象同时存在参考数据和物种特异性通路中时, 这些工具方实现匹配. **针对给定的对象(genes, proteins, compouds, glycans, reactions, drugs, etc), 根据搜索模式搜索KEGG pathway maps/Brite hierarchies/Brite tables/KEGG modules/KEGG network variation maps/KEGG disease entries; 输入为空格或换行隔开的KEGG identifiers.**

![image-20200218201706697](https://tva1.sinaimg.cn/large/0082zybpgy1gc0thtzhnlj30wg0l4gpi.jpg)

针对不同的工具, 其搜素数据需要经过不同处理

![image-20200218201805013](https://tva1.sinaimg.cn/large/0082zybpgy1gc0tiuj6yij30wu09s767.jpg)

##### [KEGG Annotation][https://www.genome.jp/kegg/annotation/]

KEGG database包含三个主要组成用于genome/metagenome注释:

* 完整基因组(KEGG organisms)的注释基因分类
* KEGG PATHWAY, BRITE和MODULE中的, 已知的高水平的功能关系, 包含分子相互作用, 反应和关系网络
* KO database中已知的分子水平相关的ortholog groups, 大部分KO entries定义为context-dependent manner, 作为KEGG 分子网络的节点

**一般而言, KO entries(K numbers)以代表了序列相似性groups. 因此, KEGG GENES中 query genome的序列相似性搜索就在在搜索最恰当的K numbers, 并且得到的K numbers集合可用于重建KEGG pathway maps, BRITE hierarchies和KEGG modules**, 用于即使高水平功能相互作用([BlastKOALA][https://www.kegg.jp/blastkoala/]/[GhostKOALA][https://www.kegg.jp/ghostkoala/])

##### Otholog Table

**OT(orthology table)自KEGG项目初就一直存在. 针对给定的一套K numbers, 用于展示基因在KEGG organisms中的位置:**

![image-20200218205000752](https://tva1.sinaimg.cn/large/0082zybpgy1gc0ug2da21j313o03sjro.jpg)

##### Module Table

**MT(module table)是KEGG新的注释资源. 针对给定的一组M &/ K numbers, 识别包含完整modules &/ KO groups的完整模型:**

![image-20200218205154503](https://tva1.sinaimg.cn/large/0082zybpgy1gc0ui1ih37j313c03e3yr.jpg)

***

***

***

####非模式生物KEGG pathway分析

####1. 基因组蛋白注释

* 使用[KAAS][https://www.genome.jp/tools/kaas/](kegg automatic annotation server)对基因进行功能性注释. 通过BLAST/GHOST对序列进行人工审核的KEGG GENEs数据库注释. 结果包含KO(KEGG Orthology)和自动生成的KEGG pathways.

![image-20200218214805204](https://tva1.sinaimg.cn/large/0082zybpgy1gc0w4jpz9gj31880a8755.jpg)

**Complete or Draft Genome: 针对基因组中的完整的一整套基因而言, KASS注释效果最好. 准备氨基酸序列并使用BBH(bi-directional best hit)搜索:[KAAS job request (BBH method)](https://www.genome.jp/kaas-bin/kaas_main)**

**Partial Genome: KASS同样可用于有限数目的基因搜索. 准备氨基酸序列并使用SBH(single-directional best hit)搜索同源序列: [KAAS job request (SBH method)](https://www.genome.jp/kaas-bin/kaas_main?mode=partial)**

**Metagenomes: 当搜索序列包含来自混合物种的大量序列时, 例如来自metagenome测序数据, 推荐使用GHOSTX搜索和SBH搜索: [KAAS job request (SBH method for amino acid sequence query)](https://www.genome.jp/kaas-bin/kaas_main?prog=GHOSTX&way=s)**

* 使用[BlastKOALA][https://www.kegg.jp/blastkoala/](automatic annotaion and KEGG mapping service)自动注释和比对. KOALA(KEGG Orthology And Links Annotation)为使用SSEARCH计算用于注释K number的KEGG内部注释工具. BlastKOALA和GhostKOALA都可使用一套非冗杂的KEGG GENES, 针对提交序列分别进行BLAST和GHOSTX搜索. KofamKOALA是使用HMM profile搜索的注释工具.

![image-20200218214740688](https://tva1.sinaimg.cn/large/0082zybpgy1gc0w4485fvj316u0di76m.jpg)

**其中BlastKOALA接受较小的查询序列文件, 适用于注释高质量基因组; GhostKOALA接受较大的数据集, 适用于指示metagenomes; KofamKOALA使用KOfam(a customized HMM database of KEGG Orthologs(KOs)), 可设置阈值进行过滤.**

完成注释后, 获得蛋白名称所对应的K numbers; 根据分析所需, 例如将蛋白名称更换为locus_tag信息:![image-20200218213445915](https://tva1.sinaimg.cn/large/0082zybpgy1gc0vqmpc9uj312403wwf3.jpg)

####2. 通路注释

* 提取其中的k nubmers, 使用[KO(KEGG ORTHOLOGY) Database)][https://www.kegg.jp/kegg/ko.html]对K numbers进行KEGG pathway/BRITE/MODULE mapping(不限制物种).

![image-20200218215326608](https://tva1.sinaimg.cn/large/0082zybpgy1gc0wa29260j314s0ae0vv.jpg)

![image-20200218215442003](https://tva1.sinaimg.cn/large/0082zybpgy1gc0wbdhdp1j313a07kab2.jpg)

选择Map pathway, 完成注释后跳转至结果页面:

![image-20200218230223879](https://tva1.sinaimg.cn/large/0082zybpgy1gc0y9veflmj313c0ck0ud.jpg)

* 或使用其中的k nubmers, 使用KEGG Mapper [Search Pathway](https://www.genome.jp/kegg/tool/map_pathway1.html)注释(可选物种):

![image-20200218230658754](https://tva1.sinaimg.cn/large/0082zybpgy1gc0yems2oij31ew0lggp0.jpg)

选择对应物种缩写, 完成注释后跳转至结果页面:

![image-20200218230540435](https://tva1.sinaimg.cn/large/0082zybpgy1gc0yd9lz4fj315e0cotas.jpg)

#### 3. 下载对应网页内容使用RCurl或浏览器resource下载并解析

这里选择的是BlastKOALA注释得到的K numbers, 然后使用KEGG Mapper Search Pathway比对, 选择物种abu(鲍曼):

Pathway:

![image-20200219144147615](https://tva1.sinaimg.cn/large/0082zybpgy1gc1pfaj4k2j31sq0bi76a.jpg)

写R脚本解析获得:

![image-20200219142104026](https://tva1.sinaimg.cn/large/0082zybpgy1gc1otogcl3j31sq088jv1.jpg)

Module:

![image-20200219143501722](https://tva1.sinaimg.cn/large/0082zybpgy1gc1p87fqckj31ti0bu0ux.jpg)

解析可得:

![image-20200219143547589](https://tva1.sinaimg.cn/large/0082zybpgy1gc1p901eynj31vs06cju3.jpg)

#### 4. 调用clusterProfiler包, 使用enricher函数富集

[enricher][https://bioconductor.org/packages/release/bioc/manuals/clusterProfiler/man/clusterProfiler.pdf]是一个通用的富集分析工具, 分析需要准备差异基因(gene), gene和注释term(ko/M)之间的对应关系文件(TERM2GENE), 还可以提供可选的背景基因(universe)和term对应的名称文件(TERM2NAME).

![image-20200219154422646](https://tva1.sinaimg.cn/large/0082zybpgy1gc1r8db1b2j31rs0fadi9.jpg)

#### 5. 绘图

略！





































