Principal component analysis (PAC)：将一组可能相关的变量的观察值通过直角转换成为一组线性无关的变量的统计处理过程。简而言之，就是将高维度的数据 (多个样本的多个基因的表达)，通过几何投射为低维度数据结构(称为主成)，同时保持数据的模式和趋势，这样就通过使用有限的主成来描述数据之间的关系。PCA主要用于探索性数据分析和构建预测模型, 常用于可视化种群间的遗传距离和关系。

主成分析第一步是寻找数据最小的距离点，该点到每个数据坐标点的距离和最小，然后以该点为坐标原点，移动所有数据的坐标位置，在数据坐标移动过程中并不会改变相互之间的距离。

![PCA_AVERAGE_POINT](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tmklu5xrj313q0isgq8.jpg)

然后过原点画一条直线，使各个点到该直线的距离最短，该直线被称为PC1，同时每个点投射到该直线的距离之和也应该是最大的(根据三角形勾股定理可得)。

![PCA_MINIMIZE_DISTANCE](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tmo7bh13j30xu0l643z.jpg)

根据直角三角形的勾股定理知，例如其中某一点，PC1由4部分的gene1和1部分的gene2所组成。

![PCA_LINEAR_COMBINATION](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tmud4yzgj314e0ma0xr.jpg)

那么根据勾股运算，我们将特征向量标准为1，可得PC1由0.97部分的gene1加上0.242部分的gene2构成，我们将该组成PC1所需要点各基因的比例称为"loading scores"，同时0.97部分的gene1和0.242部分的gene2组成的1单位的向量也被称为"singular vector"或"eigenvector"，特征向量(**我们知道，矩阵乘法对应了一个变换，是把任意一个向量变成另一个方向或长度都大多不同的新向量。在这个变换的过程中，原向量主要发生旋转、伸缩的变化。如果矩阵对某一个向量或某些向量只发生伸缩变换，不对这些向量产生旋转的效果，那么这些向量就称为这个矩阵的特征向量，伸缩的比例就是特征值**)。

![PCA_LOADING_SCORES](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tn37nrpuj314w0mcn4l.jpg)

考虑到坐标轴距离的正负在加的过程中会抵消，我们将所有数据投射点到原点的距离的平方相加可得到PC1的distances，然后对SS(distances for PC1)开方得PC1得eigenvalue。

![PCA_EIGENVALUE_PC1](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tn9hvf72j313y0m2454.jpg)

由于是这里是二维数据，PC2则是一条与PC1垂直的线，接着使用相同的方法可得到PC2的对应信息。

![PCA_LOADING_SCORES_PC2](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnfy072pj312k0luwld.jpg)

![PCA_EIGENVALUE_PC2](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnhx41v8j313q0lun43.jpg)

最后我们根据投射坐标对坐标轴再次旋转，这样坐标轴上的信息即为原始数据在PC1和PC2的坐标信息了，同时也就完成了singular value decomposition(SVD)。

![PCA_PROJECTED_COORDINATION](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnkz5kulj310i0ji787.jpg)



![PCA_SINGULAR_VALUE_DECOMPOSITION](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2to1g3yjqj31160jkq6o.jpg)根据PC1和PC2的eigenvalues值，我们最终可计算出PC1和PC2能够解释的数据变异程度，可通过对应碎石图表示其所占总体变异比例。

![PCA_VARIATION_PC1](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnphn1fpj31460k8wlq.jpg)

![PCA_SCREEPLOT](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnrejrrvj311q0l4tdg.jpg)

针对三维数组(例如3个基因)会复杂些，具体方法同上。

![PCA_3_VARIABLES](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tntvz1kgj313g0jagrf.jpg)

![PCA_3_VARIABLES_LOADING_SCORES](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnxs1e3gj31300lmtfe-20200926225624728.jpg)

![PCA_3_VARIABLES_SCREEPLOT](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g2tnxyfvn8j31300m210e.jpg)

关于PCA的计算和绘图, 可以使用prcomp来计算，然后使用screeplot，biplot以及ggbiplot包来绘制，方法看下help说明即可，很简单。

使用data(wine)数据举例：

![image-20190521111720498](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g38rq35midj30vw0cg75x.jpg)



prcomp(formula, data, subset, scale=FALSE)

formula：选择colnames值，用于主成分析; ~ AN+AT+BN+BT

data: 数据矩阵

subset：选择对应的row信息，用于分析

scale：将数据先进行标准化转换(mean=0,sd=1)

![image-20190521104155553](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g38qpal5taj30uc0a4jt2.jpg)

Standard deviations为主成成分的标准差，也就是eigenvalues的covariantc/correlation的平方根；

Rotation为变量的loadings值对应princomp返回的loadings信息

![image-20190521111740351](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g38rqfzdqxj30ze0go0w8.jpg)

summary展示对应的PC所能解释变异比率

![image-20190521111839567](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g38rrgrm4fj30u008o75w.jpg)

简单绘图:biplot(prcomp(wine,scale=T)); screeplot(prcomp(wine,scale=T))，图形惨不忍睹

ggbiplot包绘制PCA图

wine.pca <- prcomp(wine, scale=T)

ggbiplot(pcobj, scale, obs.scale, var.scale, groups, ellipse, circle)

pcobj：prcomp()或princomp()返回对象

scale：默认scale=1，将variances的covariance和点之间距离进行标准化处理

obs.scale：针对observation标准化

var.scale：针对variables标准化

groups：可选值指定observations所属groups

ellipse：针对不同groups绘制data ellipse

circle：在满足prcomp参数scale=T和var.scale=1时对应会着相关的圆

ggbiplot(wine.pca, obs.scale = 1, var.scale = 1, groups = wine.class, ellipse = TRUE, circle = TRUE)

![image-20190521113354588](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g38s7bl8h3j31240u0dnc.jpg)

点代表样本，颜色代表对样本的分组，也就是wine.class值

椭圆代表分组按照默认68%的置信区间加在核心区域，便于观察组间是否分开

箭头表示原始变量，方向表示原始变量与主成关系相关性，长度表示原始数据对主成分的贡献度

参考：https://blog.csdn.net/woodcorpse/article/details/78863454

