#### RColorBrewer

* RColorBrewer提供了3套配色方法

1. 连续型，sequential，颜色渐变
2. 极端型，divergins，生成深色强调两端，浅色表示中部颜色，可用来标注数据中的离群点
3. 离散型qualitative，生成彼此差异明显的颜色，通常用来标记分类数据

`display.brewer.all(type="seq")`

![image-20190923201918475](https://tva1.sinaimg.cn/large/006y8mN6gy1g79pujnexhj310u0fi0ue.jpg)

`display.brewer.all(type="div")`

![image-20190923202018835](https://tva1.sinaimg.cn/large/006y8mN6gy1g79pvk1zl1j310s0g6t9q.jpg)

` display.brewer.all(type="qual")`

![image-20190923202131027](https://tva1.sinaimg.cn/large/006y8mN6gy1g79pwt1dthj31140fswfg.jpg)

* 用法简单

barplot(rep(1,6),col=brewer.pal(9,"Blues"))# 数字9，表示使用色条中颜色的个数，引号内表示色条对应的名称，bar过多则依次循环使用配色

barplot(rep(1,11),col=brewer.pal(11,"RdGy"))

barplot(rep(1,6),col=brewer.pal(11,"RdGy")[2:7])# 第二到第七个颜色。

#####注意：仅有以上种类颜色，不适合连续变量使用

#### colorRamp/colorRampPalette函数(grDevices package)

colorRamp/colorRampPalette函数支持自定义的创建一系列颜色梯度

![image-20190923204508051](https://tva1.sinaimg.cn/large/006y8mN6gy1g79qldpp7ej313q0nctda.jpg)

`col <- colorRampPalette(c("red","blue"))(10)`10色渐变

To be continued~

![image-20190930110921343](https://tva1.sinaimg.cn/large/006y8mN6gy1g7hdafv7fpj31200ekq5e.jpg)













