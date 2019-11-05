#### [S4 object system][http://adv-r.had.co.nz/S4.html]

R拥有三种面向对象系统(OO sytems)：S3/S4/R5

S4不同与S3：正式的类别定义，S4正式定义了每个类别的representation和inheritance；多重dispatch，generic函数能够通过任意数目的类别参数分配到一个method，而不是S3中的一个class类别

##### Classes and instances

在S3中可通过设置class属性来将任一对象的类别修改为其他类别，而S4更严格，必须使用`setClass`定义call的representation，同时instance(实例)唯一的构建方式就是通过构建函数new。

一个S4类别包含三个关键特征：

* 名称，字母字符串指明类别名称
* **Representation(代理)，一系列slots(attributes, 属性)，定义其名称和类别。例如，一个person类别可能通过字符名称和数字年龄来代理: representation(name="character",age="numeric")**
* **类别的字符串向量代表它所继承的形式，或称为contains。值得注意的是，S4支持多重继承。**

使用`setClass`构建类别(contains)：

![image-20191028232134143](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ebsxvuydj30pq03ojsb.jpg)

使用`new`构建该类别的实例：

![image-20191028232225991](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ebtubve8j30r807imxy.jpg)

不同于S3, S4在使用`new`构建实例时会检查所有的slots的类型是否正确：

![image-20191028232438459](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ebw55artj30re04qwfg.jpg)

同时查看slots：

![image-20191028232545665](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ebxasxnhj30ro036mxo.jpg)

若省略一个`slot`，将会默认采用该类别的初始值，使用@访问S4对象的slots：

![image-20191028232749172](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ebzfzqwij30r802udg4.jpg)

或直接使用`slot`函数：

![image-20191028232830396](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ec05s9xqj30ra022jrh.jpg)

同时避免空slots的默认值出现，可在class中设置默认的`prototype`：

![image-20191028233318458](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ec55m0qtj30rg06kt9u.jpg)

函数`getSlots`返回一个类别的所有slots描述：

![image-20191028233427765](https://tva1.sinaimg.cn/large/006y8mN6ly1g8ec6cpe1aj30ra02u3yq.jpg)

Notes: In particular, note that the examples rely on the fact that multiple calss to `setClass` with the same class name will silently override the previous definition unless the first definition is sealed with `sealed=TRUE`.

##### Checking validity

提供可选function增加限制，该函数应含一个参数object，同时有效情况下返回TRUE，无效时返回字符向量给出错误原因：

![image-20191029114224458](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ex7s1n5mj31040fowhm.jpg)

例如：

![image-20191029113751412](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ex31mt0lj312m08040r.jpg)

同时当直接修改slot值时，该判断不会自动进行，调用validObject函数：

![image-20191029114305550](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ex8hl8vlj311s06275g.jpg)

##### Generic functions and methods

generic functions and methods work similarly to S3, but dispath is based on the class of all arguments, and there is a special syntax for creating both generic functions and new methods.

**The `setGeneric` function is called to initialize a generic function as preparation for defining some methods for that function.**

函数`setGeneric`提供两种方式创建新的generic：

![image-20191029123139561](https://tva1.sinaimg.cn/large/006y8mN6gy1g8eyn0uvtxj30v206i755.jpg)

若直接构建，第二个参数应该为一函数定义所有的参数：

![image-20191029123318472](https://tva1.sinaimg.cn/large/006y8mN6gy1g8eyoqnk4mj30wo07ojsg.jpg)

继承sides function：

![image-20191029123726187](https://tva1.sinaimg.cn/large/006y8mN6gy1g8eyt145xdj30yg052gms.jpg)

使用sides slot直接定义polygon的method，`setMethod`函数拥有3个参数：genric function的名称，匹配给method的signature，和计算结果的函数

![image-20191029124153574](https://tva1.sinaimg.cn/large/006y8mN6gy1g8eyxnu6osj30ui06sjsf.jpg)

针对含有少量参数的generic可直接给定`signature`参数的值，这将省略空间同时位置要对应参数值：

![image-20191029130504431](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ezlsksxpj30xw030jsa.jpg)

可通过指定`valueClass`来定义generic的输出：

![image-20191029131041431](https://tva1.sinaimg.cn/large/006y8mN6gy1g8ezrmrz9dj312w082wga.jpg)

使用函数`showMethods`查看定义了的generic function的methods：

![image-20191029164150958](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f5vdqm1ij30wg09mta2.jpg)

##### Method dispatch

调用(call)generic function的正确method，若在调用(call)中的objects的class之间，和method的signature之间存在精确匹配，那么就调用该methods。否则：

* 对于调用function的每一个参数，计算class之间，和signature中的class的距离。若相同，距离为0，若class的signature为调用class的parent，距离为1；若为grandparent，距离为2，依次类推。
* 计算每一个method的距离，若存在唯一最小距离的method，直接采用。否则，给出警告信息同时采用匹配methods中的一个(按照字母顺序)。

![image-20191029165645116](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f6aulhqtj30yg0e0whd.jpg)

通常，为避免这类问题，需提供更特定的method：

![image-20191029165827522](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f6cm1cpmj30x8032mxl.jpg)

有两个特殊的class可以用于`signature`:`missing`和`ANY`。`missing`匹配未提供参数的情况(argument is not supplied)，`ANY`用于设定默认methods，同时`ANY`拥有最低的顺序用于method匹配(lowest possible precedence in method matching)。

同样可以使用basic classes，例如`numeric`,`character`和`matrix`。A matrix of characters will have class`matrix`。

![image-20191029170650970](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f6lcwd73j30y6080taa.jpg)

另外：

![image-20191029171058245](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f6pmu2eaj30ym056wfd.jpg)

也可以在S4中dispatch S3 classes，通过calling setOldClass：

![image-20191029172714394](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f76kkypqj312y0dsq4m.jpg)

##### Inheritance

构建简单的vehicle inspections model，该model根据vehicle(car/truck)的类型不同和inspector(normal/state)不同调用不同的输出。

在S4中，`callNextMethod`函数用于调用下一个method，通过假设当前method不存在，寻找最近的下一个匹配的method

首先设置classes，2 vehicle类型和2 inspect类型：

![image-20191029184919502](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f9jyzxu0j30vm05udha.jpg)

接着，定义generic function用于检查vehicle，拥有两个参数，被检查的vehicle和检查的人:

![image-20191029183844634](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f98ywc9xj30wc03wwf1.jpg)

所有的vehicle都要被所有检查人查看生锈情况，同时Cars需要检查其安全带:

![image-20191029184043781](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f9b1d8y1j30xi08m75z.jpg)

执行Cars/Inspector:

![image-20191029184131340](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f9butdjnj30wu030wew.jpg)

怎加针对trucks的检查，同时指定state inspector查看Cars的保险:

![image-20191029184257207](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f9dc9in9j30xu08idhe.jpg)

以及:

![image-20191029184945342](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f9kf9xskj30wy09m75y.jpg)

![image-20191029185041890](https://tva1.sinaimg.cn/large/006y8mN6gy1g8f9lecbjfj30x602uq3e.jpg)

##### Method dispatch2

构建一个简单的class结构，有3个classes，class C继承一个字符向量，B继承C，A继承B。

![image-20191029204839479](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fd05987uj30wm05y3zd.jpg)

构建的class关系如下:

![image-20191029204911887](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fd0pcf0fj312603ot8q.jpg)

构建generic f，同时dispatch两个参数: x和y

![image-20191029205005271](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fd1mn3mhj30we026dg0.jpg)

为预测generic将会使用的method，需要知道:

* the name and arguments to the generic
* the signatures of the methods
* the class of arguments supplied to the generic

最简单method dispath是准确的匹配: exact match between the class of arguments(arg-classes) and the signature of (sig-classes):

![image-20191029205455493](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fd6nw9smj30xi05y3za.jpg)

如果我们增加另一个class, BC, that inherited from both B and C, then this class would have distance one to both B and C, and distance two to A:

![image-20191029205630363](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fd8b58tgj3136084jrp.jpg)

![image-20191029205707213](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fd8yezxjj30w208iq4o.jpg)

两个特殊的classes可用于signature: missing和ANY。missing匹配未提供的参数，ANY用于设定默认methods，同时ANY拥有最小的优先级用于method匹配:

![image-20191029210132429](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fddjlhexj30xm082gmv.jpg)

##### In the wild

To conclude, lets look at some S4 code in practice. The Bioconductor EBImage, it has only one class, an Image, which represents an image as an array of pixel values.

![image-20191029210559245](https://tva1.sinaimg.cn/large/006y8mN6gy1g8fdi662a6j30sk09imyk.jpg)

略！！！















