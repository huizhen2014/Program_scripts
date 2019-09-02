#### Integrative and conjugative element(ICE)

Integrative and conjugative element(ICE) 是细菌重要的移动遗传单元，整合到细菌染色体中同时编码完整功能的conjugation machinery，并且可以在细菌细胞之间依靠自身转移。ICEs所携带的cargo基因，编码耐药产物和毒力因子，能够授予宿主选择优势，使得ICEs成为细菌适应和进化的重要驱动因素。

ICEs除了自身可转移，有报道ICEs能够移动其他遗传单元，例如染色体整合移动单元(chromosome-borne integrative and mobilizable elements, IMEs)，顺式移动单元(cis-mobilizable elements, CIMEs)，质粒；IMEs和CIMEs也是重要的耐药基因和毒力因子的载体。不同于ICE，IMEs和CIMEs常缺乏结合装置(conjugal apparatus)，因此得绑定到其他连接单元上(hijack the machinery of other cojugative elements)。

#### [ICEfinder][http://202.120.12.136:7913/ICEfinder/ICEfinder.html]: a web-based tool for the detection of ICEs/IMEs of bacterial genomes

ICEfinder设计用于检测细菌基因组序列中的T4SS-type ICEs, AICEs和IMEs。ICEfinder首先根据profile HMMs检出recombination modules和conjugation modules，然后co-localizes，filters ，groups对应的基因：

ICEs：integrase gene；relaxase gene；T4SS gene clusters

IMEs：integrase gene；relaxase gene；without T4SS 

Particular IMEs：integrase gene；oriT；without relaxase

Putative AICEs：integrase gene；replication； AICE translocation-related proteins；without T4SS

ICEfinder采用ARAGORN软件及默认参数识别tRNA/tmRNA的3‘ 末端，作为putative ICE插入位置，使用Vmatch软件及默认参数检测正向重复(DR)作为tRNA-末端边界。同时使用NCBI blastp及阈值Ha-value 0.64用于检测ICE-编码的获得耐药基因(ARG)和毒力因子(VF)。

最后这些携带integrase gene，relaxase gene和T4SS gene clusters的单元输出为ICEs；而含有integrase和relaxase，不含T4SS的单元输出为IMEs。ICEfinder也尝试检出一些特殊的ICEs，含有integrase和oriT，但是不含relaxase。

#### Illustration

![image-20190624211042108](http://ww1.sinaimg.cn/large/006tNc79gy1g4cjxzf5ssj31460q6jwl.jpg)

![image-20190624211106109](http://ww2.sinaimg.cn/large/006tNc79gy1g4cjyebfvbj313q0kkq5k.jpg)

Figure.1 The prediction strategy used by ICEfinder to identify ICEs/IMEs of bacterial genomes.

