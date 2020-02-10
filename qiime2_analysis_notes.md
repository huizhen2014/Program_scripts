#### [qiime2][https://docs.qiime2.org/2019.7/]

![image-20200121095209407](https://tva1.sinaimg.cn/large/006tNbRwgy1gb3y30b68zj30nl0cit9y.jpg)

##### Demultiplexing

![image-20200121111730080](https://tva1.sinaimg.cn/large/006tNbRwgy1gb40jv6egbj30yf0g7mzs.jpg)

一般仅采用一个拆分选项: `q2-demux`/`q2-cutadapt`









***

#### Moving picture tutorial

####1. Obtaining and importing data

sample metadata: https://data.qiime2.org/2019.7/tutorials/moving-pictures/sample_metadata.tsv

![image-20200209130135399](https://tva1.sinaimg.cn/large/0082zybpgy1gbq2bz96mnj316q07oq52.jpg)

barcode reads:https://data.qiime2.org/2019.7/tutorials/moving-pictures/emp-single-end-sequences/barcodes.fastq.gz

sequences reads:https://data.qiime2.org/2019.7/tutorials/moving-pictures/emp-single-end-sequences/sequences.fastq.gz

将barcodes和sequences文件导入为QIIME2 artifact, 这里为`EMPSingleEndSequences`, 包含未拆分的序列信息和barcode信息

`qiime tools import \
  --type EMPSingleEndSequences \
  --input-path emp-single-end-sequences \
  --output-path emp-single-end-sequences.qza`

####2. Demultiplexing sequences

拆分序列需要知道barcode序列所应对的样本. 该信息包含在sample metadata文件. 

`qiime demux emp-single \
  --i-seqs emp-single-end-sequences.qza \
  --m-barcodes-file sample-metadata.tsv \
  --m-barcodes-column barcode-sequence \
  --o-per-sample-sequences demux.qza \
  --o-error-correction-details demux-details.qza`

可使用命令`qiime metadata tabulate`查看`demux-details.qza`

`qiime metadata tabulate \`

`--m-input-file demux-details.qza \`

`--o-visualization demux-details.visual`

`qiime tools view demux-details.visual.qzv`

![image-20200209135614683](https://tva1.sinaimg.cn/large/0082zybpgy1gbq3wti8ayj31sq0d8tc8.jpg)

拆分完序列后, 生成拆分summary

`qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv`

使用命令查看summary文件

`qiime tools view demux.qzv`

![image-20200209135734280](https://tva1.sinaimg.cn/large/0082zybpgy1gbq3y58uvkj319u0g6402.jpg)

####3. Sequence quality control and feature table construction

QIIME2插件包括多个可行的指控方式, 包括DADA2/Deblur/basic quality-score-based filtering. 这些结果都将为一个`FeatureTable[Frequency]` QIIME2 artifact 文件, 包含数据中每个样本的唯一序列的counts(frequencies), 同时一个`FeatureData[Sequence]` QIIME2 artifact, 包含`FeatureTable`中的feature indentifiers和它们所代表序列的联系.

Option 1: DADA2

DADA2是一个可以检测并矫正Illumina amplicon sequence data的流程.  由插件`q2-dada2`完成, 该质控过程将会额外过滤序列数据中额外的phiX reads, 同时还有chimeric序列. 根据`qiime demux summarize`生成的`demux.qzv`文件, 设置对应的`--p-trim-left m`(删除每个序列前m个碱基)和`--p-trunc-len n`(在位置n截短序列), 这两个参数允许用户删除序列的低质量区域.

![image-20200209173800359](https://tva1.sinaimg.cn/large/0082zybpgy1gbqabl7vmpj31rr0u079n.jpg)

可见序列初始处质量高, 在120位置质量下降厉害

`qiime dada2 denoise-single \
  --i-demultiplexed-seqs demux.qza \
  --p-trim-left 0 \
  --p-trunc-len 120 \
  --o-representative-sequences rep-seqs-dada2.qza \
  --o-table table-dada2.qza \
  --o-denoising-stats stats-dada2.qza`

`qiime metadata tabulate \
  --m-input-file stats-dada2.qza \
  --o-visualization stats-dada2.qzv`

Option 2: Deblur

Deblur使用序列的错误情况来关联具有真正生物序列的错误序列reads, 生成高质量序列变异数据(resulting in high quality sequence variant data). 第一步, 基于指定的质量值完成初始质量过滤过程.

`qiime quality-filter q-score \
 --i-demux demux.qza \
 --o-filtered-sequences demux-filtered.qza \
 --o-filter-stats demux-filter-stats.qza`

**In the Deblur paper, the authors used different quality-filtering parameters than what [they currently recommend after additonal analysis][https://qiita.ucsd.edu/static/doc/html/deblur_quality.html]. The paramters used here are based on those more recent recommendations**

下一步, Deblur采用`qiime deblur Denise-16S`方式, 该方式需要质量过滤阶段的一个参数`--p-trim-length n`. 一般, Deblur开发者推荐设置该值为中值开始下降到非常低的位置. 在该类型meta-analysis, 在比较前所有sequencing runs的read length需要一样长, 从而避免引入study-specific bias. 根据上面分析, 这里传递参数`--p-trim-length 120`:

`qiime deblur denoise-16S \
  --i-demultiplexed-seqs demux-filtered.qza \
  --p-trim-length 120 \
  --o-representative-sequences rep-seqs-deblur.qza \
  --o-table table-deblur.qza \
  --p-sample-stats \
  --o-stats deblur-stats.qza`

可视化查看过滤结果`qiime metadata tabulate`和`qiime deblur visualize-stats`

`qiime metadata tabulate \
  --m-input-file demux-filter-stats.qza \
  --o-visualization demux-filter-stats.qzv
qiime deblur visualize-stats \
  --i-deblur-stats deblur-stats.qza \
  --o-visualization deblur-stats.qzv`

####4. FeatureTable and FeatureData summaries

经过质量过滤后, 若想要继续探索得到的数据. 通过`feature-table summarize`命令获得多少个序列和每个样本, 每个特征(features)相关联, 其分布情况的直方图, 以及相关summary statistics; `feature-table tabulate-seqs`命令提供特征(features)IDs到序列的对应关系, 同时提供用于在NCBI nt数据库blast每个序列的链接.

`qiime feature-table summarize \
  --i-table table-deblur.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file sample-metadata.tsv
qiime feature-table tabulate-seqs \
  --i-data rep-seqs-deblur.qza \
  --o-visualization rep-seqs.qzv`

####5. Generate a tree for phylogenetic diversity analyses

QIIME支持多个系统多样性metrics, 包含Faith's Phylogenetic Diversity 和 weighted 和 unweighted UniFrac. 除了计算每个样本的特征(features)的counts(i.e. `featureTable`中的数据), 这些metrics需要一个rooted系统发育树来关联各个特征(features). 该信息将会保存在`Phylogeny[Rooted]`中. 这里使用`q2-phylogeny`插件中的`align-to-tree-mafft-fasttree`流程来生成系统发育树.

首先, 该流程使用`mafft`程序执行多重序列比对(序列保存于`FeatureData[Sequence]`), 来构建`FeatureData[AlignedSequence]`. 下一步, 该流程masks(or filters)比对序列来去除高变异位置. 这些位置一般认为会给最终的系统发育树增加噪音. 随后, 该流程通过FastTree使用masked的比对生成系统发育树. 由于FastTree程序得到的事unrooted树状结构, 因此最终步骤, midpoint rooting is applied to place the root of the tree at the midpoint of the longest tip-to-tip distance in the unrooted tree.

`qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences rep-seqs-deblur.qza \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza`

####6. Alpha and beta diversity analysis

QIIME2的多样性分析可通过`q2-diversity`插件完成, 该插件支持alpha和beta多样性metrics, 通过相关的统计学检测, 生成交互可视结果. 这里首先使用`core-metrics-phylogenetic`方法, 该方法首先rarefies `FeatureTable[Frequency]`到用户指定的深度, 计算多个alpha和beta diversity metrics, 针对beta diversity metrics使用Emperor生成principle coordinates analysis(PCoA)图. 该metrics默认计算:

* Alpha diversity
  * Shannon's diversity index( a quantitative measure of community richness)
  * Observed OTUs(a qulitative measure of community richness)
  * Faith's Phylogenetic Diversity( a qualitative measure of community richness that incorportates phylogenetic relationships between the features)
  * Evenness (or Pielou's Evenness; a measure of community evenness)

* Beta diversity
  * Jaccard distance(a qulitative mearuse of community dissimilarity)
  * Bray-Curtis distance(a qualitative measure of community dissimilarity)
  * unweighted UniFrac distance ( a qualitative measure of community dissimilarity that incorporates phylogenetic relationship between the features)
  * weighted UniFac distance(a qualitative measure of community dissimilarity that incorporates phylogenetic relationships between the features)

其中一个重要的参数需要提供`--p-sampling-depth`, 该值为平均的抽样深度(i.e. rarefaction). 因为大多数diversity metrics在不同的样本中抽样时对抽样深度敏感, 该步骤会根据提供的参数值随机从每个样本中抽样. **例如, `--p-sampling-depth 500`, 该步骤将使用不放回取样的方式从每个样本中抽取500个count. 若任何样本的count数目小于该值, 将舍弃该样本. 该值的选择很巧妙, 推荐查看上文`table.qzv`中的信息, 尽可能的选择高的值, 同时舍弃尽可能少的样本(根据Interactive Sample Detail tab).**

`qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table-deblur.qza \
  --p-sampling-depth 1103 \
  --m-metadata-file sample-metadata.tsv \
  --output-dir core-metrics-results`

![image-20200210154446620](https://tva1.sinaimg.cn/large/0082zybpgy1gbrco28jwoj313c06iwg2.jpg)

计算完diversity metrics, 我们开始探索sample metadata文件中的样本的微生物组成. 该信息存在于`sample metadata`文件中.

首先, 计算categorical metadata columns 和 alpha diversity data之间的相关性. 然后分析Faith Phylogenetic Diversity( a measure of community richness)和evenness metrics.

`qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv`

`qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization core-metrics-results/evenness-group-significance.qzv`

![image-20200210154502656](https://tva1.sinaimg.cn/large/0082zybpgy1gbrcobqtwij313a04ejs3.jpg)

该数据集中, 因为不存在和alpha diversi相关的连续取样信息列(i.e. Days-since-experiment-start), 因此我们这里不进一步分析.  若对这些分析感兴趣(for this data set, or for others), 可以使用`qiime diversity alpha-correlation`命令实现.

接下来, 通过`beta-group-significance`命令使用PERMANOVA分析categorical metadata内容中的样本组成. 接下来的命令将会检测组内样本之间的距离相比于组间的样本间距离, 是否更加相似(例如来自肠的样本距离, 相比来自舌头, 左手掌, 右手掌的样本距离). 若同时采用了`--p-pairwise`参数, 同时将会进行成对比较, 进而判断哪对组之间存在差异比其他组之间差异大(which specific pairs of groups diff from one another).

`qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file sample-metadata.tsv \
  --m-metadata-column body-site \
  --o-visualization core-metrics-results/unweighted-unifrac-body-site-significance.qzv \
  --p-pairwise`

`qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file sample-metadata.tsv \
  --m-metadata-column subject \
  --o-visualization core-metrics-results/unweighted-unifrac-subject-group-significance.qzv \
  --p-pairwise`

![image-20200210160426531](https://tva1.sinaimg.cn/large/0082zybpgy1gbrd8h6woej317o04ggmj.jpg)

同样, 没有和样本组成相关的连续的采样信息, 无法检测它们之间的关系. 若感兴趣, 可使用`qiime metadata distance-matrix`和`qiime diversity mantel`和`qiime diversity bioenv`命令完成.

最后, ordination是一个用于探索样本信息条件下微生物群落组成的流行方法(ordination is a popular approach for exploring microbial community composition in the context of sample metadata). 这里使用Emperor软件来探究样本信息条件下的principal coordinates plots(PCoA). 之前采用的`core-metrics-phylogenetic`命令已经生成了一些Emperor plots, 这里想传递一些可选参数, `--p-custom-axes`, 对于探索时间系列数据非常有用(which is very useful for exploring time series data). 这里将针对unweighted UniFrac 和 Bray-Curtis生成Emperor plots, 使得最终的到的plot包含坐标, principal coordinate1, principal coordinate2, 和从实验开始的天数. 将使用最后的axis来探索这些样本随着时间的改变.

`qiime emperor plot \
  --i-pcoa core-metrics-results/unweighted_unifrac_pcoa_results.qza \
  --m-metadata-file sample-metadata.tsv \
  --p-custom-axes days-since-experiment-start \
  --o-visualization core-metrics-results/unweighted-unifrac-emperor-days-since-experiment-start.qzv`

`qiime emperor plot \
  --i-pcoa core-metrics-results/bray_curtis_pcoa_results.qza \
  --m-metadata-file sample-metadata.tsv \
  --p-custom-axes days-since-experiment-start \
  --o-visualization core-metrics-results/bray-curtis-emperor-days-since-experiment-start.qzv`

![image-20200210161708170](https://tva1.sinaimg.cn/large/0082zybpgy1gbrdlo5esyj318u056ab3.jpg)

####7. Alpha rarefaction plotiing

使用`qiime diversity alpha-rarefaction` visualizer查看抽样深度带来的alpah diversity情况. visualizer在不同的抽样深度计算一个或多个alpha diversity, 其深度变化为1(optional controlled with `--p-min-depth`)到提供值之间(`--p-max-depth`). 在每个抽样深度步骤, 生成10 个rarefied tables, 并且计算该tables中的所有样本的diversity metrics. 迭代次数(在每个抽样深度下rarefied tables计算次数)可通过`--p-iterations`控制. 绘制每个抽样深度下的每个样本的平均diversity values plots, 若提供`--m-metadata-file`参数, 结果中的样本将会根据该参数信息进行分组.

`qiime diversity alpha-rarefaction \
  --i-table table-deblur.qza \
  --i-phylogeny rooted-tree.qza \
  --p-max-depth 4000 \
  --m-metadata-file sample-metadata.tsv \
  --o-visualization alpha-rarefaction.qzv`

![image-20200210220526577](https://tva1.sinaimg.cn/large/0082zybpgy1gbrno3ghz6j318603et91.jpg)

该可视化结果包含2个图. 上面的图为alpha rarefaction plot, 主要用于判断样本的richness是否被完全测得(fully observed or sequenced). 若在取样深度下, 图中的线条的斜率接近0(appear to 'level out'), 这表明在抽样深度条件下再获得额外的测序数据不会增加观察到的特征(features);    假如该线条的斜率不是接近0, 这可能是因为样本的richness没有完全被当前得到的测序数据展示出来(because too few sequences were collected),  或者表明在数据中存在许多测序错误(which is mistaken for novel diversity).

下图展示了根据metadata信息的样本聚类图(grouping samples by metadata). 该图展示了在特征表(feature table)根据抽样深度进行rarefaction时, 每个group中包含的样本数目. 假如一个给定的抽样深度d大于一个样本s总的频率(i.e. 针对样本s获得的序列数目), 这将不可能在抽样深度d时计算样本s的diversity metric(**因为抽样过程中, 若任何样本的count数目小于该值, 将舍弃该样本**). If many of the samples in a group have lower total frequencies than d, the average diversity presented for that group at d in the top plot will be unreliable because it will have been computed on relatively few samples. When grouping samples by metadata, it is therefore essential to look at the bottom plot to ensure that the data presented in the top plot is reliable.

注意, `--p-max-depth`值应该根据上面`table.qzv`文件中的'Frequency per sample'来选择. 一般而言, 在频率中值附近选择值都将可行; 假如上图线条并没出现接近0斜率, 此时可能想要增加该值(sampling depth), or decrease that value if you seem to be losing many of your samples due to low total frequencies closer to the minimum sampling depth than the maximum sampling depth(抽样深度大于样本counts/frequency/频率, 将舍弃该样本).

![image-20200210225601307](https://tva1.sinaimg.cn/large/0082zybpgy1gbrp4rn1fpj31ni0hkmyn.jpg)

####8. Taxonomic analysis

探索每个样本的分类学组成(taxonomic composition), 同时再一次关联到样本信息(sample metadata).











































