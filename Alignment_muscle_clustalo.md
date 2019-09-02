#### muscle

-in \<inputfile>，输入文件

-out \<outfile>，输出文件

-html，输出HTML格式

* making a multiple sequence alignment(MSA)

多重序列比对

`muscle -in seqs.fa -out seqs.afa`

输出clustalw格式(比fasta格式更容易读)

`muscle -in seqs.fa -clw`

![image-20190622130302776](http://ww2.sinaimg.cn/large/006tNc79gy1g49ulzs4f4j312u086jsk.jpg)

输出GCG MSF格式

`muscle -in seqs.fa -msf`

![image-20190622130412452](http://ww1.sinaimg.cn/large/006tNc79gy1g49un4xxe3j310u0agq4j.jpg)

#### clustalo

使用Clustal Omega程序用于蛋白序列比对

-i, --in, --infile={\<file>, -} 多重序列文件输入

-o, --out, --outfile={file, -}多重序列比对输出

--hmm-in=\<file>，指定输入为HMMs文件

-t，--seqtype= {Protein, RNA, DNA}，指定输入序列类型

--outfmt={a2m=fa, clu[stal], msf, phy[lip], st[ockholm], vie: MSA}，输出我呢就爱你格式，默认为fasta

`clustalo -i seqs.prot.fa --outfmt clu`

![image-20190622132839279](http://ww4.sinaimg.cn/large/006tNc79gy1g49vclpcabj314g08kta8.jpg)

`clustalo -i seqs.prot.fa --outfmt msf`

![image-20190622132928369](http://ww2.sinaimg.cn/large/006tNc79gy1g49vdg03nvj310w0aedhl.jpg)

`clustalo -i seqs.prot.fa --outfmt vie`

![image-20190622133053321](http://ww1.sinaimg.cn/large/006tNc79gy1g49vexhy47j31yu06sdi8.jpg)

 指定hmm输入，尚未理解，略！！！

`clustalo -i seqs.prot.fa —outfmt sto > seqs.prot.sto`

`hmmbuild seqs.hmms seqs.prot.sto`

`clustalo -i seqs.prot.fa —hmm-in=seqs.hmms`

![image-20190622133807152](http://ww4.sinaimg.cn/large/006tNc79gy1g49vmf5iwoj319u0cwdiy.jpg)