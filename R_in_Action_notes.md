##R in Action

#### 简介

* example("foo")             函数foo的使用示例
* apropos("foo",mode="function") 列出名称中含有foo的所有可能函数
* data()                             列出当前加载包中所含的所有可用示例数据集
* vignette()                       列出当前安装包中所有可用的vignette文档
* vignette("foo")             为主题foo显示指定的vignette文档   
* history(#)                     显示最近使用过的#个命令   
* .libPaths()                     显示当前库所在位置
* browseURL()                网页浏览
* dowload.load()            下载文件到本地
* dir.create()                   新建文件
* list.files/list.dirs(path=".",all.files=F/T,full.names=F/T,recursive=F/T)                  显示目录下文件或目录下文件夹
* file.create()                  文档创建
* file.exists()                   判断文档是否存在
* file.remove()               文档删除
* file.rename(from,to)               文档重命名
* file.append(file1,file2)               文档添加
* file.copy(from,to,recursive=F/T)                    文档复制
* file.symlink(from,to) 文档链接
* file.show()                    显示文档内容
* file.info()                       显示文档信息
* file.edit()                        编辑文档
* zip()/unzip()                   压缩/解压缩文档; zip("plot.rdata.zip", "plot.rdata", extra=c("-r","-e")), enter password: verify password:
* get()                           返回命名了的对象的值
* attributes(my.group)   产看一个对象所包含信息
* download.file(url,destfile,method)
* update.packages()
* help(summarize, package="plyr")
* plyr::summarize()
* BiocManager::install("packages")
* 代码(code): `print("hello, R!")`
* 安装本地下载包install.packages("/Users/carlos/Downloads/gridGraphics_0.3-0.tar.gz")
* github安装：install.packages("devtools"); devtools::install_github("tidyverse/tidyr")
* 列举包中的函数及数据集 ls("package:GO.db")
* 查看包中所有函数help help(package="GO.db")
* Sys.getenv("HOME")，获得用户home目录
* Sys.getenv("R_HOME")，获得R的home目录：

#### 创建数据集

* 向量

1. a <- c(1,2,5,3,6,-2,4)
2. b <- c("one","two","three")
3. c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)

* 矩阵

1. y <- matrix(1:20,nrow=5,ncol=4)	5x4矩阵

2. cells <- c(1,26,24,68)

   rnames <- c("R1","R2")

   cnames <- c("C1","C2")

   mymatrix <- matrix(cells,nrow=2,byrow=TRUE,dimnames=list(rnames,cnames))

* 数组

1. dim1 <- c("A1","A2")

   dim2 <- c("B1","B2","B3")

   dim3 <- c("C1","C2","C3","C4")

   z <- array(1:24,c(2,3,4),dimnames=list(dim1,dim2,dim3))

* 数据框

1. patientID <- c(1,2,3,4)

   age <- c(25,34,28,52)

   diabets <- c("Type1","Type2","Type1","Type1")

   status <- c("Poor","Improved","Excellent","Poor")

   patientdata <- data.frame(patientID,age,diabetes,status)

2. patinetdata[1:2] or patientdata[c("diabetes","status"))

3. attach()将数据框添加到R搜索路径，detach()移除

4. with(mtcars,{

   summary(mpg,disp,wt)

   plot(mpg,disp)

   }) 	赋值仅在扩号内生效，使用<<-可将对象保存在with()外的全局环境中

5. within(leadership,{

   agecat <- NA (not a available)

   agecat[age > 75]                               <- "Elder"

   agecat[age >75 & age <= 75]         <- "Middle Aged"

   agecat[age  <75]                               <- "Young"})

6. transform(airquality,Ozone=-Ozone)

   transform(airquality,new=-Ozone,Temp =(Temp-32)/1.8)

7. subset() 选入变量和观测

   subset(leadership,gender=="M" & age > 25, select=gender:q4)

8. rename(dataframe,c(oldname="newname"…))

9. is.na() 检测每个变量 / na.omit() 删除行/na.rm=TRUE 函数选项;置换data.frame中的NA: dat[is.na(dat)] <- 0

10. which(x) 给出对应逻辑值"TRUE" / “FALSE"

  which((1:12)%%2 == 0) 输出能整除2的数的index

11. order() 默认升序，得到排序后值位置index

    leadership[order(leadership$age),]

    a <- c(3,4,5,1,2,3,9,3,0,2,0)

    a[order(a)] 0 0 1 2 2 3 3 3 4 5 9

12. sort(x, decreasing=F,...) 将当前值从小到大排列

13. reorder(x,X,FUN) 第一参数为被排序的因子序列，**第二个参数是等长度的作为排序参考的序列，第三个是构造排序标准的加工函数**

14. 合并数据，merge(dataframeA,dataframeB,by=c("ID","Country"))

15. 选入数据，dataframe[row indices,colnum indices]

16. 删除数据%in%

    myvars <- names(leadership) %in% c("q3","q4")

    newdatas <- leadership[!myvars]

    leadership\$q3 <- leadership\$q4 <- NULL(为定义）

17. sample() 随机抽样

    leadership[ sample(1:nrow(leadership),3,replace=F),]

* 列表

1. g <- "my first list"

   h <- c(25,26,18,39)

   j <- matrix(1:10,nrow=5)

   k <- c("one","two","three")

   mylist <- list(title=g,ages=h,j,k)

2. mylist[[2]] or mylist[["ages"]]

3. bash下标从0开始，awk下表从1开始，R下标从1开始，Python下标从0开始

* 数据输入

1. read.table(file,header=TREU/FALSE,sep=",",stringsAsFactors=FALSE)
2. read.table(file,header=TRUE/FALSE,sep=",",colClasses=c(logical, numeric,character,factor)
3. library(readr), read_delim 读取文本，注意最后的空行会读取进入将命名为X行号—NA，可转换为data.frame, na.omit=TRUE
4. gzfile(),bzfile(),xzfile(),unz() 读取压缩文件
5. 导入excel，library(xlsx),library(openxlsx),library(readxl)
6. libary(xlsx), read.xlsx()

* 值标签

1. patientdata$gender <- factor(patientdata\$gender,levels=c(1,2),labels=c("male","female")) levles代表了实际值，labels代表包含了理想值标签的字符向量

2. str(),class(),dim(),mode(),cbind(),rbind()

3. newobject <- edit(object) 编辑对象并另存为newobject

   fix(object) 直接编辑对象

#### 基本数据管理

* 符号,逻辑及转换

1. +,-,*,/,^or**
2. x%%y,求余；x%/%y，整数除法
3. <,<=,>,>=,==,!=,!x,x|y,x&y,isTRUE(x)
4. is.numeric(), is.character(), is.data.frame(), is.factor(), is.logical()
5. as.data.frame()

* 日期

1. date(), 返回时间日期, Sys.Date() 日期

2. as.Date(x, "input_format") 

   %d 01~31; %A Monday; %m 00~12; %B January; %Y 2007

   mydates <- as.Date(c("2007-06-22","2004-02-13"),"%Y-%m-%d")

3. format(Sys.Date(), format="%B %d %Y")

4. difftime()计算时间间隔

   difftime(Sys.Date,as.Date("1956-1–22"),units="weeks")

5. strDates <- as.character(dates) 将日期转为字符型

* 数学函数

1. abs(), sqrt(), ceiling(x), floor(x), trunc(x), round(x,digits=n)

2. log(x,base=n), log(x), log10(x), exp(x)指数函数

3. quantile(x,probs）probs[0,1] 求分位数

   quantile(x,c(0.3,0.84))

4. scale(x,center=T,scale=T) 将对象列中心化(center=T)或标准化(center=T,scale=T) 默认值

   scale(mydata)*SD + M 默认标准差为1，均值为0

* 概率函数

1. d=密度函数(density)；p=分布函数(distribution function)；q=分位数函数(quantile function); r=生成随机数(随机偏差)

2. nbinom, norm, pois, unif 负二项式分布，正态分布，柏松分布，均匀分布

3. plot(norm(100),dnorm(rnorm(100))) 绘制分布函数图

4. set.seed(num) 设立随机种子，实现结果重复

   set.seed(1234); runif(5, min=0,max=1)

* 字符处理函数

1. nchar(x)字符, length(x)长度

2. substr(x, start,stop) 提取或替换一个字符向量的子串

3. grep(pattern, x, ignore.case=FALSE,value = FALSE,fixed=FALSE) 在x中搜素某种模式。fixed=F, pattern为正则。返回匹配下标, invert=T, 表示反向查询。

4. sub(pattern, replacement, x, ignore.case=F, fixed=F) 在x中搜索pattern, 并以文本replacement将其替换。fixed=T, pattern为文本字符:

   `sub("(.*treated).*","\\1",sampleFiles)`

5. strsplit(x, split,fixed=F) 在split处分割字符向量x中的元素。若fixed=F, 则pattern为正则。返回一个list。unlist(y)[2], sapply(y, "[",2)

6. paste(…,sep="") paste("x",1:3,sep=""); paste("x",1:3,sep="m")

7. seq(from,to,by) seq(1,10,2)

   seq.int(from,to,by)

   seq_along(leadership)

   seq_len(leng.out)

8. rep(x,n) rep(1:3,2) c(1,2,3,1,2,3,)

   rep(1:4,each=2) == rep(1:4,c(2,2,2,2))

   rep(1:4,each=2,len=4)

   rep_len(1:3,8) 1,2,3,1,2,3,1,2

9. tcut(x,n) 将连续变量x分割为有着n个水平的因子, ordered_result=T创建一个有序因子

10. pretty(x,n) 创建美观分割点，通过选取n+1个等间距的取整值，将一个连续变量x分割为n个区间

11. cat(…,file="my file",append=F) 链接…中对象，并将其输出到屏幕上或文件中(如果声明了一个的话) cat("Hello","Jane","\n")

12. apply(矩阵或数据框，MARGIN,FUN,…）

    apply(mydata,1,mean，trim=0.2)

    sapply()返回向量, lapply()返回列表，将函数应用到list上

    sapply(x, FUN, options) sapply(name,"[",1, na.omit=T)

* 控制流

1. for(var in seq) statement

   for(i in 1:10) print("Hello")

   next 跳出本次循环

   break 跳出本层循环，当存在多个for循环，即跳出最近一个)

2. while(cond) statement

   i <- 10; while(i>0){print ("Hello"); i<- i-1}

3. x <- 1; 

   repeat{

   print(x)

    x=x+1 

   if(x == 6){

   break}

   }

4. if(cond) statement

   if(cond) statment1 else statement2

   ifelse(cond, statement1, statement2） 

   outcome <- ifelse(score > 0.5, print("Passed"),print("Failed"))

   if(cond) {statements} else if(cond) {statements}

   **The double equals operator can't tolerate an `NA` on either side. If I define: `x = NA` and then do an `if (x == NA){ ... }` then this error will be thrown at runtime when the parser examines the left hand side of the double equals. To remedy this error, make sure every variable in your conditional is not NA using `is.na(your_variable)`**

5. switch(expr,…)

   feelings <- c("sad","afraid")

   for(i in feelings){

   print(

   switch(i,

   happy="I am glad you are happy",

   afraid="There is nothing to fear",

   sad="Cheer up",

   angry="Calm down now"

   })

6. function(arg1,arg2,…){

   statements

   return(object)

   }

* 整合和重构

1. t(mtcar) 将矩阵或数据框进行转置

2. aggregate(x,by,FUN) x为待折叠数据对象，by是一个变量组成列表，将这些列表变量通过FUN变为新的观测 aggregate(mtcars, by=list(cyl,gear), FUN=mean, na.rm=T)

3. library(reshape2)

   melt(data, …, na.rm=F)

   melt(mydata, id=c("id","time"))) 融合，根据id对其重新排列cast(md, rowvar1+rowvar2 + … ~ colvar1+ colvar2+… , FUN)

   rowvar1+rowvar2 + … ~ colvar1+ colvar2+… 定义了要选入的变量集合，以确定各行内容
   
   dcast(data,formula=Var1~Var2,fun.aggregate=mean,margins=NULL)解析melt的融合后的数据


#### Miscellaneous

1. rm(list=ls()[! ls() %in% c("find_the_lost_sample","data_list","lab_samples")])  删除不想要的对象
2. library(plyr); round_any(x,X,FUN); round_any(24.534, 10, ceiling) [1]30; round_any(24.534, 10, floor) [1] 20
3. 2:7 %o% 1:2 == outer(2:7,1:2)

***

###**plyr & dplyr** 

**summarize()是对数据做汇总, 不同于mutate, 它不会增加列到现存数据集, 它创造一个新的数据框** 

library(plyr)

library(ggplot2)

summarize(mpg, a=quantile(displ), b=quantile(displ))

ddply(mpg, .(manufacturer), summarize,q=quantile(displ))

**mutate()类似transform(), 但是它能迭代使用新生成的列信息来产生新的列信息**

**tramsform可行**

mutate(airquality, Ozone=-Ozone)

mutate(airquality, new=-Ozone, Temp=(Temp - 32)/1.8)

**transform()不可行**

mutate(airquality, Temp=(Temp-32), OzT=Ozone/Temp) #存在迭代使用第一次计算得到的Temp

**transmute()增加新的数据同时丢弃原有数据, 而mutate()保留原有数据同时增加新的数据**

mtcars %>% mutate(displ_1=disp/61)

mtcars %>% transmute(displ_1=disp/61)

**group_by()要搭配summarize()使用, 对现有数据根据变量进行分组**  

mpg %>% **group_by(manufacturer,cyl)** %>% summarize(m=min(displ),n=max(displ))  ##返回data.frame, 对应分组后的m和n

mpg %>% summarize(m=min(displ),n=max(displ))  ##返回两个值m和n

**filter()选择条件为真的行内容(row/case)** 

== > >= & | ! xor() is.na() between() near()

filter(starwars, mass>7)

starwars %>% filter(mass > mean(mass, na.rm =T))

starwars %>% group_by(gender) %>% filter(mass > mean(mass, na.rm = TRUE))

**arrange()根据变量对数据排序**

arrange(mtcars, mpg, disp)

arrange(mtcars, desc(mpg))

**select()选择或重命名变量名, select()仅保留所选的变量; rename()保留所有变量**

starts_with() ends_with() contains() matches() num_range() one_of() everything() group_cols() 

select(mtcars,cyl:wt)

select(mtcars, -cyl)   #符号表删除

***

### **tidyr**

**gather(data, key="Key", value="value", …, na.rm=F, convert=F, factor_key=F)**

将多重列转成key-value对的结构，key和value都是新生成列的名字；后接一段列名称，空置表示全选；x：y一段范围；-y排除y列，具体规则同select()函数。

`> billboard %>% gather(week,rank,wk1:wk76,na.rm=T) %>% mutate(week=extract_numeric(week),date=as.Date(date.entered) + 7 * (week -1)) %>% select(-date.entered) %>% arrange(artist,date,rank)`

**spread(data, key, value, fill=NA, convert=F, drop=T, sep=NULL)**

将key-value对分不到多个列中，其中key为拆分为新的列，value的值对应到新的列下。

`weather3 %>% spread(element, value)`

**separate(data, col, into, sep, remove=F…)**

针对给对的正则表达或字符向量位置将col列转化into成多个列，其中sep为字符串时表正则表达式，为数字时，表示col分开的位置。

`> tb2 %>% separate(demo,c("sex","age"),1)`

separate_row(data, …, sep="[\^[:alnum:].]+", convert=F)

当一个列的值包含多个限定的值，将其分开当当前列的不同行中

`separate_rows(table3, rate)`

**unite(data, col, …, sep="_", remove=T)**

将多个列合并到一个列

`unite(table5, century, year, col="year", sep="")`

**unique(x, incomparables=F, …)**

unique返回一个向量，数据框或数组，对应的重复的元素或行都被删去

`> billboard3 %>% select(artist, track, year, time) %>% unique() %>% mutate(song_id=row_number())`

***

#### Tibbles

增强型数据结构，新的S3数据结构用于存储表格型数据，具有以下优点: subsetting，一贯返回一个新的tibble, 而[[和$返回向量；no partial matching，当行subsetting时，需使用全列名称；display，当屏幕打印tibble，输出一个匹配屏幕的简洁视野。

**View(), glimpse()**： 查看全部数据

**as.data.frame()**：转成data frame

**as_tibble(x, ...)**：将数据框转成tibble

**enframe(x, name="name", value="value")**：将名称向量转成tibble

**is_tibble(x)**：检查是否为tibble

![image-20190513091924391](/Users/carlos/Library/Application Support/typora-user-images/image-20190513091924391.png)

***

### Strings

函数str_开头，蒋向量作为第一个参数

`x <- c("why", "video", "cross", "extra", "deal", "authority")`
`str_length(x) `

[1] 3 5 5 5 4 9

str_c(x, collapse = ", ")

[1] "why, video, cross, extra, deal, authority"

`str_sub(x, 1, 2)`

[1] "wh" "vi" "cr" "ex" "de" "au"

`str_subset(x, "[aeiou]")`

[1] "video"     "cross"     "extra"     "deal"      "authority"

`str_count(x, "[aeiou]")`

[1] 0 3 1 2 2 4

`str_detect(x, "[aeiou]")`

[1] FALSE  TRUE  TRUE  TRUE  TRUE  TRUE

`str_count(x, "[aeiou]")`

[1] 0 3 1 2 2 4

`str_subset(x, "[aeiou]")`

[1] "video"     "cross"     "extra"     "deal"      "authority"

extract the characters on either side of the vowel

`str_match(x, "(.)[aeiou](.)")`

[,1]  [,2] [,3]

[1,] NA    NA   NA  

[2,] "vid" "v"  "d" 

[3,] "ros" "r"  "s" 

[4,] NA    NA   NA  

[5,] "dea" "d"  "a" 

[6,] "aut" "a"  "t"

`str_replace(x, "[aeiou]", "?")`

[1] "why"       "v?deo"     "cr?ss"     "?xtra"     "d?al"      "?uthority"

`str_split(c("a,b", "c,d,e"), ",")`

[[1]]

[1] "a" "b"

[[2]]

[1] "c" "d" "e"

***


