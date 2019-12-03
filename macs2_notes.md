#### [MACS2][https://github.com/taoliu/MACS]

Model-based Analysis of ChIP-Seq(MACS), 识别转录因子结合位点. 通过集合序列标签位置和方向提高结合位置的空间分辨率. 可简单用于单个ChIP-Seq数据或通过指控样本增加检出特异性.

![macs2_workflow](https://tva1.sinaimg.cn/large/006tNbRwgy1g9juaibaidj30qf0k4jtw.jpg)

Moreove, as a general peak-caller, MACS can also be applied to any 'DNA enrichment assays' if the question to be asked is simply: where we can find significant reads coverage than the random backgound.

##### Usage

```bash
macs2 [-h] [--version]
    {callpeak,bdgpeakcall,bdgbroadcall,bdgcmp,bdgopt,cmbreps,bdgdiff,filterdup,predictd,pileup,randsample,refinepeak}
```

![ChIP_seq_mechanism](https://tva1.sinaimg.cn/large/006tNbRwgy1g9juc0k927j307l08tdfy.jpg)

ChIP-Seq的分析方法可以鉴定两种类型的富集模式:broad domains和narrow peaks. broad domains, 如组蛋白修饰在整个基因body区域的分布; narrow peak, 如转录因子的结合. narrow peak相对于broad或分散的marks更易被检测到. 也有一些混合的结合图谱, 如Poll包括narrow和broad信号.

regular peak calling:

`macs2 callpeak -t ChIP.bam -c Control.bam -f BAM -g hs -n test -B -q 0.01`

broad peak calling:

`macs2 callpeak -t ChIP.bam -c Control.bam --broad -g hs --broad-cutoff 0.1`

MACS2包含12个功能, 略, 这里仅介绍`callpeak`, 其余`macs2 COMMAND -H`































