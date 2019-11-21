#### [Classes and Methods in R][https://www.youtube.com/watch?v=93N0HdoZW9g&list=PLI098pDmWQZqjayjwmeSJ2Zgt1M1Yi_RE&index=10&t=0s]

* Two styles of classes and methods

![image-20191101225741847](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixlcbwu2j316u0ka44w.jpg)

**S3缺点就是新类别对象没有正式的定义**

* Two worlds living side by side

![image-20191101230101813](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixosxbtrj31700kcqgy.jpg)

* Object Oriented Programming in R

![image-20191101230203916](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixpvu6cxj316y0kg7f3.jpg)

**generic funciton 典型地包含了‘generic' 概念(plot,mean,predict,..是generic function而不是method)**

**generic funciton识别object的class，然后应用对应的method**

* Things to look up

![image-20191101230653641](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixuwg55ej31700ka7e2.jpg)

* Classes

![image-20191101230736714](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixvob6z7j316c0kgjwl.jpg)

* Classes (cont'd)

![image-20191101230833056](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixwmwnomj316u0jgadn.jpg)

**可以指定输出class，从而为输出配置对应的method**

* Generics/Methods in R

![image-20191101231035343](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixyr556vj316m0jkahy.jpg)

* An S3 generic function(in the 'base' package)

![image-20191101231147484](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ixzzz25cj316s0ju7b3.jpg)

**根据x类型使用对应的'mean' method**

* S3 methods

![image-20191101231323099](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iy1nwoz0j316s0jeq5v.jpg)

**使用method函数查看对应function的method信息，点后面指定class类型**

* An S4 generic funciton(from the 'methods' pacakge)

![image-20191101231609179](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iy4jfu3ej316o0k2tk7.jpg)

*  S4 methods

![image-20191101231709017](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iy5kyip9j316o0ken7t.jpg)

* Generic/method mechanism(S3/4)

![image-20191101231809611](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iy6mvl9rj316w0jydqv.jpg)

* Examining Code for Methods

![image-20191101232107721](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iy9popn1j316g0jgthx.jpg)

* S3 Class/Method: Example 1

![image-20191101232356624](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iycn5tmpj316e0jqdkr.jpg)

* S3 Class/Method: Example1

![image-20191101232504347](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iydtae1nj316k0kq11w.jpg)

* S3 Class/Method: Example2

![image-20191101232729483](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iygc3zbmj316u0k4ak8.jpg)



**数据框的每一列可以是不同的类型**

* Calling Methods

![image-20191101232836707](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iyhhpb3fj316q0jsq6z.jpg)

* S3 Class/Method: Example3

![image-20191101233011317](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iyj55wx9j316k0kkq7g.jpg)

* S3 Class/Method: Example3

![image-20191101233118748](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iykbhdctj316i0lkn39.jpg)

* Write your own methods

![image-20191101233225099](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iylgnqzaj31700jwjz6.jpg)

* S4 Classes

![image-20191101233350326](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iymxzy1rj316w0k67dc.jpg)

* S4 Class/Method: Creating a New Class

![image-20191101233524235](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iyoksuw5j316q0jq457.jpg)

* S4 Class/Method: Polygon Class

![image-20191101233727787](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iyqpt09tj316m0joq96.jpg)

* S4 Class/Method: Polygon Class

![image-20191101234033871](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iytxxf4bj316m0kwals.jpg)

**function(x,y,...)必须含有x,y，因为'polygon'含有xy，可含有其他变量**

* S4 Class/Method: Polygon Class

![image-20191101234402104](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iyxjmiyuj31760la124.jpg)

**退出R, 重启需重新定义**

* S4 Class/Method: Polygon Class

![image-20191101234502489](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iyylj045j316u0k6n47.jpg)

**ANY, 表示defult method, polygon为自定义**

* S4 Class/Method: Polygon class

![image-20191101234626848](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iz01tfttj316y0kedir.jpg)

* Where to Look, Places to Start

![image-20191101234747147](https://tva1.sinaimg.cn/large/006y8mN6ly1g8iz1g8yqoj316o0kcdpx.jpg)

***



