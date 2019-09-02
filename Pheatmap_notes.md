####Pheatmap简介[^https://blog.csdn.net/sinat_38163598/article/details/72770404]

pheatmap用于绘制聚类热图

* 创建测试数据

`test <- matrix(rnorm(200), 20, 10)`

`test[1:10, seq(1,10,2)] <- test[1:10, seq(1,10,2)] + 3`

`test[11:20, seq(2,10,2)] <- test[11:20, seq(2,10,2)] + 3`

`test[15:20, seq(2,10,2)] <- test[15:20, seq(2,10,2)] + 3`

* 绘图

`pheatmap(test)`

默认对于行和列均进行聚类：cluster_row=F, cluster_col=F分别取消行和列的聚类，还可以通过设置treeheight_row=0, treeheight_col=0不显示dendrogram

默认矩阵未进行标准化：标准化参数scale，可选"none", "row", "column"

默认热图每个小块之间以灰色隔开：不想要border可以设置为NA，或通过border_color设置为其他颜色

默认legend位于右上方：通过设置legeng=F取消显示legend

热图颜色可通过color调整

可设置参数display_numbers=T将数值显示在热图格子中，同时使用number_format设置树脂格式，例如"%.2f"保留两位小数，"%.1e"科学计数法显示保留小数点后一位，number_color设置显示内容颜色

`pheatmap(test,display_number=T,nunber_format="%.2f",number_color="purple")`

![image-20190523165312576](http://ww2.sinaimg.cn/large/006tNc79gy1g3bco9ozoaj31240p4qb4.jpg)

`pheatmap(test, display_number=matrix(ifelse(test > 5, "*", ""),nrow(test)))`

根据判断选择显示内容

![image-20190523165556175](http://ww2.sinaimg.cn/large/006tNc79gy1g3bcr01nabj315e0qqjss.jpg)

参数设置改变每个格子的大小

mian设置热图的标题；fontsize设置字体大小；filename可直接将热图存出，支持格式png, pdf, tiff, bmp, jpeg，并通过width和height设置图片大小

`pheatmap(test, cellwidth=15, cellheight=12, main="Example heatmap", fontsize=8, filename="test.pdf")`

通过设置注释信息，对行或者列分组，行和列名称对应test的行列名称

`annotation_col <- data.frame(CellType=factor(rep(c("CT1","CT2",5)), Time=1:5))`

`rownames(annotation_col) = paste("Test",1:10,sep="")`

`annotation_row <- data.frame(GeneClass=factor(rep(c("Path1","Path2","Path3"),c(10,4,6))))`

`rownames(annotation_row) <- paste("Gene",1:20,sep="")`

`pheatmap(test, annotation_col=annotation_col, annotation_row=annotation_row)`

![image-20190523173725575](http://ww4.sinaimg.cn/large/006tNc79gy1g3bdy6suwsj30uu062wez.jpg)

mac未显示出来，不知为何

![image-20190523173225395](http://ww3.sinaimg.cn/large/006tNc79gy1g3bdsyto16j30we0ritg3.jpg)

设置各个分组的颜色

`ann_colors = list(Time = c("white", "firebrick"), CellType = c(CT1 = "#1B9E77", CT2 = "#D95F02"), GeneClass = c(Path1 = "#7570B3", Path2 = "#E7298A", Path3 = "#66A61E"))`

list表格对应了行和列的分组信息

![image-20190523173540546](http://ww2.sinaimg.cn/large/006tNc79gy1g3bdwd4n9ej30do09cq3g.jpg)

`pheatmap(test, annotation_col = annotation_col, annotation_colors = ann_colors, main = "Title")`

![image-20190523173831131](http://ww2.sinaimg.cn/large/006tNc79gy1g3bdzbf9xbj30wk0qujyi.jpg)

根据特定条件将热图分隔开

cutree_rows, cutree_cols：将行和列的聚类根据等级关系分隔开

`pheatmap(test, cutree_rows=3, cutree_cols=2)`

![image-20190523174329864](http://ww4.sinaimg.cn/large/006tNc79gy1g3be4hqdvpj312u0rajsl.jpg)

