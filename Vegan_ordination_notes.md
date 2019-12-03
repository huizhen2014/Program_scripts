#### [Ordination(statistics)][http://cncc.bingj.com/cache.aspx?q=community+oridation&d=4714650086346908&mkt=zh-CN&setlang=en-US&w=BKpfiSHyj81f-fYQoW9kS7NtFVZu9fes]

Ordination or gradient analysis, 为多变量(multivariate)分析，是数据clustering的互补方式，主要用于解释数据分析(不是假设检验)。Ordination对数据进行排序，根据单个变量或多个变量对数据排序，因此相似性对象接近，差异性对象距离远。这种对象之间的关系，在多个坐标轴(on each of several axes, one for each variable)，然后使用数字或者图像进行描述。现存多个ordination方法，包括主成分析(principal component analysis, PCA)，non-metric multidimensional scaling(NMDS)，correspondence analysis(CA)以及其衍生方式(detrended CA, DCA; canonical CA, CCA)，Bray-Curits ordination 和 redundency analysis(RDA)...

Unconstrained ordination uses as examples detrended correspondence analysis and non-metric multidimensional scaling, and shows how to interpret their results by fitting environmental vectors and factors or smooth environmental surfaces to the graph.

##### Detrended correspondence analysis(DCA)

DCA主要为多重变量统计分析，用于发现含丰富物种，但呈稀疏数据矩阵的生态环境数据，中主要因子或着梯度。DCA在用于梯度数据时，常用于抑制假阳性分析结果(inherent in most other multivariate analysis)。

`library(vegan)`

`data(dune)`

`ord <- decorana(dune)`

分类(ordination)结果保存在ord中

























