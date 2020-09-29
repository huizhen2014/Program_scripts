1. 参杂无关样本的差异分析

对'ab_cs_11'和'ab_c'两组测序数据做比较，使用DESeq2寻找差异基因，第一次分组时，将一个与本分析无关样本(分组为'ab_hg_1')加入`colData`和`countData`中分析，数据准备过程大同小异，这里仅展示相关步骤

![](https://raw.githubusercontent.com/huizhen2014/Pic/master/007S8ZIlgy1gj0cwkz5ipj30lf075q3b.png)

根据'condition'列设置`design`参数，同时设置比较组('ab_cs_11 vs ab_c')，并获得差异检出结果

![image-20200104142206337](https://tva1.sinaimg.cn/large/006tNbRwgy1gakiclkm3hj30ns0bs76y.jpg)

查看差异结果

![image-20200104143824795](https://tva1.sinaimg.cn/large/006tNbRwgy1gakitk0ehjj30n605kmxw.jpg)

2. 去除无关样本后的分析

调整`colData`和`countData`参数，剔除无关样本('ab_hq_1')，其他分析步骤同上

![image-20200104143029720](https://tva1.sinaimg.cn/large/006tNbRwgy1gakile7k2cj30ms06odg5.jpg)

根据'condition'列设置`design`参数，同时设置比较组('ab_cs_11 vs ab_c')，并获得差异检出结果；查看差异结果

![image-20200104143309225](https://tva1.sinaimg.cn/large/006tNbRwgy1gakio394r3j30mp05gmxw.jpg)

3. 比较两次`summary(res)`结果

   第一次含有无关样本分析时: LFC > 0,196, 5.7%    LFC < 0, 332, 9.7%

   第二次不含无关样本分析时: LFC > 0, 238, 7%	 LFC < 0, 355, 10%

可以发现同在`adjusted p-value < 0.1`时，使用DESeq2对相同两组样本检测了不同数目差异基因，难道比较组以外的样本的存在会影响比较组的差异检出???

这里使用'old_res'/‘old_dds'代表含无关样本比较结果; 'res'/'old_dds'代表不含无关样本比较结果

首先查看两种情况下的`sizeFactor` , 可见无关样本缺失对`normalization`过程带来影响

![image-20200104144228045](https://tva1.sinaimg.cn/large/006tNbRwgy1gakixs5fl3j30ku061mxz.jpg)

其次查看`normalization`后counts分布是否存在差异

![image-20200104145043203](https://tva1.sinaimg.cn/large/006tNbRwgy1gakj6d5n46j30kq02uwfa.jpg)

如图, 未出现显著差异

![image-20200104145114663](https://tva1.sinaimg.cn/large/006tNbRwgy1gakj6wxvzcj30t10ixtab.jpg)

再次比较检查后的'adjusted p-value'和'log2foldchange'

![image-20200104145454380](https://tva1.sinaimg.cn/large/006tNbRwgy1gakjaq7f0yj30sz0ivjt9.jpg)

趋势这么一致为何summary存在差异呢, 再次查看在'adjusted p-value  < 0.05'时的分布情况

![image-20200104150155295](https://tva1.sinaimg.cn/large/006tNbRwgy1gakji0oll4j30na03tq3h.jpg)

接着在满足'log2FoldChange' > 1/ < -1, 同时'pad < 0.05'条件下的差异基因分布

查看‘old_res'独有差异基因

在'log2FoldChange >1'时, 'old_res'中独有的基因在‘res’中情况, 可见'log2FoldChange'都差不多，就是res中对应‘padj’值稍微大于0.05

![image-20200104151111009](https://tva1.sinaimg.cn/large/006tNbRwgy1gakjro936aj30ny0cg41z.jpg)

而在'log2FoldChange < -1'时, 'old_res'独有的基因在‘res’中情况, 可见'padj'均满足<0.05, 只是‘res'中对应基因'log2FoldChange'稍微大于-1

![image-20200104151458103](https://tva1.sinaimg.cn/large/006tNbRwgy1gakjvm0rhnj30nu0chadh.jpg)

查看'res'独有差异基因

在'log2FoldChange >1'时, 'res'中独有的基因在‘res’中情况, 可见存在两种情况, 'log2FoldChange'小于或padj为NA

![image-20200104152416116](https://tva1.sinaimg.cn/large/007S8ZIlgy1gizrml4mi0g30dc0a03yg.gif)

在'log2FoldChange < -1'时, 'res'中独有的基因在‘res’中情况, 可见存在两种情况, 'log2FoldChange'小于或padj为NA(图片太大, 仅展示‘res'中独有基因在'old_res'照中的情况)

![image-20200104152622697](https://tva1.sinaimg.cn/large/006tNbRwgy1gakk7hcu6ej30nn0h6n22.jpg)

因此, 构建'colData'和'countData'的不同影响固定阈值下检出差异基因的不同, 存在有三情况, 前两种是由于我们所选择的硬性阈值导致的, 这个可以理解, 在做'normalization'时, 数据结构的不同将导致数据微小的偏差; 最后一种是由于‘padj‘为‘NA'导致, 查看'padj'为‘NA‘的软件解释:

![image-20200104153327032](https://tva1.sinaimg.cn/large/006tNbRwgy1gakkeu9qf0j31aw0k3q7s.jpg)

![image-20200104154802213](https://tva1.sinaimg.cn/large/006tNbRwgy1gakku0q8v9j311m0fljvh.jpg)

那么, 这里带来的'NA'应该是'ab_hg_1'样本导致的, 且是由于第三种情况, 查看:

![image-20200104154141812](https://tva1.sinaimg.cn/large/006tNbRwgy1gakknfb8l5j30vd0b8ae1.jpg)

又根据软件解释其'independent filtering'是采用'genefilter'包的'filtered_p'函数

对应查看, 缺失存在差异:

![image-20200104155327130](https://tva1.sinaimg.cn/large/006tNbRwgy1gakkzmnpemj30g804x74q.jpg)

根据软件代码(3.8 Independent filtering of results)解释绘图:

![image-20200104155712577](https://tva1.sinaimg.cn/large/006tNbRwgy1gakl3jzttxj30st0iwwg6.jpg)

![image-20200104160153262](https://tva1.sinaimg.cn/large/006tNbRwgy1gakl8expv9j30wi04g0tr.jpg)

根据其解释尝试理解, “Independent filtering by default using the mean of normalized counts as a filter statistic. A threshold on the filter statistic is found which optimizes the number of adjusted p values lower than a significance leve alpha", 这里两次检出的'alpha'均为'0.1'. 

那么个人理解就是, 'ab_hq_1'样本的存在改变了其‘independent filtering‘的阈值所导致的'NA', 可以是由其'ab_hq_1'样本本身, 也可以是其他4个样本所致. 

![image-20200104160903103](https://tva1.sinaimg.cn/large/006tNbRwgy1gaklfv7nd5j30i5040aa9.jpg)

因此, 避免无关样本可以增加检出敏感度.





