model.matrix() 和 formula()简述

Linear combinations：线性组合简而言之就是假设y=f(x1)+f(x2)，那么y就是x1和x2的线性组合。假如两个变量包含一样的相同信心，那么model matrix将会产生一致的列

假设以老鼠饮食对应老鼠体重为例子, 模型公式为：

![image-20190509201226797](https://tva1.sinaimg.cn/large/006tNc79gy1g2vbr65ledj30js02qt8r.jpg)

这里的Y对应老鼠体重，x对应老师接受的饮食变量，通过n个不同的饮食变量实验，可得以上线性回归方程。然后使用矩阵乘法来表示以上公式：

![image-20190509201422585](https://tva1.sinaimg.cn/large/006tNc79gy1g2vbt6g5m2j30zm0k4dhv.jpg)

这里的**X**就是我们design matrix。

design matrix的选择对于线性回归模型非常重要，因为它将指定哪些系数将会用来构成最终的回归模型，以下例子来自DESeq2。

DESeq2说明中matrix所包含变量：

![image-20190509213941389](https://tva1.sinaimg.cn/large/006tNc79gy1g2ve9y48ywj30to0gemzy.jpg)

- 单个变量的design matrix为：

![image-20190509211641797](https://tva1.sinaimg.cn/large/006tNc79gy1g2vdm0i3xlj30hc0bmdgu.jpg)

这里我们使用线性模型来比较不同的condition，那么根据字母排列顺序(这里认为设定了)，untreated将会成为ref level。在design matrix中第一列的Intercept为1，第二列指定了哪些样本将会出现在第treated condition中。这样就有两个系数出现在线性模型中：the intercept表示untreated condition(first level, ref level)的均值；第二个系数，代表了treated condition和untreated condition的均值之间的差异。第二个系数就是我们感兴趣的，将会执行统计检测的稀释；通过统计检测，我们将知道2个condition间是否存在差异。

以上对应的回归模型公式为：

Y = $\beta$<sub>0</sub> +   $\beta$<sub>1</sub>(treated) +$\epsilon$ 

colnames(model.matrix(..)): Intercept, conditiontreated

**对应理解，Intercept表示ref状态均值；conditiontreated，表示conditiontreated时的coefficient，对应ref为conditionuntreated，可得二者比较，conditiontreated/conditionuntreated**

`resultsNames(dds): "Intercept", "condition_treated_vs_untreated"`

- 当出现2个变量(~ condition + type)时，condition的ref为untreated，type的ref为paired-end，回归模型公式为：

![image-20190509204307685](https://tva1.sinaimg.cn/large/006tNc79gy1g2vcn4p7bqj30pe04mt8v.jpg)

此时的design matrix为：

![image-20190509211835748](https://tva1.sinaimg.cn/large/006tNc79gy1g2vdo06zuvj30nq0ei3zy.jpg)

这样回归模型公式：

Y =  $\beta$<sub>0</sub> + $\beta$<sub>1</sub> * X<sub>1</sub>(treated) + $\beta$<sub>2</sub> * X<sub>2</sub> (single-end) + $\epsilon$

colnames(model.matrix(…)): Intercept, conditiontreated, typesingle-read

**对应理解，Intercept为ref状态均值(untreated, paired-end)；conditiontreated，表示为不考虑type情况下，conditiontreated的coefficient，可得比较conditiontreated/conditionuntreated；typesingle-read，表示为可涉及condition时，typesingle-read的coefficient，可得比较typesingle-read/typepaired-end**

`resultsNames(dds): "Intecept", "condition_treated_vs_untreated", "type_single.read_vs_paired.end"`

当出现交互项时，就是当前状态提供了额外限制条件，model.matrix(~condition+type+condition:type, colData(dds))就等同于model.matrix(~condition*type, colData(dds))

![image-20190509214027564](https://tva1.sinaimg.cn/large/006tNc79gy1g2vear6eg6j30ps0l00uw.jpg)

***尚未理解！！！***

1. Y =  $\beta$<sub>0</sub> + $\beta$<sub>1</sub> * X<sub>1</sub>(treated) + $\beta$<sub>2</sub> * X<sub>2</sub> (single-end) + $\beta$<sub>3</sub> * X<sub>3</sub>(treated:single-end) + $\epsilon$ 

**colnames(model.matrix(…))：Intercept， conditiontreated，typesingle-read，conditiontreated:typesingle-read，最后一个就出现了typesingle-read给conditiontreated添加了type限定条件。理解为：conditiontreated:typesingle-read/conditionuntreated**

`resultsNames(dds): "Intercept", "condition_treated_vs_untreated", "type_single.read_vs_paired.end", "conditiontreated.typesingle.read"`

- 连续变量

 I()：In function ‘formula’.  There it is used to inhibit the  interpretation of operators such as ‘"+"’, ‘"-"’, ‘"*"’ and ‘"^"’ as formula operators, so they are used as arithmetical operators.

![image-20190509214418912](https://tva1.sinaimg.cn/large/006tNc79gy1g2veeqwdc8j30vs0m4wgs.jpg)

