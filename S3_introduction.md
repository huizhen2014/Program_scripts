#### [S3 Introduction][https://www.youtube.com/watch?v=VZkD7DXQ-fk&list=PLI098pDmWQZqjayjwmeSJ2Zgt1M1Yi_RE&index=8&t=2961s]

####Scaling the language/ Easy to extent the language

* Object-Oriented Programming

当对象接受并传递信息时所具有特征：

Encapsulation：信息是隐藏的，避免被code细节所干扰，方便使用

Inheritance：code(脚本，代码)能够很容易在不同对象中分享，generic 函数容易在不同函数中使用

Polymorphism：该过程能够接受并返回不同的对象类型，针对不同的class类型

* S3 OO is class-base and impure/hybrid

class：对象属性，指定对象所能接受或返回的信息

method：用于指定class的函数

dispatch：为某一class特殊的函数选择，appropriate version of function

* Discovering Infrastructure: Generic Method

![image-20191027205613966](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d1zecmqhj30sc04ujrx.jpg)

当使用mean时，首先查看function(x,...)中的x的class，一般为第一位置值，然后对应使用mean.class_value，例如x的class为data.frame，那么使用对应的mean.data.frame函数

![image-20191027211037986](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2ee8851j30ww02odg8.jpg)

拥有不同的class类型处理策略，如果x的class不在其中，采用mean.default的函数

![image-20191027210549986](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d29enm6fj318j0u07a6.jpg)

* Discovering Infrastructure: Classes for a Method

查看mean的函数的classes：

![image-20191027211142688](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2fifjd4j30wo02yaak.jpg)

* Discovering Infrastructure: Methods for a Class

查看class拥有的methods：

![image-20191027211504343](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2j0cpkvj30wm05uab4.jpg)

例如查看nobs的method

![image-20191027211836416](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2mouif5j30we04mq3k.jpg)

查看对应的class的function：

![image-20191027212008427](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2oa5zokj30wq02a3ym.jpg)

* Discovering Infrasture: getAnywhere

![image-20191027212130394](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2pptay5j30x00bmgno.jpg)

使用getAnywhere函数查看隐藏methods的信息或者根据namespace

![image-20191027212304752](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2rc68i5j30wi05qq3w.jpg)

* Deploying a New Class

![image-20191027212636140](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2v0275jj30w604y0t4.jpg)

* Writing a New Generic Function

![image-20191027213044007](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d2zapdn3j30wu0143yl.jpg)

* Writing a Method

![image-20191027213342503](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d32el014j30w804o0tj.jpg)

**x的class为digit，对应采用reveal.digits的function**

* Inheritance

使我们的objects能够从generic classes去借code

very artifical example

![image-20191027213755656](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d36sdukpj30we02sq34.jpg)

* Methods can be Overridden

![image-20191027214934189](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d3iw8a0dj30wg04cwf5.jpg)

打印不同指定不同method时的confint值

![image-20191027215133914](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d3kz7vuwj30wc08qwg5.jpg)

原因：confint针对不同的class拥有对应的method，星号表隐藏

![image-20191027215501937](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d3oky1erj30wu04udgr.jpg)

* Object-Oriented Programming Redux

![image-20191027215654244](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d3qj8vjxj318o06k75p.jpg)

* Debugging

![image-20191027215836209](https://tva1.sinaimg.cn/large/006y8mN6gy1g8d3scdigsj31900bcmyn.jpg)

31 min