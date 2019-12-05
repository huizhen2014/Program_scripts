#### Chapter 6 OO field guide

class就是一个object的描述，可以通过methods包中的setClass()定义

object就是一个class的实例，可以使用new()创建

generic function就是R分配在methods中的函数，generic function包含“generic”概念(plot, mean, predict,...)

method是generic function针对某一特殊class的对象的处理应用(implementation)

S3称为generic-function OO(object-oriented programming), 无明确的class定义

S4类似S3，但是拥有准确的class定义

Reference classes, 又称RC，不同于S3/4；RC implements message passing OO, so methods belong to classes, not functions。

还有一种不同与以上OO的其他系统，base types：the internal C-level types that underlie the other OO systems。

使用typeof()函数查看对象类型:

![image-20191108161727580](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qpd1aqv9j30gg02a3yk.jpg)

**function is "builtin"**

##### S3

S3是第一个也是最简单的OO系统。仅用于base和stats包的OO系统，也是包最常用的系统。

* 识别objects，generic funcitons和methods：

使用`pryr::otyep()`，返回对象的OO系统：

![image-20191108162254151](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qpipfi32j30gb03b74l.jpg)

同样适用`pryr::ftype()`，查看函数作用的OO系统:

![image-20191108162715724](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qpn8h7qtj30g6048aah.jpg)

* 查看generic function的所有methods：

![image-20191108162849466](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qpov28zvj30ia05e75a.jpg)

* 定义类和创建对象(difinding classes and creating objects)

![image-20191108173851937](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qrpr2sitj30g70290su.jpg)

直接构建，或构建后指定，或使用`inherits()`

* 创建新的methods和generics

增加新的generic，使用`UseMethod()`创建function。该函数拥有两个参数，generic function的名称和method dispath的argument。若没有第二个参数，那么将会dispath到function的第一个参数。

没有methods的generic是没有意义的，使用正确的(generic.class)名称来增加创建的method，或向现存generic增加method:

![image-20191108174943450](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qs11ce7jj30gn04ujrr.jpg)

S3的Method dispatch相对简单的，使用函数`UseMethod()`创建一个函数名称向量，类似`paste0(generic,".",c(class(x),"default")`，然后generic会根据class返回：

![image-20191108175432972](https://tva1.sinaimg.cn/large/006y8mN6gy1g8qs623rdgj30gj04gjrz.jpg)

##### S4

通过`str()`识别S4对象，`isS4()`，`pryr::otype()`用于判断类型

S3可以通过简单改变class属性来改变任何对象的类型，S4需要严格定义：must define the representation of the class using setClass()，and create a new object with new()。

* a name: 字符数字类别识别符，S4类别名称应该使用大写
* a named list of slots(fields)，提供slot名称和所允许的类别。例如：人的类别应该由字符名称和数字年龄来代表: list(name="character",age="numeric")
* a string giving the class it inherits from, or in S4 terminology, that it contains.

此外，S4类别可以设置validity method来检测object的有效性，和prototype设置slot的默认值。

![image-20191111115102264](https://tva1.sinaimg.cn/large/006y8mN6gy1g8tyirgad3j30i2073dgp.jpg)

假如S4 object包含(继承)S3类或一个base type，它将拥有一个特殊的`.Data` slot，包含潜在的base type或S3 object:

![image-20191111115742133](https://tva1.sinaimg.cn/large/006y8mN6gy1g8typp3be4j30i803wgm0.jpg)

S4使用特殊函数构建generics和methods：`setGeneric()`构建新的generic或将现存函数转换进入一generic；`setMethod()` takes the name of the generic, the classes and method shoud be assosicated with and a function that implements the method.

例如：现有union仅用于vectors 类对象，现将其应用于data.frame：

![image-20191111121329545](https://tva1.sinaimg.cn/large/006y8mN6gy1g8tz64c837j30fp0360sy.jpg)

如要构建新的generic，需要提供`standardGeneric()`：

![image-20191111121454824](https://tva1.sinaimg.cn/large/006y8mN6gy1g8tz7lkgh4j30f001xaa5.jpg)

The main difference is how you set up default values: S4 uses the special class 'ANY' to match any class and 'missing' to match a missing argument.

![image-20191111123309075](https://tva1.sinaimg.cn/large/006y8mN6gy1g8tzql0d63j30fc0baq4a.jpg)\

##### RC

Reference classes(or RC for short) are the newest OO system in R, introduced  in 2.12. They are functionally different to S3 and S4 because:

* RC methods belong to objects, not functions
* RC objects are mutable: the usual R copy-on-modify semantics do not apply

略！！！

#### Chapter 7 Environments

**环境(environments)的工作就是关联或者绑定一系列名称到值。**

环境就是power scoping的数据结构，环境类似于列表，具有三个重要的例外情况：

* 修改一个环境，同时也会修改其每一个拷贝的环境
* 环境具有父环境，如果一个对象在一个环境中没有找到，那么R就会在其父环境中查看，依次类推
* 每个环境中的对象都必须有一个名称，且名称必须是唯一的

技术上而言，环境就是一个修饰的框架，收集一系列命名了的对象(像一个列表)，和一个reference指向一个父环境(parent environment)

可以通过`new.env()`构建环境，查看其内容`ls()`，检查其父环境`parent.env()`

![image-20191111192221757](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ubke31qgj30fl03g74i.jpg)

可像修改列表一样修改环境：

![image-20191111192448505](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ubmwgzfyj30ev04twen.jpg)

可使用`$`, `[[`或`get`获得环境内对象，`$`和`[[`仅在环境中查找，**但是`get`使用regular scoping rules并且也在其父环境中查找**

![image-20191111192842081](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ubqy28ugj30f203awei.jpg)

从环境中删除对象类似于`list`，不同的是`list`是设置为`NULL`，而环境为`rm()`

**一般而言，当创建自己的环境时，想要手动设置父环境为空环境。这保证不会意外的从其他环境继承一些对象：**

![image-20191113230845166](https://tva1.sinaimg.cn/large/006y8mN6ly1g8wtckiig7j30xq08sgmp.jpg)

查看对象是否存在某一环境，可设置不查看父环境：

![image-20191111195739554](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ucl2z7hjj30g402s74g.jpg)

查看特殊环境：

`globalenv()`： 用户的工作环境

`baseenv()`：base package的环境

`emptyenv()`： 所有环境的最终初始环境，唯一没有父环境的环境

**最常见的环境为global environment(globalenv())，对应top-leve环境，其父环境就是用户所加载的一个package，其顺序取决于加载包的顺序。然后最终的父环境为base environment，对应'base R'的环境，它的父环境为empty environment。**

`search()`列出所有global和base环境：

![image-20191112091237642](https://tva1.sinaimg.cn/large/006y8mN6gy1g8uzk8oamhj30fg02gmxi.jpg)

可以访问任何search list中的环境：

![image-20191112091503153](https://tva1.sinaimg.cn/large/006y8mN6gy1g8uzmrm2dgj30fu03374m.jpg)

借助`pryr`包的`where()`函数查看相关信息(the environment where the funciton lives)：

![image-20191112092027146](https://tva1.sinaimg.cn/large/006y8mN6gy1g8uzsdwyi1j30ga06u0to.jpg)

递归查询`globalenv()`的ancestor环境包含`baseenv()`和`emptyenv()`:

![image-20191112094826345](https://tva1.sinaimg.cn/large/006y8mN6gy1g8v0lid193j30es05o0t6.jpg)

函数环境(function environments)

一个函数往往关联的多个环境：

函数function被创建时的环境environment，**当一个function被创建时，获得function创建时的环境，使用`environment()`访问function**:

![image-20191112190734699](https://tva1.sinaimg.cn/large/006y8mN6gy1g8vgra8ka0j30jf082myd.jpg)

**闭包(closure):闭包就是能够读取其他函数内部变量的函数。例如在javascript中，只有函数内部的子函数才能读取局部变量，所以闭包可以理解成“定义在一个函数内部的函数“。在本质上，闭包是将函数内部和函数外部连接起来的桥梁。**

![image-20191117203045831](https://tva1.sinaimg.cn/large/006y8mN6ly1g91b9dyieoj30zg0emmzn.jpg)

同样可以修改一个函数function的环境，使用`environment()`，借以阐述R的基本作用域：

![image-20191117203319359](https://tva1.sinaimg.cn/large/006y8mN6ly1g91bc1fyi1j30wg0400t8.jpg)

**函数每次运行时都会创建一个新环境供host执行**：

![image-20191117204042881](https://tva1.sinaimg.cn/large/006y8mN6ly1g91bjqmsyxj310q0f6di5.jpg)

**函数调用时的环境，可通过`parent.frame()`来返回**

![image-20191112202700253](https://tva1.sinaimg.cn/large/006y8mN6gy1g8vj1xi4boj30ge06kt9a.jpg)

**使用`local()`明确作用域，创建一个作用域而不是通过植入到一个函数内function，若需要临时变量，然后用后舍弃，这样不会污染环境内的变量：**

![image-20191112204729918](https://tva1.sinaimg.cn/large/006y8mN6gy1g8vjn8q294j30f205a74p.jpg)

`local()`函数相对有限的用处，但是和`<<-`联合使用时，实现私有变量的共享：

![image-20191117231130743](https://tva1.sinaimg.cn/large/006y8mN6ly1g91fwo52w9j30yi0cqmyk.jpg)

赋值(assignment: binding names to values)

常规赋值(regular binding)，实现当前环境名称和值的关联。语法性赋值(syntactic)和非语法性赋值(no-syntactic)。前者必须以字母或`.`开头(不能后接数字`._1` wrong)：`a <- 1`, `._ <- 2`, `a_b <- 3`；非语法性赋值时，名称可以是任意字符串: `a+b` <- 3; `:)` <- "simle"; `   ` <- "space"

![image-20191117232142662](https://tva1.sinaimg.cn/large/006y8mN6ly1g91g78z8o3j30uk0523yv.jpg)

这里赋值都是发生在当前环境，可以通过三种方式向其他环境赋值：

使用列表方式向环境赋值

`e <- new.env()`

`e$a <- 1`

使用`assign()`函数，三个参数：名称，值，环境：

`e <- new.env()`

`assign("a",1,envir=e)`

使用`eval()`或`evalq()`在环境内赋值：

`e <- new.env()`

**`eval(quote(a<-1),e)` **等同于 `evalq(a <- 1,e)`

常量(constants)，是不能被改变的变量，只能被赋值一次，不能再次赋值，`lockBinding()`用于在package内修改对象：

![image-20191117233141043](https://tva1.sinaimg.cn/large/006y8mN6ly1g91ghmotepj30yw03qgm6.jpg)

![image-20191117233257049](https://tva1.sinaimg.cn/large/006y8mN6ly1g91gixz46jj30wo02s3ys.jpg)

`mean <- 4`可行，这里是syntactic，若non-syntactic：

![image-20191117233605849](https://tva1.sinaimg.cn/large/006y8mN6ly1g91gm7vgyoj30zu02sdgm.jpg)

`<<-`, 另一种修改name和value的binding的方式. 常规命名值, `<-`会在当前环境创建一个新变量. `<<-`不会在当前环境创建新变量, 而是向上在启父环境中修改已经存在的变量, 若`<<-`没有发现存在的变量, 将在global环境创建一个:

![image-20191204230909950](https://tva1.sinaimg.cn/large/006tNbRwly1g9l3dfofoej30yu0ceaay.jpg)

因此: name <<- value 等价于 assign("name",value,inherits=TRUE)

Delayed bindings

构建并存储一个promise用于评估表达始, 而不是立即赋给表达始一个结果, 使用pryr包中的`%<d-%`实现:

![image-20191204231722216](https://tva1.sinaimg.cn/large/006tNbRwly1g9l3lz682sj30t407igmi.jpg)

Active bindings

每次访问该值名称是重新计算该值`%<a-%`:

![image-20191204231952846](https://tva1.sinaimg.cn/large/006tNbRwly1g9l3okv7w3j30s204wjrp.jpg)

#### Chapter 8 Debugging, condition handling and defensive programming

































