### Microbiome Discovery

#### Alpha Diversity

Alpha diversity: 单个样本/环境存在哪些species, 有多少种species存在

Beta diversity: 样本间species的相似性或差异性

Measure alpha diversity: 

Method 1: Species count, counts how many species there; we often use 97% OTUs to represent specie(使用97%OTU代表物种计算物种数量从而表示多样性).

Simple species count ignores that It doesn't take into account how closely related different species are to each other(忽略了样本中物种间的相似性).

Method 2: Phylogenetic diversity, takes into account the level of evolutionary diversity or melecular diversity within a sample(使用物种进化多样性得到多样性).

Add up the total brance length that occupied of the sample and that gives you measure(累加系统发育树中单个样本的分支长度得到其多样性).

![image-20200301144016216](https://tva1.sinaimg.cn/large/00831rSTgy1gcef73tcnxj30te0hwaau.jpg)

Method 3: Chao1 Estimator

Try to predict how many species actually are in a sample/community given that you have a finit sample of members of the community(尝试得到一个sample/community实际含有多少物种)

![image-20200301144527566](https://tva1.sinaimg.cn/large/00831rSTgy1gcefci6rwzj30vy0fmdgs.jpg)

Rarefaction: Did you go deep enough?

Calculate alpha-diverisyt for a randomly selected subset of sequences in each sample(随机挑选部分序列计算物种多样性, 10% M次/M 得到平均值...; 20%..... 若曲线持续上升, 则证明获得数据量不足以代表实际物种多样性)

![image-20200301145222387](https://tva1.sinaimg.cn/large/00831rSTgy1gcefjnb9wbj30yi0di41y.jpg)

Summary:

Alpha diversity measures diversity $within$ communities

Beta diversity measures diversity $between$ communities

Phylogenetic diversity(PD) is worth trying

Most people use PD, Chao1, Shannon and OTU count, and there is prefect correlation between each other

Rarefaction determines saturation

There is room for experimental validataion(to compare your data to existed deeply sequenced data)

#### Beta diversity

Beta-diversity: measure of overall change

![image-20200301150239518](https://tva1.sinaimg.cn/large/00831rSTgy1gcefudyi5nj30xg0eu3yz.jpg)

Euclidean: the most 'dangerous' distance(just the actual distance in space between two samples, 为空间内两点多实际距离)

![image-20200301150531822](https://tva1.sinaimg.cn/large/00831rSTgy1gcefxbvyjsj30um062wfb.jpg)

PcoA: pricipal corrodinatest analysis

The repository in GitHub: http://metagenome.cs.umn.edu/microbiomecodebrowser/doc/index.html

Chi-square: wroks great for gradients(很适合梯度数据)

![image-20200301152723105](https://tva1.sinaimg.cn/large/00831rSTgy1gcegk44k4bj30xe0f8q41.jpg)

 Bray-Curtis: undershoot, 脱靶; It is a nice ecological distance

![image-20200301153642084](https://tva1.sinaimg.cn/large/00831rSTgy1gcegtt2l6zj30xe0dawfm.jpg)

Comparison: Guerrero Negro

![00831rSTgy1gceh91r7fyj30zk0aa0t5](https://tva1.sinaimg.cn/large/00831rSTgy1gd9uk9nk0fj30zk0aawew.jpg)

Summary:

Beta diversity measures diversity $between$ communities

Most people use Bray Curties or UniFrac

#### UniFrac

Euclidean, Chi-square, Bray-Curtis don't use phylogenetics

Phylogenetic-based alpha diversity: sum of branch lengths covered by a sample(**一个样本中所有分支的长度之和**)

![image-20200301161828180](https://tva1.sinaimg.cn/large/00831rSTgy1gcei19tttjj30wc0g0abg.jpg)

Unifrac: Phylogenetic-based beta diversity Percent of observed branch length unique to one or the either sample according to its **species**(**一个sample/community观察到的唯一的分支长度的比率**; 下图中的two communities:  左图, red/blue samples都拥有一样的物种, each sample/community has bugs in the exact same places in the tree of life; 中图, half of the phylogenetic tree is unique to the red sample or the blue sample; 右图, red sample/community are completely unrelated from all the bugs in the blue sample/community, the whole evolutionary tree is unique to one smaple of the other; 意味着上下各是两个不同的大类(branch), 虽然这里仅看的是最底端的物种(tips, species))

![image-20200301162243962](https://tva1.sinaimg.cn/large/00831rSTgy1gcej31ly6pj30xu0bc3zj.jpg)

Beta diversity using UniFrac: Using unifrac distance between every pair of samples in data set that gives you a distance matrix(分别计算两两之间距离, 获得距离矩阵, 针对该矩阵分析PCoA/Hierachical Cluster...)

![image-20200301165127699](https://tva1.sinaimg.cn/large/00831rSTgy1gceizmgcx9j30ug0f0dgu.jpg)

Wighted Unifrac: take into account relative abundances

Weighted UniFrac weights the branch lengths by the abundances of bugs, emphasizes the dominant bugs; Unweighted UniFrac only uses presence/absence, emphasizes the minor bugs(in general)(**W-UniFrac强调了主要bugs/species, 而UW-UniFrac强调了次级的bugs/species**)

Summary:

Beta diversity measures diversity $between$ communities

UniFrac(phylogenetic beta diversity) is very useful

Most people use UniFrac and Bray Curtis

Chi-square is often best for gradients(but not phylogenetically informed...reaserch project?)

#### Statistical testing part 1

Enterotypes: how did it happen?

The statistical support for clusters was based on simulated data

Microbiome data are extremely hard to simulate accurately

Many reviewers may not recognize this as a problem

Species not normally distributed

Often zero-inflated

Often like a negative binomial

Not like a normal distribution

![image-20200301175847304](https://tva1.sinaimg.cn/large/00831rSTgy1gcekxnkhpfj30uq0cs3yu.jpg)

**Data transform:**

Arcsin-square root transform(相比压缩中间的数值, 延伸大和小的数值). 

![image-20200301180123864](https://tva1.sinaimg.cn/large/00831rSTgy1gcel0db36mj30xq0h675x.jpg)

Square root is better(延伸小的数值, 压缩大的数值; 因为大的数值更倾向于改变(异质性), 同时有助于放大次级的数值)

Square root improves distributions(log transform works too, but does not handle zeros)

![image-20200301181052091](https://tva1.sinaimg.cn/large/00831rSTgy1gcela8e4pxj30u00csq3i.jpg)

Common parametric tests:

t-test(t检验): compare 2 groups

ANOVA(方差检验): compare three or more groups

Correlation: Compare to a continuous variable(e.g. Age)

Linear Regression: Similar to correlation, but you can regress on multiple variables at the same time; and add some comfounding parts

**Note: all of these assume normal distributions!**

#### Statistical testing part2

Linear models are not always appropriate

Generalized linear models(better underlying distributions)

Non-parametric tests(no distribution assumptions)

**Controlling for multiple tests**

* For one test, use alpha = 0.05
* For many tests:
  * For every tests, 5 will appear significant by chance
  * Bonferroni correction is most strict
    * Divide alpha by # tests
    * Controls the probability of having one or more false positive
  * False Discovery Rate(FDR) more lenient, common 
    * Slightly more complex formula
    * Guarantees expected rate of false positive

**Negative binomial distribution**

"number of successes in a sequence of independent and identically distributed bernoulli trials before a specificed(non-random) number of failures(denoted r) occurs" 在获得5次非1前得到一个1, 需要掷骰子几次

例如, 大多数人拥有很少的bug数目, 一些人拥有中等数目bug, 很少的人拥有很多的bug

![image-20200328193401136](https://tva1.sinaimg.cn/large/00831rSTgy1gd9vf2rcklj30r60da424.jpg)

改变参数R(为成功次数), 接近正态分布:

![image-20200328193820528](https://tva1.sinaimg.cn/large/00831rSTgy1gd9vjk905hj30rq0cswi0.jpg)





























































































 