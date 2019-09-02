#### Venn diagrams

用于查看多个数据集的交集

`venn(data, universe=NA, small=0.7, showSetLogicLabel=FALSE,simplify=FALSE, show.plot=TRUE, intersections=TRUE, names,…)`

data, Either a list list containing vectors of names or indices of group intersections, or a data frame containing boolean indicators of group intersectionship

`venn(list(A=1:5, B=4:6, C=c(4, 8:10)))`

![image-20190526210657787](http://ww3.sinaimg.cn/large/006tNc79gy1g3f0v4r32aj30v20o6acd.jpg)

`v.table <- venn(list(A=1:5, B=4:6, C=c(4, 8:10)))`

v.table显示对应list的交集

`attr(v.table, "intersections")`

![image-20190526212716663](http://ww1.sinaimg.cn/large/006tNc79gy1g3f1g97qmsj30lw0cy74t.jpg)

***

#### Heatmap diagrams

**首先默认条件下，有4部分将展示在图中，左上方为着色key图，右上方为列的系统树图，左下方为行的系统树图，右下方为热图。该分布可由"lmat", "lwid", "lhei"，重新指定："lmat", 控制每个部分的相对位置；"lwid", 控制列的宽度组合；"lhei", 控制行的高度组合。**

输入data为matrix

data(mtacrs)`

`x <- as.matrix(mtcars)`

定义颜色

col=redgreen; col=greenred; col=bluered; col=redblue

使用rainbow函数定义

`cc <- rainbow(ncol(x), 0,0.3,0,0.3)`

`rc <- rainbow(nrow(x), 0, 0.4, 0,0.4)`

选择进化树

dengrogram=c("both","row","column","none")，默认表示行和列均绘制进化树

数据标准化

scale=c("none","row","column")，默认无，避免数据差异太大导致分布不明显

key图显示(图形左上角)

key=c(T, F)，默认T，对应显示左上角图例，对应Keysize=1，表示key图大小；对应还有key.title, key.xlab, key.ylab

trace基线图显示，tracecol对应基线颜色，默认cyan

trace=c("both","row","column", "none")，默认为both，显示热图基线图

rowsep, colsep, 对应向量将row和col分类，sepwidth，对应向量描述间距宽度(占行或列%)，sepcolor，对应间距颜色

labRow，labCol，cexCol，cexRow，srtRow，srtCol，adjRow，adjCol，对应内容，colnames(x)，rownames(x)字符大小，旋转角度及与坐标轴距离

xlab， ylab，main对应xy,main轴添加标签内容

cellnote=x，notecex, notecol对应将数值，大小，颜色显示到热图内

`heatmap.2(x,scale="column",col="bluered",dendrogram="row",xlab="xlab",ylab="ylab",main="main",rowsep=c(12,16,23),sepcolor="white",sepwidth=c(0.5,0.1),trace="column", tracecol="green",cexRow=0.6,cexCol=1,colRow="black",colCol=rainbow(ncol(x)),srtRow=45,srtCol=45,cellnote=x,notecex=0.5,notecol="black",key.title="key title",key.xlab="key xlab",key.ylab="key ylab")`

![image-20190527220101976](http://ww3.sinaimg.cn/large/006tNc79gy1g3g81qah8uj30z80u0qdu.jpg)

使用extrafun将key图换成散点图

mar指定了一幅图距离四边的位置, c("bottom", "left", "top", "right")，这里对应为图5；lmat对应了5副图及其位置，默认存在4幅图，1为map，2为column dendrogram，3为row column dendrogram，4 为key map；lhei和lwid分别对应行高组合和列宽组合。

因此可以在myplot函数中修改调整第5副图参数

`lmat <- rbind(c(5,3,4), c(2,1,4))`

`lhei <- c(1.5, 4)`

`lwid <- c(1.5, 4, 0.75)`

`myplot <- function(){`

`oldpar <- par("mar")`

`par(mar = c(5.1, 0.5, 0.5, 4.1))`

`plot(mpg ~ hp, data=x)`

`}`

`heatmap.2(x, lamt=lamt, lhei=lhei, lwid=lwid, extrafun=myplot)`

![image-20190527195643835](http://ww1.sinaimg.cn/large/006tNc79gy1g3g4gcudmfj31jl0u0104.jpg)

