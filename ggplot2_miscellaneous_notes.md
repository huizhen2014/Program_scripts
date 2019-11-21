#### [ggrepel][https://cran.r-project.org/web/packages/ggrepel/vignettes/ggrepel.html]

ggrepel提供两geoms供ggplot2使用，用于解决文字标签重叠问题：

**geom_text()直接向数据点添加文字；geom_label()向数据点增加方框围绕的文字注释**

* `geom_text_repel()` 
* `geom_label_repel()`

可避免文字标签互相之间，和数据点之间，以及绘图边界之间的重叠

![image-20191108152813726](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qnxutxsuj30ji0590tx.jpg)

![image-20191107212939993](https://tva1.sinaimg.cn/large/006y8mN6gy1g8psrmc4ssj30yh0isq4f.jpg)

#####隐藏空字符点""：

![image-20191108133524624](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkoflovej30il056753.jpg)

**通过限制car参数内容，标签内容为“”表示不现实名称，NA表示不显示点**

##### 限制标签在固定的区域

**通过xlim和ylim将labels限制到固定的区域内，限制区域通过数据坐标指定，`NA`表示在指定方向不设置最低或最高界限：**

![image-20191108133034228](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkjech9qj30ie0640u4.jpg)

**arrow参数：first指定线条末端为箭头(first,end,both)；type指定箭头是否为closed或open的三角；length指定箭头长度，angle指定箭头的角度大小**

![image-20191108104024827](/Users/carlos/Library/Application Support/typora-user-images/image-20191108104024827.png)

#####将标签排列至图像边框上或下边缘

使用hjust或vjust来整齐调整标签文本

* `hjust=0`，左对齐
* `hjust=0.5`，中心对齐
* `hjust=1`，右对齐

有时标签排列不会完好，可使用`direction=x`来限制标签移动到x轴(左或右)，`direction=y`来限制标签移动至y轴(上或下)。默认为`direction=both`

同样可以使用`xlim()`和`ylim()`来增加绘图区域大小，使标签排列愈发紧凑

![image-20191108133237828](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkljpmktj30ik06at9w.jpg)

**使用ylim来调整标签出现位置，避免标签和点重叠; nudge_x/y对应调节标签的x/y起点位置**

![image-20191108110453636](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qgbttl7yj30k4088400.jpg)

##### align labels on the left or right edge

**设置`direction="y"`将表签延y轴排列, 同时设置`hjust`为0.5，0和1**

![image-20191108132925174](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qki7furvj30ia0ewwgy.jpg)

通过hjust来水平移动标签位置靠左，居中或靠右

![image-20191108114745560](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qhkfiz4kj31h40r2gvp.jpg)

使用`nudge_x`和`hjust`来水平排列标签文本，同时设置`direction="y"`使标签在垂直方形移动

![image-20191108132709945](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkful8xbj30ii0c3abz.jpg)

**通过`nudge_x`和`hjust`将标签靠左或靠右对齐排列**

![image-20191108132621601](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkf0oa7sj31h00qwmyv.jpg)

##### 数学表达式

![image-20191108134333722](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkwwxehnj30ik07qaaz.jpg)

![image-20191108134317913](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qkwmzrf5j31h70qz3zv.jpg)

















