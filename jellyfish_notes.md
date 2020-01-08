#### [jellyfish][https://bioinformatics.uconn.edu/genome-size-estimation-tutorial/#]

##### Genome Size Estimation Tutorial

给定长度为L的序列, k-mer长度为k, 总比对k-mer数量为: (L-k)+1:

![image-20191205170026641](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyc3hmapj30i704ydg8.jpg)

针对基因组而言, 该k-mer数量就非常接近于基因组真实长度:

![image-20191205170311944](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyeyhv37j30i508k0t6.jpg)

如果存在10 拷贝序列(14bp), 总k-mer数目为(k=8), 那么k-mer数量就为: 

![image-20191205170520474](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyh6wtzlj30i501u3yf.jpg)

获得真实基因组长度:

![image-20191205170544978](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyhlu54tj30i301uglh.jpg)

因此, 测序过程中获得了C 个拷贝基因组, 也就是覆盖度为C, 因此获得实际基因组大小: N=n/C

##### k-mer Distribution of a Typical Real World Genome

k-mer大小应该足够大实现该k-mer在基因组上唯一比对. 过大的k-mer将会导致计算资源的过度使用.

首先计算k-mer的频率用来判断测序过程中基因组的覆盖度:

![image-20191205171208349](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyo9vwioj30i404h75i.jpg)

x轴v1为指定k-mer在测序数据中出现的次数, y轴v2为给定出现次数下k-mer的总数目

图中第一个峰为reads中的测序错误所致, 忽略.

![image-20191205171404821](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyqa827yj30ij04o0sz.jpg)

假设k-mer为唯一匹配到了基因组, 因此应该在基因组中仅出现一次, 这样次数值反应了基因组的覆盖度. 那么为了计算目的, 使用上图的平均覆盖度14, 曲线下面积将代表总的k-mers数目, 那么基因组评估为:

![image-20191205171643211](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lyt0zi3zj30hy01hmx4.jpg)

***

##### 1. Count k-mer occurrence using Jellyfish 

```bash
jellyfish count -t 8 -C -m 19 -s 5G -o 19mer_out --min-qual-char=? /common/Tutorial/Genome_estimation/sample_read_1.fastq /common/Tutorial/Genome_estimation/sample_read_2.fastq
```

-t / -treads=unit32 运行线程

-C -both-strands 计算双链

-m -mer-len=unit32 k-mer长度

-s -size=unit32 Hash size/memory allocation : 

```linux
例如, 测序错误率为e( illumina reads, e ~ 1%), 评估的基因组大小为G, 覆盖度为c, 那么期待的k-mers数目为G+G*c*e*k
不同于jellyfish 1, 该-s参数仅是个估计量. 加入指定的size太小而无法匹配所有的k-mers, 该hash size将自动增加或部分结果将会输出到硬盘且最终自动合并
```

-o -output=string 输出文件名

--min-quality-char 碱基质量值. 2.2.3版本使用'Phred'值, "?"=30

输出文件为19mer_out, 使用jellyfish histo创建点图:

```bash
jellyfish histo -o 19mer_out.histo 19mer_out
```

根据输出点图绘制曲线图:

```bash
dataframe19 <- read.table("19mer_out.histo") #load the data into dataframe19
plot(dataframe19[1:200,], type="l") #plots the data points 1 through 200 in the dataframe19 using a line
```

去除测序错误带来的偏移:

```bash
plot(dataframe19[2:200,], type="l")
```

![image-20191205172902132](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lz5u9jg6j30h40430sr.jpg)

计算单拷贝k-mer区域和总k-mer数目

```bash
plot(dataframe19[2:100,], type="l") #plot line graph 
points(dataframe19[2:100,]) #plot the data points from 2 through 100
```

![image-20191205173220536](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lz9a82dyj30ig04qq36.jpg)

由上图可知单个拷贝基因组的点图应该位于2到28

假设总的数据点为9325, 那么上图分布中总k-mers数目为:

```bash
sum(as.numeric(dataframe19[2:9325,1]*dataframe19[2:9325,2]))
```

为: 366790981

计算顶点位置和基因组大小

根据上图数据, 可以直观看到其顶点为k-mers在12的位置, 因此该基因组大小为:

```bash
sum(as.numeric(dataframe19[2:9325,1]*dataframe19[2:9325,2]))/12
```

为: 305659151 ~ 305Mb

因此其当拷贝基因组区域大小可计算为(2-28):

```R
sum(as.numeric(dataframe19[2:28,1]*dataframe19[2:28,2]))/12
```

为: 213956126 ~ 213Mb

因此单拷贝基因组区域比上总基因组大小为:

```bash
(sum(as.numeric(dataframe19[2:28,1]*dataframe19[2:28,2]))) / (sum(as.numeric(dataframe19[2:9325,1]*dataframe19[2:9325,2])))
```

为: 0.6999827 ~ 70%

和泊松分布比较峰型

```bash
singleC <- sum(as.numeric(dataframe19[2:28,1]*dataframe19[2:28,2]))/12
poisdtb <- dpois(1:100,12)*singleC
plot(poisdtb, type='l', lty=2, col="green")
lines(dataframe19[1:100,12] * singleC, type = "l", col=3)#, Ity=2)
lines(dataframe19[1:100,],type= "l")
```

![image-20191205175212559](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lztzv4q4j30hp053wes.jpg)

同样迭代使用不同的k-mer长度:

![image-20191205175257935](https://tva1.sinaimg.cn/large/006tNbRwgy1g9lzuqrb4cj30j0086t9j.jpg)

***

### Practice

`jellyfish count -C -m 19 -s 100M -o 19mer_out ICU43_galore_R1_trimmed_1P_val_1.fq ICU43_galore_R2_trimmed_2P_val_2.fq 1>jellyfish_19mer.log 2>&1`

`jellyfish histo -o 19mer_out.histo 19mer_out`

查看数据, 删除测序错误带来的峰:

![image-20191205203813410](https://tva1.sinaimg.cn/large/006tNbRwgy1g9m4mp3g0qj30l4030jrw.jpg)

对应峰图:

![Rplot](https://tva1.sinaimg.cn/large/006tNbRwgy1g9m4ozvzrfj30dt0do0su.jpg)

对应泊松分布:

![image-20191206161939523](https://tva1.sinaimg.cn/large/006tNbRwgy1g9n2ryr732j30ey01dt8t.jpg)

![Jellyfish_k_mers_vs_possion_distribution](https://tva1.sinaimg.cn/large/006tNbRwgy1g9n2tfp8nmj30dt0dojrx.jpg)

##### 2. Counting K-mers in a genome

针对实际的基因组或者组装完成的基因组, k-mer和其反向互补序列是不相等的, 因此使用`-C`是没有意义的. **此外, hash的大小可以直接设置为基因组大小. **

jellyfish提供两种方式计算高频的k-mers(仅包含k-mers数目大于1), 该方法显著减少内存使用. 两种方法都是基于Bloom filters. 第一种为one pass method, 提供部分比例k-mers的大概计数, 第二种方法提供精确计数. 两种方式中, 大部分低比例的k-mers都没有报出.

##### One pass method

使用`--bf-size`选项, 应为数据集中期待的总共的k-mer数目, `--size argument`应为出现至少一次的k-mers的数目:

`jellyfish count -m 25 -s 3G --bf-size 100G -t 16 homo_sapiens.fa`

这里将会适当地使用30x覆盖度的人基因组reads, 计算25-mers数目. The approximate memory usage is 9 bits per k-mer in the Bloom filter.

每个k-mer的计数结果(jellyfish dump/jellyfish query)将比实际少1, 例如, count 2 k-mer将为1

缺点就是一些比例的k-mer不应该报告出来(count为1).

##### Two pass method

首先使用`jellyfish bc`构建reads的Bloom counter, 然后使用`jellyfish count`命令计算

`jellyfish bc -m 25 -s 100G -t 16 -o homo_sapiens.bc homo_sapiens.fa`

`jellyfish count -m 25 -s 3G -t 16 --bc homo_sapiens.bc homo_sapiens.fa`

该方法有点是计算所有correct的k-mers计数, 大部分count 1的k-mer不会报告; 缺点就是需要解析所有reads两次.









