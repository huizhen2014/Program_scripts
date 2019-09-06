##绘制heatmap
##1. 将data.frame转换称matrix
x = as.matrix(mtcars)
##2. 家在reshape2包，对matrix进行融合
x_m <- melt(x)
colnames(x_m) <- c("Cars", "Property", "Value")
##3. 计算行和列的聚类关系并重排行和列顺序
x_row_clust <- hclust(dist(x_m),method="average")
x_row_clust_ord <- x_row_clust$order
x_col_clust <- hclust(dist(t(x_m)),method="average")
x_col_clust_ord <- x_col_clust$order
x_m <- x_m[x_row_clust_ord,x_col_clust_ord]
##4. 调用ggplot2绘制tile图
ggplot(x_m,aes(Cars,Property,fill=as.factor(Value)))+
  scale_color_gradient(low="green",high="red")+
  theme(axis.text.x=element_text(angle=90))+
  guides(fill=FALSE)##取消图例，过大
ggsave("x_m_heatmap.png")

##5. 或者将value值rescale为0到1范围内到连续变量
library(scales)
x_m$Value <- rescale(x_m$Value)
ggplot(x_m,aes(Cars,Property,fill=Value))+
  scale_color_gradient(low="blue",high="red")+
  theme(axis.text.x=element_text(angle=90))

