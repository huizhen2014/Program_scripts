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

```
Hash 的大小。最好设置的值大于总的独特的(distinct)k-mer数,这样生成的文件只
有一个。若该值不够大，则会生成多个hash文件，以数字区分文件名。如果基因组大小为G，每
个reads有一个错误，总共有n条reads，则该值可以设置为『(G + k*n)/0.8』。该值识别 
M 和 G
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











