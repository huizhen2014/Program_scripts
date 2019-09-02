###Configuration

####File Organization

文件结构建议，对于不同的图片使用不同的文件目录。将配置文件放置到etc/中，数据放置在data/中，circos将自动查找主要配置文件circos.conf。

![image-20190627125242390](http://ww3.sinaimg.cn/large/006tNc79gy1g4fmeq7ki2j30xu0983z7.jpg)

这样配置，就可以直接运行circos，无需添加-conf circos.conf参数。同时默认输出文件路径同circos.conf文件所在路径(dir = conf(congifdir))，可修改：

`circos -outputfile snp.png [-outputdir /tmp]`

无需使用绝对路径，因为circos会在当前路径，配置文件路径，软件以及它们的相对几个路径查找主要配置文件和其中所需的数据文件，例如(不完整)：

![image-20190627130429518](http://ww4.sinaimg.cn/large/006tNc79gy1g4fmqz36xmj30yk0703z7.jpg)

####circos.conf

配置文件格式，variable=value；简单定义在block中

![image-20190627140101805](http://ww4.sinaimg.cn/large/006tNc79gy1g4fodtb1t5j30oi04474j.jpg)

或多层blocks

![image-20190627140202508](http://ww1.sinaimg.cn/large/006tNc79gy1g4foev9ee5j310k0cqq3x.jpg)

[配置文件参数][http://circos.ca/documentation/tutorials/configuration/configuration_files/]可指定4部分(\<plots>, \<plot>, data, \<rule>)，重要程度依次递增，后者可覆盖前者，因此可在使用时相同类别可嵌套。

针对一些不需要更改的配置，例如颜色和字体，使用过程中保持默认配置就可，使用`<<include …>>`进行选择，`<<include CONFIG_FILE_PATH/CONFIG_FILE>>`：

![image-20190627141700269](http://ww3.sinaimg.cn/large/006tNc79gy1g4foufo9w0j317q07yq4h.jpg)

若包含用户设置的路径，circos同样会在该路径下及对应相对路径搜索目标文件。

![image-20190627142305406](http://ww4.sinaimg.cn/large/006tNc79gy1g4fp0rgcpvj30xo06k0to.jpg)

同时可设置参数使用其他参数质

![image-20190627143419043](http://ww4.sinaimg.cn/large/006tNc79gy1g4fpcfq018j30v00700th.jpg)

使用eval进行perl脚本计算: thickness = eval(1+1);  eval(1.05 . "r")

#### Color

`<colors>`包含了所有颜色定义，最简单方式为导入默认颜色配置文件

`<<include etc/colors.conf>>`包含默认设定好colors.brewer.conf, colors.uscs.conf, colors.hsv.conf

![image-20190627155125842](http://ww3.sinaimg.cn/large/006tNc79ly1g4frkojujzj31260dwjth.jpg)

####Data Files

circos需要提供染色体定义文件，data tracks(\<plot>blocks)文件，links(\<link>blocks)文件和highlights(\<highlight>blocks)文件。

* KARYOTYPE,，名字，标签，起点，终点，颜色

![image-20190627171451864](http://ww3.sinaimg.cn/large/006tNc79gy1g4ftzhtk5vj30u203gdg5.jpg)

* LINE, SCATTER, HISTOGRAM, HEATMAP图对应KAYOTYPE的位置信息

![image-20190627172405512](http://ww4.sinaimg.cn/large/006tNc79gy1g4fu93bx9kj30pq02m0su.jpg)

* TEXT，定义染色位置相关的内容信息

![image-20190627172421913](http://ww1.sinaimg.cn/large/006tNc79gy1g4fu9dmm81j30rs02q0sv.jpg)

* CONNECTOR，连接相同染色体上的两个位置，起点终点必须在同一染色体

![image-20190627172437481](http://ww2.sinaimg.cn/large/006tNc79gy1g4fu9n13n2j30rw02mjrh.jpg)

* LINKS，连接相同或不同染色体的两个相关区间

![image-20190627172239951](http://ww1.sinaimg.cn/large/006tNc79gy1g4fu7m1i6hj30t80360t3.jpg)

#### Runtime Parameters

命令行使用-debug_group选项选择输出运行内容，显示所有输出内容名称

`circos -debug_group`

增加输出其他内容

`circos -debug_group +timer,+io`

或指定输出/全部输出

`circos -debug_group timer`

`circos -debug_group _all`

命令行调整输出文件路径和名称-outputdir, -outputfile，覆盖配置文件输出；这些参数一般在\<image>模块中

![image-20190627173402366](http://ww1.sinaimg.cn/large/006tNc79gy1g4fujhf4l9j30uk0520t4.jpg)

查看所有内部配置树状信息

`circos -cdump`

`circos -cdum | grep default_color`

`default_color => "black"`

`circos -cdump ideogram`

命令行修改配置文件参数值，以下将修改模块\<block1>\<block2 >中的name值

`circos -param block1/block2/…/name=value`

![image-20190627173748230](http://ww2.sinaimg.cn/large/006tNc79gy1g4funcw8w8j30ta03e0t6.jpg)

#### PNG/SVG输出

默认条件下输出为：3000x3000pixels，白色背景，circos.png文件。默认包含在:

`<<include etc/image.conf>>`

![image-20190627175210041](http://ww1.sinaimg.cn/large/006tNc79gy1g4fv2ax1upj30ye0e0acd.jpg)

angle_offset=-90，表示第一个idogram出现位置，这里为图像上部

若需要修改覆盖，使用*后缀语法

![image-20190627175325536](http://ww4.sinaimg.cn/large/006tNc79gy1g4fv3luiovj30u405q0t9.jpg)

SVG为scalable vector graphics, 使用基于向量的元素绘图，例如线条，圆形，方形等，而不是使用像素作图(PNG)。默认条件下输出，可使用命令行参数抑制

`circos -nosvg …`

### QUICK START

####Karyotype

karyotype文件是必须的，该文件定义了染色体的名称，大小和颜色，同时又不仅限与染色体信息，还可以提供序列conigs，genes，indexed positions，blocks of time，任何整数构成的坐标系统。circos软件内含多个常见序列装配信息：人类，大鼠，小鼠，果蝇，这些文件位于data/karyotype中。

**简单绘制染色体图，需提供karyotype文件，图像的最大像素为1500，如果radius=0.8，就意味着0.8*1500=1200像素**，染色体之间距离通过spacing来设置：

![image-20190627181652400](http://ww4.sinaimg.cn/large/006tNc79gy1g4fvs0be40j30uu0c6dgy.jpg)

还需以下三个为绘图标准且必须配置内容

![image-20190627181743333](http://ww2.sinaimg.cn/large/006tNc79gy1g4fvsvzleuj30xs0a4wga.jpg)

以上绘制简单框架图像，不含任何文字信息

#### Ticks & Labels

**向ideogram模块添加标签参数，刻度标签信息定义在ticks内**。另外，在定义ideogram位置时，参考信息为image半径，当定义track 位置时，参考位置为ideogram半径。

`karyotype=data/karyotype.txt` 	#定义ideogram文件

 `chromosomes_units=1000000` 		#定义染色体单位bp大小，以后使用单位为u

label信息位于\<ideogram>内，label_parallel表示label方向，yes，和染色体方向平行；no，和染色体方向垂直

![image-20190627192350878](http://ww3.sinaimg.cn/large/006tNc79ly1g4fxppb3voj30su06saay.jpg)

ticks信息位于\<ticks>内

![image-20190627192511946](http://ww4.sinaimg.cn/large/006tNc79ly1g4fxr3sqb2j30vc06874t.jpg)

#### Ideogram Selection, Scale, Color & Orientation

默认情况下显示所有染色体，通过参数chromosomes_display_default=no来选择部分染色体显示

`chromosomes=hs1;hs2;hs3;hs4`

`chromosomes=/hs[1-4]$/` 	#正则表达

`chromosomes=/hs[1-4]$/;hs10;hs11`

`chromosomes=/hs[1-4]$/;-hs3`		#排除hs3

`chromosomes=hs1:(-100,120-);hs2;hs3;hs4`		#匹配染色体对应区间

使用绝对或相对放大来修改ideogram尺寸

![image-20190627194543025](http://ww3.sinaimg.cn/large/006tNc79ly1g4fycg6y6bj31de0a6dhq.jpg)

自定义染色体颜色

`chromosomes_color=hs1=red;hs2=orange;hs3=green;hs4=blue`

或使用*后缀覆盖默认定义值(colors_fonts_patterns.conf)

![image-20190627200132217](http://ww3.sinaimg.cn/large/006tNc79ly1g4fysxutg3j30ua05kmxk.jpg)

#### Links & Rules

links通过曲线或直线代表了两染色体位置之前的相关性(相似性，差异性，融合等)，使用link模块添加修改。

![image-20190627200458647](http://ww4.sinaimg.cn/large/006tNc79ly1g4fywhtvivj30ww094gmi.jpg)

segdup.txt文件格式

![image-20190627200817992](http://ww2.sinaimg.cn/large/006tNc79ly1g4fyzy84f0j30qw054mxw.jpg)

可在任何模块内添加rule模块，用于改变当前数据(links, histogram bins, scatter plot glyphs等)。每个rule都含有一个状态，格式声明和可选的flow声明。依次评估rules内的rule，如果当前rule正确，则执行，不再检测接下来的rules(除非 flow=continue)，假如当前rule条件错误，则接着查看下一个rule。

![image-20190627201546561](http://ww3.sinaimg.cn/large/006tNc79ly1g4fz7qd533j314o05g0tf.jpg)

如果起点或终点在hs1，则改变link的起点和终点的半径

![image-20190627201739242](http://ww4.sinaimg.cn/large/006tNc79ly1g4fz9onn6gj317s0b4dhv.jpg)

默认条件下当前rule为假才继续执行

`flow=continue if false`

修改，强制继续执行或强制停止

`flow=continue{if true|false}`

`flow=stop{if true|false}`

#### Histograms

除了link图外，可使用line plots，scatter plots，histograms和heatmaps来描述位置关系

line，scatter，heatmap，histogram图数据格式一样

![image-20190627202526820](http://ww2.sinaimg.cn/large/006tNc79ly1g4fzhsau9kj30r806uq3p.jpg)

可选参数可为该数据点的一个相关参数，可以时颜色或名称

![image-20190627202651842](http://ww3.sinaimg.cn/large/006tNc79ly1g4fzj9nqfnj30si01wwej.jpg)

使用参数，例如id可以连接rule用于选择修饰数据点

![image-20190627202924897](http://ww2.sinaimg.cn/large/006tNc79ly1g4fzlx8bdfj30tc06et9y.jpg)

每一个histogram都应定义在\<plot>模块中，使用histogram时，需要定义type和file参数，还有内半径r0，外半径r1，相对值为r(radius)绝对值为p(pixels)。

![image-20190627203252339](http://ww3.sinaimg.cn/large/006tNc79ly1g4fzpie8jgj30qu03qjrp.jpg)

同时histogram拥有fill和ouine参数，默认参数位于etc/tracks/*.conf，同时可以选择orientation=in|out

![image-20190627203713144](http://ww2.sinaimg.cn/large/006tNc79ly1g4fzu1acc0j30vm05874s.jpg)

#### Axes & Backgrounds

背景可使用backgrouds模块直接和axes模块渐变配色，同时都得在plot模块内

Axes类似ticks，按照组来定义，每组可指定相对或绝对的空间，axes对应参数

![image-20190627212658513](http://ww4.sinaimg.cn/large/006tNc79ly1g4g19uunp0j30vq07qmys.jpg)

axes就是在半径位置上绘制颜色条带

![image-20190627220317403](http://ww3.sinaimg.cn/large/006tNc79ly1g4g2blmvwyj31840nmtb7.jpg)

backgroud单元着色范围在y0至y1半径范围内

![image-20190628133135223](http://ww2.sinaimg.cn/large/006tNc79ly1g4gt5i6zw6j314s0lqtbx.jpg)

highlight数据格式：

![image-20190629141411803](http://ww2.sinaimg.cn/large/006tNc79gy1g4i004b27xj30os04qaai.jpg)

#### Heat Maps

Heatmap用于展示基因的一个位置或区域和一个值的关系。

该图线性线性将一个范围值[min, max]映射到一组颜色中c[n], i=0..N

![image-20190627215416781](http://ww1.sinaimg.cn/large/006tNc79ly1g4g228209cj30rg048weq.jpg)

heatmap参数和histogram参数格式形同![image-20190627215200500](http://ww4.sinaimg.cn/large/006tNc79ly1g4g1zuu8xnj30qi05g0t6.jpg)

如果使用scale_log_base，那么比对就不是线性了

![image-20190627215543901](http://ww1.sinaimg.cn/large/006tNc79ly1g4g23q9131j30mw02cwei.jpg)

假如scale_log_base大于1，那么颜色动态范围将在接近最小值初延伸，否则在接近最大值处延伸。

heatmap的颜色默认定义在etc/colors.conf文件中。本次使用的比对颜色范围由5个水平的染色体颜色透明程度构成，外加一个不透明颜色。

![image-20190627220629206](http://ww2.sinaimg.cn/large/006tNc79ly1g4g2exidqcj30xs02egln.jpg)

#### Text

文本信息描述了一个基因组位置和一个文本之间的关系。和其他tracks一样

![image-20190627220829561](http://ww4.sinaimg.cn/large/006tNc79ly1g4g2h17uctj30so06o3yx.jpg)

但需指定字体和标签大小，同时可使用padding和rpadding来设置文本边界

![image-20190627220934174](http://ww1.sinaimg.cn/large/006tNc79ly1g4g2i4pqlaj30qc03eq34.jpg)

### 2D DATA TRACKS

所有的2D图形都定义在plot模块中，一个plot模块内，一个图。每个plot模块中，定义图形格式，文件，还可以插入包含多重rule的rules模块。

![image-20190628093455407](http://ww1.sinaimg.cn/large/006tNc79ly1g4gmb91rn3j311u0cc75x.jpg)

#### SCATTER PLOTS

每个类型图都有其默认参数设定，位于etc/tracks内。2D图均有相同的格式参数：

![image-20190628094521129](http://ww1.sinaimg.cn/large/006tNc79ly1g4gmm3ywh8j31dw0hudho.jpg)

show：和highlights或links一样，决定是否绘制该图

type：图形类型，scatter，line，histogram或heatmap等

file：含图形数据的文件

min/max：图形轴的范围值，超过该范围将被切除

r0/r1：图形轨迹的内外半径，和lightlights一样可以是绝对值或相对值

glyph：scatter图使用的图形状参数，可以时circle，ractangle或triangle

glyph_size：glyph大小，单位为pixels，像素

color：如果使用，glyph将会为该颜色

stroke_color：如果使用，glyph轮廓将会为该颜色

stroke_thickness：如果使用，glyph的轮廓将使用该thickness，单位pixels

2D文件格式：

![image-20190628095155979](http://ww4.sinaimg.cn/large/006tNc79ly1g4gmsz0901j31680aajsx.jpg)

plot背景，使用backgroud模块添加，可同时添加多个背景模块，使用条纹和分层填充背景，y0/y1分别对应了填充的半径范围。

![image-20190628095742940](http://ww2.sinaimg.cn/large/006tNc79ly1g4gmyyyo6sj314m0bwjt2.jpg)

plot轴，可在plot中使用axes绘制y轴网格线，对应给定spacing的同心圆弧

![image-20190628100456532](http://ww4.sinaimg.cn/large/006tNc79ly1g4gn6gxyb4j30zo06cmxs.jpg)

#### LINE PLOTS

线图不同于散点图在于，每个点没有图形，而是通过线将其连接。线图格式和散点图类似，有以下区别：

type：type=line

stroke_thickness：对应为thickness

stroke_color：对应为color

max_gap：临近点距离大于max_gap，经不会使用线连接，避免绘制线图跨越大的gaps

同时，落在min/max范围以外的数据点将会绘制在min/max的边缘；若想去除某些带数据点，使用rule模块，设置额show=no，例如超过min/max 0/0.5的点：

![image-20190628102638346](http://ww3.sinaimg.cn/large/006tNc79ly1g4gnt2g8c7j30vu056wf3.jpg)

#### Histograms

展示线图上的点，临近点直线连接。创建histogram，设置type=histogram。在线图和散点图中，数据点位于区间跨度的中点：

`hs1	1000	2000	0.5`，绘制点位于1500的位置；而对于histogram，整个范围1000-2000(bin)的值都为0.5。

若设置extend_bin=yes，那么该bin的左右将会延伸至相邻bin的中间位置，该设置为默认设置(extend_bin=yes)，设置extend_bin=no将不会延伸bins。

假如数据密度很大，那么histogram将会变得很密集难以区分，建议使用线图。

使用rule模块来跳过明确的数据点。例如，在每1Mb区间绘制histogram

![image-20190628142748835](http://ww3.sinaimg.cn/large/006tNc79ly1g4gurzgiojj30sw040t8z.jpg)

使用skip_run=yes来避免读取所有数据，设置改参数，circos将仅读取相同数值的连续数据点的第一个点：

![image-20190628143338951](http://ww4.sinaimg.cn/large/006tNc79ly1g4guy256hzj315m0akwfy.jpg)

使用min_value_change参数设置第n个值和第n-1个值(被读取绘制)绝对差异需大于min_value_change值。

![image-20190628143649519](http://ww2.sinaimg.cn/large/006tNc79ly1g4gv1dc2hij314u0bcgnh.jpg)

若没有使用min/max设置axis范围，那么axis将会跨越整个数据区域。同时可明确设置axis范围：min=-1，max=0，那么超过该范围的值将被隐藏。例如，使用rule隐藏value小于0的数据范围：

![image-20190628144738327](http://ww4.sinaimg.cn/large/006tNc79ly1g4gvcm3djij313m05o0t9.jpg)

axis方向默认为y-axis方向朝外，也就是较小的值比较大的值更靠近圆心。针对histogram，阳性bins值朝外，阴性bins值朝内。可设置y-axis方向：

`orientation=in`，将使得y-axis方向朝内，较大值更接近中心。

使用fill_color=red，对histogram进行颜色填充

合并两个histograms，一个正值一个负值，不同的背景颜色，效果更好。

#### Tiles

Tiles用于展示基因组区间(genes, exons, duplications)的跨度或覆盖度单元(clones, sequences, reads)。Tiles避免重叠会采用堆积的方式。

![image-20190628152932328](http://ww3.sinaimg.cn/large/006tNc79ly1g4gwk7oe3kj30vm07wgm7.jpg)

图形定义半径范围[0.86r, 0.98r]，该值为相对于inner ideogram半径；r0/r1值分别对应tiles堆积的范围；

orientiation=out，tiles将从ro到r1堆积，反之从r1到r0；如果orientation=center，tiles将从ro/r1的中点向两边堆积；

![image-20190628154044596](http://ww2.sinaimg.cn/large/006tNc79ly1g4gwvvm5cuj30vu06maad.jpg)

图中每个tile单元半径宽度为15pixels，相邻单元具有8pixels的padding；

不同layers之间的空间为padding

![image-20190628170818676](http://ww2.sinaimg.cn/large/006tNc79ly1g4gzezofkgj30yw0bgaaq.jpg)

假如tiles超过了layers数目(layers=15)，layers_overflow参数将决定如何处理overflow的tiles：

layers_overflow=hide，那么overflow(容纳不下的tiles)将会隐藏

layers_overflow=collapse，overflow的tiles会绘制于第一层

layers_overflow=grow，有重叠，增加新层，不考虑层数限制

同时也可以采用rules模块

![image-20190628171329539](http://ww2.sinaimg.cn/large/006tNc79ly1g4gzkdmniwj30zi0cydh6.jpg)

#### Heat Maps

热图用于高亮 2D图形，在热图中，根据基因区域的值显示对应的颜色。不同于其他图形，heatmap需要一个颜色列表。该颜色列表明可明确定义在参数中，或使用提前定义在colors模块中的颜色信息。

![image-20190628172902664](http://ww4.sinaimg.cn/large/006tNc79ly1g4h00k7ydoj30vc06ydgj.jpg)

由于lines plots，histograms和heatmaps都使用相同的数据格式，因此只需改变type值便可改变图像类型。

如果min和max值未定义，那么数据点点颜色会根据值进行分配：

![image-20190628173110575](http://ww2.sinaimg.cn/large/006tNc79ly1g4h02s27k7j30vu01umx8.jpg)

如果定义了一个或全部min/max值，那么将会在以上公式中使用。

Heatmaps使用提前定义的颜色列表，可以使用具体的颜色列表名称来指定颜色使用：spectral-11-div包含11-color spectral diverging brewer palette

`color=spectral-11-div`

同样可以合并颜色列表扩大颜色范围：

`color=ylorrd-9-seq-rev, ylgnbu-9-seq`

`color=black,ylorrd-9-seq-rev,white,ylgnbu-9-seq,grey`

默认条件下，color_mapping=0：

![image-20190628174303855](http://ww4.sinaimg.cn/large/006tNc79ly1g4h0f5yn7zj31fy0m844s.jpg)

#### Text Labels

文本标签用于描述一个基因的跨度信息，同散点图一样，text也会出现在区域的中间。数据格式如下：

![image-20190628174704365](http://ww2.sinaimg.cn/large/006tNc79ly1g4h0jbp3hgj30t405i3z8.jpg)

基本的文本标签参数如下，**需放置在多重plots中**：

![image-20190628174757321](http://ww3.sinaimg.cn/large/006tNc79ly1g4h0k8zdsyj311o0jk40h.jpg)

文本标签默认值位于etc/tracks/text.conf中，取消默认值可采用：

`color=undef`

或取消所有默认值，undefind track_defaults

![image-20190628175023719](http://ww3.sinaimg.cn/large/006tNc79ly1g4h0mrpoefj30pu02gmxb.jpg)

标签内容限制在r0/r1范围内，如果使用很窄范围定义很大的标签，该标签信息不会显示:

![image-20190628175242733](http://ww1.sinaimg.cn/large/006tNc79ly1g4h0p6scr9j30tg036t8s.jpg)

最简单设置为，扩大r1值：

![image-20190628175935696](http://ww2.sinaimg.cn/large/006tNc79ly1g4h0wcaix5j30qo03cjri.jpg)

由于重叠的标签在图中通过偏移避免(开启snuggling参数)，link _dims参数指定了连接标签和基因组位置的连线的dimensions，该连线尤为重要，每个连线拥有5个dimensions信息: outer padding, outer line length(drawn at new position), connecting line length(connects old to new position), inner line length(drawn at old position), inner padding：

![image-20190628184129014](http://ww3.sinaimg.cn/large/006tNc79ly1g4h23xopc8j30q20j8427.jpg)

默认条件下，标签朝外，连线指向圆，同时标签内容靠左排列

选择label_rotate=no(默认条件下，标签将会旋转适应其基线方向)，如果标签很短，可选择label_rotate=no，取消旋转。

![image-20190628183035711](http://ww2.sinaimg.cn/large/006tNc79ly1g4h1sm3a9fj30ua08qgmb.jpg)

通过设置标签半径r0=r1，标签将会绘制在刻度上。

![image-20190628184158144](http://ww3.sinaimg.cn/large/006tNc79ly1g4h24g1ir3j31e20ngwjr.jpg)

### Text Stacking

默认条件下标签会通过stack避免重叠出现，也就是出现重叠时会通过平移避免重叠(label_snuggle=yes)，可通过增加max_snuggle_distance使得标签的分布更加紧凑，当采用snuggling时，可调整padding值有助于snuggling。angular(via padding)和radial(via rpadding)的方向都是围绕标签，可以是绝对值或相对值，用于控制文字边缘大小。

![image-20190629094633862](http://ww4.sinaimg.cn/large/006tNc79gy1g4hs9otdanj311a0fqjte.jpg)

Max_snuggle_distance决定了并排放置标签数目

![image-20190629095017533](http://ww2.sinaimg.cn/large/006tNc79gy1g4hsdkajsuj31760c6tcb.jpg)

若设置padding为负值，那么标签将更紧密显示。radial padding为相对于标签的宽度，angular padding为相对于标签高度。

![image-20190628185244209](http://ww3.sinaimg.cn/large/006tNc79ly1g4h9s89vrwj30pa056jrd.jpg)

若不想使用snuggling，text将一致排列放置。若将text在一个定义的区域(sequence)内不采用snuggling处理，可以关闭(默认就是关闭)，使用monospaced font(等宽字体)：

`label_font=mono`

所有字体都定义在etc/fonts.conf内

![image-20190629095625476](http://ww2.sinaimg.cn/large/006tNc79gy1g4hsjx9xruj311808gdhj.jpg)

#### GLYPHS-PART I

rules可用于通过value参数调整标签文本，例如所有标签均显示为X：

![image-20190629101611511](http://ww2.sinaimg.cn/large/006tNc79gy1g4ht4gzezlj30rc03wglt.jpg)

同时可以合并多个rule，例如可根据文本字符改变现实颜色，同时该rule必须有flow=continue来允许接下来的其他rule作用，否则会完成当前后会终止：

![image-20190629101800812](http://ww3.sinaimg.cn/large/006tNc79gy1g4ht6evtz2j316m0k6tb5.jpg)

同时可以通过修改font，调整文本标签为想要的glyph(图形符号)。例如，使用符符号字符(etc/fonts.conf, glyph, fonts/symbols/symbols.ttf)获得圆形符号:

![image-20190629102552365](http://ww4.sinaimg.cn/large/006tNc79gy1g4htek0my0j30z809g3z6.jpg)

符号字体定义如下：

![image-20190629102817078](http://ww1.sinaimg.cn/large/006tNc79gy1g4hth2d5d2j30xs0aagml.jpg)

#### GLYPHS-PART II

在绘制图形轨迹时常需要将文本标签修改为符号标签

![image-20190629104738018](http://ww4.sinaimg.cn/large/006tNc79gy1g4hu175881j316i0kgq51.jpg)

或通过rule隐藏其他基因类型：

![image-20190629104847565](http://ww4.sinaimg.cn/large/006tNc79gy1g4hu2emh7uj30ts04e3z0.jpg)

通过glyph的大小来表示数据点的density，由于circos不回计算density，需提前处理数据将density现实为label_size：

![image-20190629105453554](http://ww3.sinaimg.cn/large/006tNc79gy1g4hu8r83n2j30yi08875d.jpg)

使用rule模块，将label_size重新映射到其他值，这里原始label_size范围为1p到42p：

![image-20190629105628974](http://ww3.sinaimg.cn/large/006tNc79gy1g4huaepjovj311o070q48.jpg)

#### Connectors

connectors为ideogram上两半径位置的相关区域的连线

![image-20190629110302440](http://ww1.sinaimg.cn/large/006tNc79gy1g4huh7zxn4j30z60bgq40.jpg)

数据文件定义了用于连线的r0和r1位置

![image-20190629110710170](http://ww3.sinaimg.cn/large/006tNc79gy1g4hulj1f9uj30wc04qmxh.jpg)

其中connector_dims信息如下：

![image-20190629110622050](http://ww4.sinaimg.cn/large/006tNc79gy1g4hukp5h8aj31jg0tkdko.jpg)

r0和r1位置描述如下：

![image-20190629110654052](http://ww4.sinaimg.cn/large/006tNc79gy1g4hul8w7y2j31fp0u018z.jpg)

***

定义标准及必须参数

![image-20190630164709764](http://ww3.sinaimg.cn/large/006tNc79gy1g4ja1uyk4cj30ns0bcdhe.jpg)

定义ideogram

![image-20190630164811225](http://ww3.sinaimg.cn/large/006tNc79gy1g4ja2njstdj30wu0e4n0s.jpg)

添加tick配置

![image-20190630165038141](http://ww2.sinaimg.cn/large/006tNc79gy1g4ja57ap2dj31200tctg7.jpg)

绘制gc skew线

![image-20190630165118058](http://ww1.sinaimg.cn/large/006tNc79gy1g4ja5wnxd0j30vg0icdjh.jpg)

显示文本内容

![image-20190630165218167](http://ww2.sinaimg.cn/large/006tNc79gy1g4ja6xm26pj30uk0gsn1a.jpg)

对应文件显示轴线

![image-20190630165010343](http://ww1.sinaimg.cn/large/006tNc79gy1g4ja4q0yqtj312i0hmdk1.jpg)















