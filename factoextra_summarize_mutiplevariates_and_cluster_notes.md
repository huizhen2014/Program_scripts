####Introduction

1. [Principal Component Analysis (PCA)](http://www.sthda.com/english/wiki/factominer-and-factoextra-principal-component-analysis-visualization-r-software-and-data-mining), which is used to summarize the information contained in a continuous (i.e, quantitative) multivariate data by reducing the dimensionality of the data without loosing important information.
2. [Correspondence Analysis (CA)](http://www.sthda.com/english/wiki/correspondence-analysis-in-r-the-ultimate-guide-for-the-analysis-the-visualization-and-the-interpretation-r-software-and-data-mining), which is an extension of the principal component analysis suited to analyse a large contingency table formed by two *qualitative variables* (or categorical data).
3. [Multiple Correspondence Analysis (MCA)](http://www.sthda.com/english/wiki/multiple-correspondence-analysis-essentials-interpretation-and-application-to-investigate-the-associations-between-categories-of-multiple-qualitative-variables-r-software-and-data-mining), which is an adaptation of CA to a data table containing more than two categorical variables.
4. [Multiple Factor Analysis (MFA)](http://www.sthda.com/english/rpkgs/factoextra/reference/fviz_mfa.html) dedicated to datasets where variables are organized into groups (qualitative and/or quantitative variables).
5. [Hierarchical Multiple Factor Analysis (HMFA)](http://www.sthda.com/english/rpkgs/factoextra/reference/fviz_hmfa.html): An extension of MFA in a situation where the data are organized into a hierarchical structure.
6. [Factor Analysis of Mixed Data (FAMD)](http://www.sthda.com/english/rpkgs/factoextra/reference/fviz_famd.html), a particular case of the MFA, dedicated to analyze a data set containing both quantitative and qualitative variables.

![image-20190528080835448](http://ww1.sinaimg.cn/large/006tNc79gy1g3gplumo2nj30ve0u0tov.jpg)

#### Main functions

* Visulizing dimension reduction analysis outputs

fviz_eig: extract and visualize the eigenvalues/variances of dimensions

fviz_pca: graph of individuals/variables from the output of PCA

fviz_ca: graph of column/row variables from the output of CA

fviz_mca: graph of individuals/variables from the output of MCA

fviz_mfa: graph of individuals/variables from the output of MFA

fviz_famd: graph of individuals/variables from the output of FAMD

fviz_hmfa: graph of individuals/vairables from the output of HMFA

fviz_ellipses: draw condidence ellipses around the categories

fviz_cos2: visualize the quality of representation of the row/column variable from the results to PCA, CA, MCA functions

fviz_contrib: visualize the contribution of row/column elements from the results of PCA, CA, MCA functions

* Extracting data from dimension reduction analysis outputs

get_eigenvalue: extract and visualize the eigenvalues/variance of dimensions

get_pca: extract all the results(coordinates, squared cosine, contributions) for the active individuals/variables from PCA outputs

get_ca: extract all the results(coordinates, squared cosine, contributions) for the active column/row variables from CA outputs

get_mca: extract results from MCA outputs

get_mfa: extract results from MFA outputs

get_famd: extract results from FAMD outputs

get_hmfa: extract results from HMFA outputs

facto_summarize: subset and summarize the output of factor analyses

* Clustering analysis and visualization

dist(fviz_dist, get_dist): enhanced distance matrix computation and visualization

get_clust_tendency: assessing clustering tendency

fviz_nbclust(fviz_gap_stat): determining and visualizing the optimal number of clusters

fviz_dend: enhanced visulization of dendrogram

fviz_cluster: visualize clustering results

fviz_mclust: visualzie model-based clustering results

fviz_silhouette: visualize silhouette information from clustering

hcut: computes hierarchical clustering and cut the tree

hkmeans(hkmeans_tree, print.hkmeasn): hierarchical k-means clustering

eclust: visual enhancement of clustering analysis

![image-20190528083125255](http://ww4.sinaimg.cn/large/006tNc79gy1g3gq9m2uvoj30xu0sy456.jpg)

#### Principal component analysis

`library(factoextra)`

`data(decathlon2)`

`df <- decathlon2[1:23, 1:10]`

`library(FactoMineR)`

`res.pca <- PCA(df, graph=F)`

来自FactoMinR包的PCA函数返回对应PCA各项值

***

`PCA(X, scale.unit=T, ncp=5, graph=T)`

scale.unit：根据单位变量对数据标准化，默认为T

ncp：返回对应数目的维度，默认为5

graph： 展示图形，默认为T

主要输出值

eig，包含所有eigenvalues的矩阵，variance的百分比和累积variance百分比

var，包含所有variables的矩阵，对应的coordinates，correlations，axes，square cosin，contributions

ind，包含所有individuals的矩阵，对应coordinates，square cosine，contributions

***

获得各主成的variables的eigenvalues

`get_eig(res.pca)`

![image-20190528102911437](http://ww4.sinaimg.cn/large/006tNc79gy1g3gtob9krlj30p00a075o.jpg)

绘制各个维度对应variables的eigenvalues的碎石图

`fviz_screeplot(res.pca, addlables=T, ylim=c(0,50))`

![image-20190528103337119](http://ww4.sinaimg.cn/large/006tNc79gy1g3gtsr1palj30zt0u0dix.jpg)

提取variables的PCA结果

`var <- get_pca_var(res.pca)`

![image-20190528103517287](http://ww4.sinaimg.cn/large/006tNc79gy1g3gtuhy8umj30oy06ujs5.jpg)

默认绘制PCA的variables图

`fviz_pca_var(res.pca, col.car="black")`

或者根据对应的variables的值绘制颜色梯度图，例如根据contrib来绘制颜色梯度，对应repel=T参数避免标签文字重叠

`fviz_pca_var(res.pca, col.var="contrib", gradient.cols=c("#00AFBB", "#E7B800", "#FC4E07"), repel=T)`

![image-20190528104221400](http://ww1.sinaimg.cn/large/006tNc79gy1g3gu1v416lj30zr0u0aet.jpg)

各个varaibles对各主成维度(axes)的贡献情况

维度1，PC1各variables贡献分布, choice展示PCA的var或ind，axes指定第几个维度，top指定展示variable数目

`fviz_contrib(res.pca, choice="var", axes=1, top=5)`

![image-20190528105104265](http://ww2.sinaimg.cn/large/006tNc79gy1g3guawpsr2j310p0u0wgw.jpg)

获得PCA各个individuals的结果

`ind <- get_pca_ind(res.pca)`

![image-20190528105329278](http://ww1.sinaimg.cn/large/006tNc79gy1g3gudfgdhuj30nw06e74w.jpg)

展示各个individuals主成分布情况，repel=T避免各个标签文字重叠；col.ind="cos2"，cos2对应各个individuals的cosine平方值，根据其分布绘制颜色梯度

`fviz_pca_ind(res.pca, col.ind="cos2", gredient.cols=c("#00AFBB", "#E7B800", "#FC4E07"), reple=T)`

![image-20190528110241327](http://ww2.sinaimg.cn/large/006tNc79gy1g3gun09tjaj310k0u0jvm.jpg)

使用biplot展示individuals和variables主成图

`fviz_pca_biplot(res.pca, reple=T)`

![image-20190528110734819](http://ww1.sinaimg.cn/large/006tNc79gy1g3gus3bkvdj311i0u0dlf.jpg)

针对分组individuals绘制PCA图

![image-20190528110912990](http://ww1.sinaimg.cn/large/006tNc79gy1g3gutslulnj30nu06mdgl.jpg)

`iris.pca <- PCA(iris[,-5], graph=F)`

绘制PCA图，根据group信息对individuals着色区分

habillage，根据分组对观测值进行着色；palette，设定调色板范围；allEllipses=T，当habillage不为none时，围绕individuals边缘绘制椭圆

`fviz_pca_ind(iris.pca, label="none", habillage=iris$Species, palette=c("#00AFBB", "#E7B800", "#FC4E07"), addEllipses=T)`

![image-20190528112115470](http://ww2.sinaimg.cn/large/006tNc79gy1g3gv6bf3rqj30zc0t0td0.jpg)

`fviz_pca_biplot(iris.pca, label="var",reple=T, habillage=iris$Species, palette=c("#00AFBB", "#E7B800", "#FC4E07"),addEllipses=T)`

![image-20190528112611829](http://ww3.sinaimg.cn/large/006tNc79gy1g3gvbgj7wdj31it0u0wmp.jpg)

***

#### Correspondance analysis

CA是PCA的延伸，用于研究定型变量之间的关系(或者分类变量)，同PCA，提供了在二维图形中展示和绘制数据的方法。例如，分析两分类数据的频率，也就是列联表。针对列联表的行和列提供factor scores(coordinates)，用于图示列联表行和列单元之间的相关性。

当分析two-way 列联表时，典型需要关注的问题为，是否存在一些明确的行单元和一些列单元相关。CA通过几何图形过程在低纬度的空间使用点来描绘two-way列联表的行和列，这样行和列的点的位置对应了表格中他们的相关性。

`library(FactoMineR)`

`data(housetasks)`

![image-20190528114418750](http://ww1.sinaimg.cn/large/006tNc79gy1g3gvubx3jfj30iy06qaao.jpg)

housetasks数据，行对应了不同的家庭任务，列对应家庭任务的执行成员，期间的值表示执行数量。

***

可以使用Chi-square test of independent分析两分类变量的频数表(列联表)，用于评估两分类变量关系的显著性。

使用gplots包中的balloonplot函数图形化展示列联表

转换成表格

`dt <- as.table(as.matrix(housetasks))`

图形展示

`balloonplot(t(dt), main="housetasks", xlab="", ylab="", label=F, show.margins=F)`

![image-20190528121726790](http://ww2.sinaimg.cn/large/006tNc79gy1g3gwyll9tgj30yb0u0go4.jpg)

针对小的列联表，可以直接使用Chi-square test评估行和列分类之间的显著相关性

`chisq <- chisq.test(housetasks)`

![image-20190528122511189](http://ww2.sinaimg.cn/large/006tNc79gy1g3gx0tzu1jj30q005idg5.jpg)

可见行和列变量具有显著相关性(p-value=r chisq$p-value)

***

使用FactoMinR函数CA对行和列的点分析

默认，ncp=5，保留5个dimensions；graph，是否展示图；row.sup和col.sup对应数组向量指定行和列的矩阵

`res.ca <- CA(housetasks, graph=F)`

![image-20190528123003160](http://ww3.sinaimg.cn/large/006tNc79gy1g3gx5wr1zyj312a0fugo7.jpg)

和PCA分析类似，可以通过get_ca_row/col获得行和列变量结果

`row <- get_ca_row(res.ca)`

![image-20190528123348511](http://ww4.sinaimg.cn/large/006tNc79gy1g3gx9t93gwj30rs0e4gnb.jpg)

row和col所包含数据可用于绘制对应图形

row$coord，每个行点在每个维度的坐标，用于绘制scatter plot

row$cos2，行所代表的性能，也就是quality on the factor map，每个dimensions中行的所有的cos2之和为1

**the quality of representation of the rows on the factor map is called the squared cosine(cos2) or the squared correlations**

row$contrib，行对应每个维度的贡献值

绘制行点图

col.row定义颜色，shape.row定义形状

`fviz_ca_row(res.ca, col.row="steelblue", shape.row=15, repel=T)`

![image-20190528124203295](http://ww3.sinaimg.cn/large/006tNc79gy1g3gxiebp3cj311p0u041l.jpg)

**该图描绘了行单元点之间的关系，具有类似特点的行单元点聚集一起；负相关的行单元点位于图像相对的象限；不同点之间的距离和原点对应行quality of the row points on the factor map，远离原点的行单元点更能很好代表factor map**

根据cos2对行单元点绘图：**cos2代表了行/列和对应axis(dimensions)之间的相关程度**

![image-20190528125525352](http://ww1.sinaimg.cn/large/006tNc79gy1g3gxwaptfgj30iu058t9c.jpg)

这里低cos2着白色，中等cos2着蓝色，高cos2着红色

`fviz_ca_row(res.ca, col.row="cos2", gradient.cols=c("#00AFBB", "#E7B800", "#FC4E07"), repel=T)`

![image-20190528130006483](http://ww1.sinaimg.cn/large/006tNc79gy1g3gy16h1ewj31470u0n0i.jpg)

绘制列单元点图

`fviz_ca_col(res.ca, col.col="cos2", gradient.cols=c("#00AFBB", "#E7B800", "#FC4E07"), repel=T)`

![image-20190528131121630](http://ww2.sinaimg.cn/large/006tNc79gy1g3gycvtynbj311g0t4aca.jpg)

使用corrplot包绘制各维度cos2贡献值图

`library(corrplot)`

`corrplot(row$cos2, is.corr=F)`

略

简单绘制biplot图

`fviz_ca_biplot(res.ca, repel=T)`

![image-20190528132148958](http://ww4.sinaimg.cn/large/006tNc79gy1g3gynrrghdj30yt0u0q68.jpg)

***

#### Mutiple correspondence analysis

MCA是CA的扩展，展示超过两个分类变量之间的关系。可以看作为针对类别而不是数量做PCA。

MCA用于识别，同一个解答中具有类似特征的一组变量；分类变量之间的相关性。

数据来自关于小学儿童食物中毒的调查，查询所吃食物和对应的病症

`data(poison)`

**数据第1/2列对应年龄和时间；列3/4对应是否疾病和性别，用于对分组个体着色**

`res.mca <- MCA(poison.active, graph=F)`

![image-20190528134548312](http://ww1.sinaimg.cn/large/006tNc79gy1g3gzcq65ybj30vo0fmmzo.jpg)

通过factoextra函数获得对应值

get_eigenvalue(res.mca)，获得每个dimension的eigenvalues/variances

fviz_eig(res.mca)，绘制eigenvalues/variances图

get_mca_ind(res.mca), get_mca_var(res.mca)，获得individuals和variables值

fviz_mca_ind(res.mca), fviz_mca_var(res.mca)，绘制individuals和variables图

fviz_mca_biplot(res.mca)，绘制行和列的biplot

获得eigenvalues值绘制碎石图

`eig.val <- get_eig(res.mca)`

`fviz_screeplot(res.mca, addlabels=T,ylim=c(0,45))`

![image-20190528135333991](http://ww4.sinaimg.cn/large/006tNc79gy1g3gzmt50dtj312w0tatb0.jpg)

获取MCA的individuals/variables值

`var <- get_mca_var(res.mca)`

`ind <- get_mca_ind(res.mca)`

![image-20190528135745578](http://ww4.sinaimg.cn/large/006tNc79gy1g3gzp5uxbxj30qq0bm75o.jpg)

var$coord，对应categories/individuals的坐标

var$cos2,，对应categories/individuals于对应axis(dimension)的相关程度

var$contrib，对应categories/individuals的贡献程度

展示variables和principal dimensions之间的相关度

`fviz_mca_var(res.mca, choice="mca.cor", repel=T)`

![image-20190528140648094](http://ww2.sinaimg.cn/large/006tNc79gy1g3gzyksconj31240s2wh1.jpg)

上图帮助识别每个维度最相关的variables，variables这dimensions之间的相关性的平方用于构建坐标位置，可见diarrhae，abdominals和fever和dimension 1非常相关。

展示variables分类坐标位置，同时根据cos2( squared cosine, the quality of the representation)着色绘图

`fviz_mca_var(res.mca, choice="var.cat", col.var="cos2", gradient.cols=c("#00AFBB", "#E7B800", "#FC4E07"), repel=T)`

![image-20190528141916480](http://ww2.sinaimg.cn/large/006tNc79gy1g3h0bjtzkij310h0u078i.jpg)

**如图，类似特性的变量分类聚集到一起；负相关的变量分类出现在相对的象限；不同类别点之间的距离和原点对应quality of the variable category on the factor map，远离原点的变量分类更能很好代表factor map**

根据individuals值的分类绘制individuals着色图，分组水平为Vomiting，habillage用于指定不同类别individual的颜色

`fviz_mca_ind(res.mca, label="none", habillage="Vomiting", palette=c("#00AFBB", "#E7B800"), addEllipses=T)`

![image-20190528142746225](http://ww1.sinaimg.cn/large/006tNc79gy1g3h0ke7r47j30zi0u076z.jpg)

或者针对individuals使用多个categories variables绘图

`fviz_ellipses(res.mca, c("Vomiting", "Fever"), geom="point")`

![image-20190528143135259](http://ww3.sinaimg.cn/large/006tNc79gy1g3h0oczl6pj314k0rcq60.jpg)

或者：`fviz_ellipses(res.mca, 1:4, geom="point")`

MCA，指定quantitative(定量)和qualitative(定型) variables

`res.mca <- MCA(posion, quanti.sup=1:2, quali.sup=3:4, graph=F)`

`fviz_mca_biplot(res.mca, repel=TRUE)`

![image-20190528145509704](http://ww1.sinaimg.cn/large/006tNc79gy1g3h1cwc5sfj312d0u00yx.jpg)

如图，individuals蓝色，supplyment individuals深蓝色，variables红色，supplyment variables深红色。

***

***

#### Partitioning clustering

![image-20190528150247270](http://ww1.sinaimg.cn/large/006tNc79gy1g3h1ku0mhgj30s00nu78v.jpg)

kmeans聚类分析

`data(USArrests)`

`df <- scale(USArrests)`

`km.res <- kmeans(scale(USArrest), 4, nstart=25)`

***

首先针对每列进行标准化处理，防止出现差异较大导致无法正常显示；其次kmeans函数计算每列数值的聚类分布，根据参数center=4，将每列分为4类；nstart=25，选择25个随机点开始聚类。

其聚类过程为：首先分别针对所有列进行指定数目的聚类分布，可得，对应4类的中心位置：

![image-20190528151313139](http://ww2.sinaimg.cn/large/006tNc79gy1g3h1vo4kczj30m0054mxr.jpg)

然后计算每一行到这4类中心的距离，距离最短的，及属于该类：

![image-20190528151414725](http://ww4.sinaimg.cn/large/006tNc79gy1g3h1wqj1qbj30nc06qmy9.jpg)

例如 Alabama

![image-20190528152538130](http://ww3.sinaimg.cn/large/006tNc79gy1g3h28lxp87j30ni06uaao.jpg)

***

绘制聚类图

`fviz_cluster(km.res, data=df, palette=c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"), main="Partitioning Clustering Plot")`

![image-20190528152943600](http://ww4.sinaimg.cn/large/006tNc79gy1g3h2cun4wuj312c0tsn53.jpg)

***

***

#### Hierarchical clustering

![image-20190528153357883](http://ww4.sinaimg.cn/large/006tNc79gy1g3h2h9f055j30s40non2l.jpg)

`library(factoextra)`

hcut：计算分级聚类并将系统发育树非常对应类别数目。计算分级聚类函数可选hc_func=hclust(默认), agnes, diana；同时可以根据基于hc_metric=person，spearman，kendall计算的相关性聚类。

`res <- hcut(USArrests, k=4, stand=T)`

k=4指定聚类数目，stand=T，scale 每列数据

`fviz_dend(res, rect=T, cex=0.5, k_colors=c("#00AFBB","#2E9FDF", "#E7B800", "#FC4E07"))`

![image-20190528154717677](http://ww4.sinaimg.cn/large/006tNc79gy1g3h2v4jy9dj312q0tagpr.jpg)

***

***

#### Determine the optimal number of clusters

fviz_nbclust函数用于确定聚类个数

`library(factoextra)`

`my_data <- scale(USArrests)`

`fviz_nbclust(my_data, FUNcluster=kmeans, method="gap_stat")`

FUNcluster，指定采用的聚类方法,Allowed values include: kmeans, cluster::pam, cluster::clara, cluster::fanny, hcut；method，评估最佳聚类个数的方法，Possible values are "silhouette" (for average silhouette width), "wss" (for total within sum of square) and "gap_stat" (for gap statistics)

![image-20190528160615781](http://ww1.sinaimg.cn/large/006tNc79gy1g3h3evekhfj31520ssacm.jpg)

Gap statistic for hierarchical clustering

`data(iris)`

`iris.scaled <- scale(iris[,-5])`

`gat_stat <- clusGap(iris.scaled, FUN=kmeans, nstart=25, k.max=10,B=10)`

nstart=25，指定随机数据集数目；k.max，最大的聚类数目；B，bootstrap样本数目

`fviz_gap_stat(gap_stat)`

![image-20190528161614353](http://ww1.sinaimg.cn/large/006tNc79gy1g3h3p93mdgj313f0u076v.jpg)

`gap_stat <- clusGap(iris.scaled, FUN = hcut, K.max = 10, B = 10)`

` fviz_gap_stat(gap_stat)`

![image-20190528161806486](http://ww2.sinaimg.cn/large/006tNc79gy1g3h3r6t27bj313c0u0q5k.jpg)

