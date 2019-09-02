# Clustering

![image-20190805131237005](http://ww1.sinaimg.cn/large/006tNc79ly1g5oq5jyuuwj31ia0q8dr3.jpg)

* 基于vector聚类
* 基于graph聚类

1. random walks

![image-20190805131405963](http://ww2.sinaimg.cn/large/006tNc79ly1g5oq704riqj30ui0by40g.jpg)

针对一个图像，在一个cluster内可能存在很多个连线(联系)，同时不同的cluster之间连线很少；这意味着，从一个node开始出发，在相互连接的node间随机移动，便更容易在一个cluster内移动而不是在不同的cluster之间移动。这就是MCL聚类基础。通过随机移动，能发现倾向于聚集在一起的趋势，该趋势涉及的范围就是一个cluster。使用"Markov Chains"计算图中的随机移动。

![image-20190805131843247](http://ww1.sinaimg.cn/large/006tNc79ly1g5oqbt6bycj30py07o3z4.jpg)

例如，从节点1移动到2,3,4均具有33%的概率，而移动到5,6,7的概率为0；节点2移动到1,3,4,5均有25%的概率，而到6,7概率为0。对此，构建矩阵：

![image-20190805132119535](http://ww4.sinaimg.cn/large/006tNc79ly1g5oqej46f6j31g20ggq5q.jpg)

例：矩阵乘法

![image-20190805132701136](http://ww2.sinaimg.cn/large/006tNc79ly1g5oqkho3t3j30zk0c0jse.jpg)

2. Markov Chain

为一个变量序列,X1,X2,X3...(本例子中为概率矩阵)，这里，针对下一步的概率仅考虑当前状态，过去和未来状态均不考虑。random walk为Markov Chain，只用转移概率矩阵。

增加weighted graphs和self loops，则为Markov Chain Cluster Structure

![image-20190805133246080](http://ww2.sinaimg.cn/large/006tNc79ly1g5oqqh21xuj31jk0rctdw.jpg)

3. [MCL][https://www.zybuluo.com/chanvee/note/17815#算法基础]

![image-20190805133758853](http://ww2.sinaimg.cn/large/006tNc79ly1g5oqvvwbhuj311w0cs41a.jpg)

算法核心：expansion，转移矩阵表示就是在初始状态下，某个节点转移到另一个节点的概率组成的矩阵。比如有1,2,3，3个点的图，不考虑权重，两两之间互相连接，其转移矩阵就为：P=[0 0.5 0.5; 0.5 0 0.5; 0.5 0.5 0]。而expansion这个步骤不断对这个转移矩阵进行自乘直到它不再改变为止，也就是求平稳分布的过程。expansion的作用就是为了能够将图中不同的区域连接起来；inflation，该过程目的就是为了使强连接更强，弱连接更弱，就是让转移矩阵中概率大的更大，小的更小。最直观操作就是幂操作，例如平方操作，然后在对每一列归一化，就达到该目的了。



















