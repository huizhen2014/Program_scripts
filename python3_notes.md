####python3_notes

* 数和表达式

// 数学运算舍弃小数部分，即执行整除运算 1//2 = 0

% 求余(求模)运算, x % y 结果为x除以y的余数: x%y 等价于 x- ((x//y)*y)

pow(x,y) 求幂，等同于x**y

abs 求绝对值

int 取整数

round 将浮点数圆整为最接近的整数

* 变量

在python中，名称(标示符)只能由字母，数字和下划线构成, 且不能以数字打头

* 获得用户输入

单语句块, 指仅包含一句的语句块，可以在同一行指定，例如条件语句和循环

`if 1==2:print('One equals two')`

* 注释

井号(#)，开启解释行。程序员应准守, 勤注释，注释务必言而有物，不要重复去讲通过代码很容易获得的信息，无用的注释还不如没有。

* 单双引号字符串以及对引号转义

若字符串中有单引号，应使用双引号，避免混淆；若字符串包含双引号，那么使用单引号将整个字符串括起。也可以使用转义符反斜杠(\\)转移。

* 拼接字符串

可依次输入两个字符串，python则自动将其拼接一起；而输入两个变量时则需使用加号(+)：`x="hello, "`;`y="world!"`;` x+y` 'hello, world!'

* 字符串表示str和repr

python打印(print)的所有字符串，都用引号括起，不管单双引号都会对符号转移打印。用户可通过两种不同机制将值转换为字符串,str和repr。

str能以合理的方式将值转换为用户能够看懂的字符串，尽可能将特殊字符编码转换为相应的字符

repr则获得值的合法python表达式表示

`print(repr('hello, \nworld!'))`; `'hello, \n world!'`

`print(str('hello, \nworld!'))`; 

`hello,`

`world!`

* 长字符串，原始字符串和字节

跨越多行的字符串，可使用三引号(而不是普通引号,'''或“”“)

`print9'''This is a very long string....''')`

或者简单使用反斜杠(\\)转移换行

使用反斜杠(\\)进行特殊字符的原始字符输出: `\\n`；或者使用原始字符串前缀r函数，输出原始字符串，此时，原始字符串不能以单个反斜杠结尾。

`print(r'let\'s go!'')`; `let'\s go!`

* 序列

通用序列操作包含索引，切片，相加，相乘和成员资格检查；同时python提供了一些内置函数，用于确定序列的长度以及查找序列中的最大，最小元素

序列中所有元素都有编号，从0开始从左到右递增；相反从右到左时，从-1开始索引

使用切片(slicing)访问特定范围内的元素tag[9:30:1]，其中第一数字为起点，第二为终点，第三个为步长；同时遵守左开右合的规范，同样适用于负数索引。tag[-3:]为最后三个元素;tag[:3]为开头三个元素;tag[:]为整个序列; tag[::-1]表示反转tag字符，步长为负表示从右往左提取元素

序列相加时要针对同类型序列

序列与数字相乘时，表示重复序列

空表格为[]，若创建未添加任何内容的10个元素的表格: `[None]*10`，使用None

使用运算符in检测序列中是否包含特定的值, 满足返回True，不满足范围`False：'w' in 'world'; True`

len(numbers)，返回元素个数；max(numbers)，返回最大值；min(numbers)，返回最小值；注意max和min要strings/numbers中类型相同

* 列表

使用函数list创建列表

`list('hello')`

`['h','e','l','l','o']`

如要将字符列表转换为字符串，使用join:  `''.join(somelist)`

可对列表执行所有标准序列操作，如索引，切片，拼接和相乘等

可使用索引对列表修改或着给元素赋值，但是不能给不存在(索引)的列表元素赋值

删除元素, del语句即可: `del names[2]`,同时列表长度缩短，也可使用del删除字典和变量

使用切片对列表赋值，替换值，或者替换为长度与其不同的序列

可在不替换原有元素的情况下插入新元素: `numbers=[1,5]`; `numbers[1:1]=[2,3,4]`;`numbers=[1,2,3,4,5]` ;也可以插入空序列来删除切片`numbers=[]`，等效于`del numbers[:]`

方法是与对象(列表, 数, 字符串等)联系紧密的函数: `object.method(arguments)`

append 将**一个对象附加到列表末尾**，直接修改旧列表而不是返回新列表：`lst=[1,2,3]`;`list.append(4)`

clear 就地清空列表内容: `lst.clear()`, 类似于:`lst[:]=lst[]`

copy 复制列表, 常规复制(等号赋值方式)只是将一个名称关联到列表: `b=a.copy()`

count 计算指定元素在列表中出现次数: `x.count(1)`, 注意列表中含有的列表一起成为一个元素

extend 同时将多个值附加到列表末尾, append仅增加一个元素到末尾: `a.extedn(b)`,而采用加号(+)会返回一个新的列表,extend为直接修改原列表; 或采用切片方式直接赋值: `a[len(a):]=b`

index 在列表中查找指定值第一次出现的索引: `knights.index('who')`

Insert 用于将一个对象插入列表: `numbers.insert(3,'four')`, 在第3位置插入'four'; 或采用切片方式: `numbers[3:3]=['four']`

pop 从列表中删除一个元素(末尾为最后一个元素), 并返回这一元素: `x.pop(0)`, 默认删除最后一个元素。pop是唯一一个即修改列表又返回一个非None值的列表方法

**栈(stack),常见数据结构有先进先出(FIFO)或后进先出(LIFO)两种操作:`x.append(x.pop())`; `x.insert(0,x.pop(0))`**

remove 删除第一个为指定值的元素: `x.remove('be')`, 就地删除

reverse 按照相反顺序排列列表中的元素: `x.reverse()`, 就地修改

sort 对列表就地排序: `x.sort()`: `y=x.sort() # Dont do this!`

sorted 获得排序后列表的副本: `y=sorted(x)`, `y等与 x.sort()`; 列表x顺序不变, 该函数可适用于任何序列, 但总是返回一个列表: `sorted('Python'), ['P', 'h', 'n', 'o', 't', 'y']`

sort 高级排序，可接受两个可选参数: key, reverse，参数key类似于参数cmp：设置为一个用于排序的函数, 用该函数为每个元素创建一个键, 再根据键对元素进行排序, 例如根据元素长度排序: `x.sort(key=len)`; 而reverse, 只需指定为一True或False, 表明是否按照相反顺序排序: `x.sort(reverse=True)`; sorted也可接受参数key和reverse

* 元组: 不可修改的序列

元组语法简单，只需将一些值逗号分隔就自动创建一个元组:`>>>1,2,3; (1,2,3)`

通常使用圆括号括起: >>>`(1,2,3) ; (1,2,3)`;空元组使用不包含任何内容的圆括号表示: (); 仅包含一个值的元组:`42, ; (42,)`

`3 ( 40+2); 126`; `3 (40+2,); (42,42,42)`

tuple工作原理与list很像: 将一个序列作为参数，并转为元组，若参数本身就是元组，则原封不动返回:`tuple([1,2,3]); (1,2,3)`; `tuple('abc'); ('a','b','c')`; `tuple((1,2,3)); (1,2,3)`

元组也可采用切片方法，返回仍然是元组，一般列表足以满足对序列的需求。

* 设置字符串格式

对字符串调用format方法, 并提供要设置其格式的值, 每个值都被插入到字符串中，以替换用花括号括起来的替换字段, 要在作用结果中包含花括号，可在格式字符中使用两个花括号({{}})来指定: {替换部分}.format(格式部分)

按顺序将字段和参数配对, 还可以给参数指定名称:`"{foo} {} {bar} {}".format(1,2,bar=4,foo=3)`: `'3 1 4 2'`

通过索引指定要在哪个字段中使用相应的未命名参数, 可不按顺序使用未命名参数:`"{foo} {1} {bar} {0}".format(1,2,bar=4,foo=3)`: `'3 2 4 1'`

或采用访问组成部分的方法: `fullname=["Alfred", "Smoketoomuch"]`: `"Mr {name[1]}}".format(name=fullname)` `Mr Smoketoomuch`

使用转换标志设置格式指定: `print ("{pi!s} {pi!r} {pi!a}".format(pi="$\pi$")); $\pi$ '$\pi$' '\u03c0'`

s, r, a分别使用了str, repr和ascii进行转换; 函数str创建外观普通的字符串函数; repr函数创建给定值的python表示, 这里是一个字符串的字面量; ascii创建只包含ASCII字符的表示。

指定转换值的类型, 在冒号后加指定类型说明符: f浮点型;d十进制整数;e科学记数法表示小数(e表示指数); %将数表示为百分比值(乘以100, 在后面加上%)

设置浮点型时, 默认在小数点后面显示6位小数, 并根据需要设置字符的宽度, 而不进行任何形式的填充: `"{num:10}".format(num=3)`, `'.         3'`

`"{name:10}".format(name="Bob")`, `'Bob         '` **数和字符串的对齐方式不同**

精度的指定需要在它前面加上一个表示小数点的句号: `"Pi day is {pi:.2f}".format(pi=pi)`, `'Pi day is 3.14'`

使用逗号指出要添加千位分割符: `One googol is {:,}".format(10**100)"`, `'One googol is 10,000,....'`; 同时设置其他格式时, 逗号应放在宽度和表示精度的句点之间

在指定宽度和精度的数前面, 可添加一个标志, 可以是零, 加号, 减号或空格, 其中零表示使用0来填充数字:`'{:010.2f}'.format(pi)`, `'0000003.14'`

使用<, >和^表示左对齐, 右对齐和居中: `"{:$15}".format(" WIN BIG ")`, `'$$$ WIN BIG $$$'`, 总共为15个字符长度

更具体的说明符=, 它将指定填充字符放在符号和数字之间

若给正数加上符号, 可使用说明符+, 将其放在对齐说明符后面: `print('{0:+.2}\n{1:+.2}'.format(pi,-pi))`, `+3.1`, `-3.1`

* 字符串方法

模块string, 包含了一些字符串没有的常量和函数: sring.digits, 包含了数字0～9的字符串; string.ascii_letters, 包含了说有ASCII字母(大写和小写)的字符串; string.ascii_lowercase, 包含了所有小写ASCII字符的字符串; string.printable, 包含所有可以打印的ASCII字符的字符串

![image-20190818131001570](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g63r4rtumlj30v603imy7-20200925140935301-20200925140941987.jpg)

string.punctuation, 包含所有ASCII标点字符的字符串

![image-20190818131117245](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g63r62kwhjj30u801yaad.jpg)

方法center通过在两边添加填充字符(默认为空格)让字符串剧中: `"The Middle by Jimmy Eat World".format(39, "*")`, `'*****The Middle by Jimmy Eat World*****'`

方法find在字符串中查找子串, 返回第一个字符的索引, 否则返回-1: `title.find('Monty')`

同时可以指定搜索的起点和终点(可选选项): `subject.find('$$$',1,16)`, 对应起点和终点

join方法可以合并序列元素: `'+'.join(seq)`, 所有合并序列的元素必须都是字符串, 不能为数字: `'+'.join(seq=['1','2','3','4'])`

![image-20190818145122372](https://gitee.com/huizhen2014/Pic/raw/master/006tNc79gy1g63u2835ntj30um06kmy0.jpg)lower方法 返回字符串的小写版本; title方法返回字符串为词首大写, 或使用string中的capwords, 将词首转换为大写; upper方法返回字符串的大写版本

replace方法将指定子串都替换为另一个字符串, 并返回替换后的结果: `seq.replace('is', 'eez')`

split方法将字符串拆分为序列:`'1+2+3+4+5'.split('+')`, 若没有指定分隔符, 将默认在单个或多个连续的空白字符(空格, 制表符, 换行符等)处进行拆分, 返回list

strip 方法将字符串开头和末尾的空白(但不包含中间的空白)删除, 并返回删除后的结果: `seq.strip()`

同时还可以在一个字符串参数中指定要删除哪些字符: `'*** SPAM for everyone!!! ***'.strip(' *!')`, `'SPAM for everyone'` 该方法仅删除开头或末尾的指定字符

translate方法和replace一样替换字符串的特定部分,  但是不同的是它只能进行单字符替换, 该方法可以同时替换多个字符, 然而使用前必须创建一个转换表, 该表指出不同Unicode码点之间的转换关系

使用is开头的字符串方法用于判断字符串是否具有特定性质:isalnum, isalpha, isdecimal, isdigit, isidentifier, isspace, isupper

string.capwords(s[,seq]), 使用split根据sep拆分s, 将每项的首字母大写, 再以空格为分隔符将它们合并起来

ascii(obj)创建指定对象的ASCII表示

* 字典

该数据结构称为映射(mapping), 字典是python中唯一的内置映射类型, 其中的值不按顺序排列, 而是存储在键下, 键可能是数, 字符串或元组

字典由键及相应的值组成, 这种键-值对称为项(item), 每个键与其值之间都用冒号(:)分隔, 项之间用逗号分隔, 而整个字典都放在花括号内; 空字典(没有任何项)用两个花括号表示, 类似于:{}; 字典中键必须是独一无二的, 而字典中的值无需如此

函数dict可从其他映射(其他字典)或键-值对序列创建字典, 同list, tuple, str一样, dict不是函数, 而是一个类:`dict([('name','Gumby'),('age',42)])`

len(d)返回字典d中的项(键-值对)数

d[k]返回与键k相关联的值

d[k]=v将值v关联到键k

del d[k]删除键为k的项

k in d检查字典d是否包含键为k的项, 查找的是键而不是值; 而表达是v in l(l是一个列表)查找的是值而不是索引

将字符串格式设置功能用于字典, 可在字典中包含各种信息, 只需在格式字符串中提取所需的信息即可, 必须使用format_map来指处你将通过一个映射来提供所需的信息:`"Cecil's phone number is {Cecil}.".format_map(phonebook)`, phonebook为字典: `{'Beth':'9102', 'Alice':'2341', 'Cecil':'3258'}`

clear方法删除所有的字典项, 该操作就像list.sort一样, 就地执行: `d.clear()`,`d {}`

copy方法返回一个新字典, 其中包含的键-值对与原来的字典相同, 为浅复制, 当替换副本中值是，原件不受影响, 然而修改副本中的值, 原件也将发生变化, 因为原件指向的也就是被修改的值

可使用copy中的deepcopy函数, 执行深度复制: `dc.deepcopy(d)`

fromkeys方法创建一个新字典, 其中包含指定的键, 且每个键对应的值都是None: `'{}.fromkeys(['name','age'])'`, `{'age':None, 'name':None}`

或`dict.fromkeys(['name','age'])`

或使用特定值:`dict.fromkeys(['name','age'], '(unknown)')`

get方法用于访问字典, 一般试图访问字典中没有的项, 将引发错误, 而使用get访问不存在的键时, 不会引发异常, 而是返回None: `print(d.get('name'))`

或指定不存在键时, 返回特定值: `d.get('name', 'N/A')`

items方法返回一个包含所有字典项的列表, 其中每个元素都为(key, value)的形式, 返回值属于一种名为字典视图的特殊类型, 字典视图可用于迭代

或将字典项复制到列表中:`list(d.items())`

视图的一个优点是不复制, 它们始终是底层字典的反映, 即使你修改了底层字典亦是如此

![image-20190818195232451](http://ww3.sinaimg.cn/large/006tNc79ly1g642rl0we8j30ua050gmj.jpg)

keys方法返回一个字典视图, 其中包含指定字典中的键

values方法返回一个由字典中的值组成的字典视图, 不同与keys, values返回的视图可能包含重复的值

pop方法用于获取与指定键相关联的值, 并将该键-值对从字典中删除

popitem方法类似于list.pop, list.pop弹出列表中的最后一个元素, 而popitem随机地弹出一个字典项, 因为字典项的顺序是不确定的, 没有'最后一个元素'的概念

setdefault方法类似get, 也获得与指定键相关联的值, 此外, setdefault还在字典不包含指定的键时, 在字典中添加指定的键-值对:`d={}`,`d.setdefault('name','N/A')`,`'N/A'`

update方法使用字典中的项来更新另一个字典:`d.update(x)`, 通过参数提供的字典, 将其项添加到当前字典中, 若当前字典包含键相同的项, 就替换它

* import及赋值

导入函数别名: `from match import sort as foobar`, 本地重命名函数

并行给多个变量赋值:`x,y,z=1,2,3`, `print(x,y,z)`,`1 2 3`

使用星号\*来收集多余的值, 确保值和变量的个数相同: `a,b,\*rest=[1,2,3,4], rest=[3,4]`, 也可将星号\*放到其他位置收集, \*指定的变量为列表

链式复制:`x=y=somefunction()`

增强复制:`x+=1`, `x*=2`, 也可针对字符串

* 条件和条件语句

条件语句视为假:`False None 0 '' () [] {}`, 其他值都为真, 包括特殊值True

![image-20190818201724093](http://ww2.sinaimg.cn/large/006tNc79ly1g643hgfemwj30ui07e74s.jpg)

条件表达式:`status='friend' if name.endwith('Gumy') else 'stranger'`, 若为真提供friend, 若为假提供stranger

elif用于if循环检查多个条件

python比较运算符

![image-20190818202102343](http://ww2.sinaimg.cn/large/006tNc79ly1g643l80wtij30us0h0did.jpg)

is, 相同运算符, 看似与==一样, 不同在于检查两个对象是否相同, 而不是相等

运算符in用于成员资格检查

字符串的比较时根据字符的字母排列顺序进行比较的

![image-20190818202941851](http://ww3.sinaimg.cn/large/006tNc79ly1g643u95tnaj30t606edgf.jpg)

and布尔运算符接受两个真值, 且都为真时返回真;or表满足一个即可;not表示非

asser断言,可在不满足条件时退出:`assert 0 < age < 100`, 充当程序的检查点

也可在条件后面添加一个字符串, 对断言做出说明:`assert 0 < age <100, 'The age must be realistic'`

* 循环

while/for:`while x < =100:print(x)`,`x+=1`, `for word in words:print(word)`

range函数创建范围的内置函数:`list(range(0,10))`, 范围类似切片, 包含其实位置 (这里是0), 但是不包含结束位置(这里为10):`[0,1,2,3,4,5,6,7,8,9]`

遍历字典所有关键字:`for key in d:print(key, 'corresponds to', d[key])`

或使用序列解包:`for key, value in d.items():print(key, 'corresponds to', value)`

* 迭代

函数zip将连个序列'缝合'起来, 并返回一个由元组组成的序列, 返回值是一个适合迭代的对象, 要查看其内容, 可使用list将其转换为列表:

![image-20190818205109522](http://ww3.sinaimg.cn/large/006tNc79ly1g644gknwuyj30x802gjrs.jpg)

zip缝合后可在循环中将元组解包:

![image-20190818205446764](http://ww3.sinaimg.cn/large/006tNc79ly1g644kceilaj30ui08ggnj.jpg)

函数zip可用于'缝合'任意数量的序列, 当序列长度不一致时, 函数zip将在最短的序列用完后停止'缝合'

![image-20190818205632210](http://ww1.sinaimg.cn/large/006tNc79ly1g644m5shk2j30v202474p.jpg)

使用index一次查询字符'xxx'位置且替换:

![image-20190818210005285](https://raw.githubusercontent.com/huizhen2014/Pic/master/006tNc79ly1g644pvkjsyj30vc0523z1.jpg)

或使用内置函数enumerate:

![image-20190818210100763](https://raw.githubusercontent.com/huizhen2014/Pic/master/006tNc79ly1g644qtk9hnj30x20400t6.jpg)

enumerate能够迭代返回索引-值对, 其中索引是自动提供的

reversed/sorted, 不就地修改对象, 而是返回反排和排序后的版本, sorted返回一个列表, 而reversed像zip那样返回一个可迭代对象, 若使用索引或切片操作, 需先使用list对返回对象转换

![image-20190818210742765](http://ww1.sinaimg.cn/large/006tNc79ly1g644xsgomhj30ww08umyl.jpg)

例如:

![image-20190818210917618](http://ww1.sinaimg.cn/large/006tNc79ly1g644zgc4foj30va0g8acq.jpg)

要对字母排序, 可先转换为小写, 为此可讲sorted的key参数设置为str.lower:`sorted('aBc', key=str.lower)`

* 跳出循环

break结束(跳出)循环; continue结束当前迭代,并跳到下一次迭代开头, 这意味着跳过循环体中余下的语句, 但是不结束循环

![image-20190818211328710](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820202354662.png)

或:

![image-20190818211402963](http://ww2.sinaimg.cn/large/006tNc79ly1g6454fzruej30we06a0tk.jpg) 

* 简单推导

列表推导是一种从其他列表创建列表的方式, 类似于数学中的集合推导, 工作原理简单, 类似于for循环:`[x*x for x in range(10)]`, `[0,1,4,9,16,25,36,49,64,81]`

或加入条件判断:`[x*x for x in range(10) if x % 3 ==0]`,`[0,9,36,81]`

或更多for部分:

![image-20190818211943255](http://ww4.sinaimg.cn/large/006tNc79ly1g645aadxn4j30zc02g3ys.jpg)

等同于两个for循环构建同样列表:

![image-20190818212052787](http://ww3.sinaimg.cn/large/006tNc79ly1g645bi6ckij30zi04ojrx.jpg)

构建男孩/女孩名称配对:

![image-20190818212651658](http://ww4.sinaimg.cn/large/006tNc79ly1g645hpx08oj30xc06g3zl.jpg)

这里使用圆括号代替方括号并不能实现元组推导

使用花括号执行字典推导:

![image-20190818212829796](http://ww4.sinaimg.cn/large/006tNc79ly1g645jgl5eoj30zo03sgm5.jpg)

pass语句什么也不做;del删除语句

exec将字符串作为代码执行, 加入命名空间:

![image-20190818213254066](http://ww3.sinaimg.cn/large/006tNc79ly1g645o0wbt1j30wy072q3p.jpg)

chr(n), 返回一个字符串, 其中只包含一个字符, 这个字符对应于传入的顺序值n(0<=n<=256)

ord(c), 接受一个只包含一个字符的字符串, 并返回这个字符的顺序值(一个整数)

range([start],stop[,step]), 创建一个用于迭代的range对象list(range())

zip(seq1,seq2,...), 创建一个使用于并行迭代的新序列

* 计算斐波那契数列

`fibs=[0,1]`

`for i in range(8):`

​	`		fibs.append(fibs[-2]+fibs[-1])`

* 自定义函数

内置函数callable, 判断否个对象是否可调用

在def语句后面(以及模块和类的开头)添加注释字符串, 放在函数开头的字符串称为文档字符串, docstring, 将作为函数的一部分储存起来:

![image-20190820193229116](http://ww2.sinaimg.cn/large/006tNc79gy1g66dfccn58j30us05qgmj.jpg)

内置函数help可获得有关函数的信息:

![image-20190820193330839](https://gitee.com/huizhen2014/Pic/raw/master/image-20190818211328710.png)

函数中return后可不接内容, 表示结束函数; 函数内部给参数赋值对外部没有任何影响, 函数存在局部作用域中

字符串(以及数和元组)是不可变的(immutable), 这意味着不可能修改它们(即只能替换为新值); 而对于可变的数据结构(如列表), 会存在修改了变量关联到的列表, 因此会改变对应关联列表的值

![image-20190820194442555](http://ww3.sinaimg.cn/large/006tNc79gy1g66ds62tmbj30uk054q3j.jpg)

将同一个列表赋给两个变量时, 这两个变量将同时指向这个列表; 若要避免这样结果, 必须创建列表的副本, 对序列执行切片操作时, 返回的切片都是副本

函数参数赋值时指定参数的名称以便忽略调用时根据参数位置调用, 此类关键字参数最大优点在于可以指定默认值

`hello_1(name='world',greeting='Hello')`

* 收集参数

参数前带一星号表示收集余下的位置参数为元组: `def print_params(title,*params)`; 若没有可供收集的参数, params将是一个空元组

可使用两个星号收集关键字参数: `def print_params(**params)`; 这样得到的是一个字典而不是元组, 此时参数为字典形式: `x=1, y=2, c=3...`

* 分配参数

元组：

![image-20190820202452468](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820202452468.png)

字典：

![image-20190820202354662](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820193330839.png)

* 作用域

变量为指向值的名称, 执行赋值语句x=1后, 名称x指向值1, 这几乎与使用字典时一样(字典中的键指向值), 内置函数vars可返回这个不可见的字典

**可在函数中读取全局变量的值, 但是不能修改函数作用域外的全局变量值; 若有一局部变量或参数与想要访问的全局变量同名, 就无法访问全局变量了, 因为它被局部变量遮住了; 可使用函数globals来访问全局变量, 该函数类似于vars, 返回一个包含全局变量的字典, 而locals返回一个包含局部变量的字典**

在函数中访问同名全局变量: `def combine(paramter): print(parameter + globals()['paramter'])`

可在函数内部给变量赋值时指明该默认局部变量为全局变量: `def change_global():global x`

* 作用域嵌套

python函数可以嵌套, 即将一个函数放在另一个函数内, 例如一个函数位于另一函数中, 且外面函数返回里面的函数:

![image-20190820205216104](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820205216104.png)

此类multiplyByFactor这样存储其所在的作用域的函数称为闭包, 通常不能给外部作用域内的变量赋值, 但如果一定要这样做, 可能使用关键字nonlocal, 能够给外部作用域(非全局作用域)内的变量赋值

* 递归

递归函数包含: 基线条件(针对最小的问题), 满足这种条件时函数将直接返回一个值; 递归条件: 包含一个或多个调用, 这些调用旨在解决问题的一部分. 问题最终被分解成基线条件可以解决的最小问题

阶乘：

![image-20190820210433951](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820210433951.png)

二分查找：

![image-20190820210456592](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820211851981.png)

**模块bisect提供了标准的二分查找实现**

* 列表推导式

函数map使用每次迭代的参数计算函数: `list(map(str,range(10))`等同于`list(str(i) for i in range(10))`

函数filter根据布尔函数的返回值对元素进行过滤:

![image-20190820211851981](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820210456592.png)

等同于`[x for x in seq if x.isalnum()]`

lambda表达式用于创建内嵌的简单函数(主要供map,filter使用):`filter(lambda x:x.isalnum(),seq)`

reduce函数针对序列项采用累增的方式, 从左到右依次减少序列直至单个值

`reduce(lambda x,y:x+y, [1,2,3,4,5])`等同`((((1+2)+3)+4)+5)`

![image-20190820212228032](https://gitee.com/huizhen2014/Pic/raw/master/image-20190820212228032.png)

lambda源于希腊字母, 在数学中用于表示匿名函数

apply(func[,args[,kwargs]]): 调用函数(还提供要传递给函数的参数)

* 创建对象类型或类

与对象属性相关联的函数称为方法: `'abc'.count('a')`, 1

多态形式式python编程方式的和兴, 有时称为鸭子类型. 该术语源自如下说法: '如果走起来像鸭子, 叫起来像鸭子, 那么它就是鸭子'

* 封装(encapsulation)

封装指的是向外部隐藏不必要的细节, 不同与多态, 多态让你无需知道对象所属的类(对象的类型)就能调用其方法, 而封装让你无需知道对象的构造就能使用它(通过它的方法)

* 继承

类是一种对象, 每个对象都属于特定的类, 并被称为该类的实例, 例如云雀为鸟类的子类, 鸟类为云雀的超类; 英语日常交谈中, 使用复数来表示类, 如birds, larks(云雀), 在python中约定使用单数并将首字母大写, Birds/Lark, 表示类

**类由其所支持的方法定义的, 类的所有实例(s=Filter())都有该类的所有方法, 因此子类的所有实例都有超类的所有方法, 要定义子类, 只需定义多出来的方法**

* 常见自定义类

![image-20190821131458757](http://ww4.sinaimg.cn/large/006y8mN6gy1g6784vkpwaj30pq084t9f.jpg)

**该例子定义了三个方法, 类似函数定义. 参数self指定对象本身, self很有用, 甚至必不可少, 若是没有它, 所有方法都无法访问对象本身---要操作的属性所属的对象, 当然也无法从外部访问这些属性**

方法和函数的区别表现在参数self上

若让类的方法或属性称为私有的(不能通过方法从外部访问), 只需让其名称以两个下划线开头即可

![image-20190821133311625](http://ww2.sinaimg.cn/large/006y8mN6gy1g678ns6w2aj30tc06cwfl.jpg)

这样, 从外部不能访问`__inaccessible`, 但是在类中, `accesssible`依然可以使用

对于私有方法/属性, 可以通过开头加一个下划线和类名的方式访问:

![image-20190821133243635](http://ww4.sinaimg.cn/large/006y8mN6gy1g678nag6u7j30um07eabp.jpg)

在class语句中定义的代码都是在一个特殊的命名空间(类的命名空间)内执行的, 而类的所有成员都可以访问这个命名空间; 类定义其实就是要执行的代码段, 因此在类的定义中, 并非只能包含def语句

![image-20190821134350407](http://ww4.sinaimg.cn/large/006y8mN6gy1g678yun6fgj30uw04kjrw.jpg)

**该类每次调用都会使用init来初始化所有实例**

要指定超类, 可在class语句中的类名后加上超类名, 并将其用圆括号括起来

![image-20190821135153930](http://ww4.sinaimg.cn/large/006y8mN6gy1g67978uto9j30uo0e4gnl.jpg)

重写了Filter类中的方法init的定义; 直接从Filter类继承了方法filter的定义, 因此无需重新编写其他定义

![image-20190821135309772](http://ww3.sinaimg.cn/large/006y8mN6gy1g6798jz4x8j30ug026t91.jpg)

函数issubclass用于判断一个类是否是另一个类的子类:`issubclass(SPAMFilter, Filter)`

查看一个类是否含有基类, 访问其特殊属性\_\_base\_\_:`SPAMFilter.__base__	`

![image-20190821135625178](http://ww4.sinaimg.cn/large/006y8mN6gy1g679bxpmqfj30v0022q33.jpg)

使用函数isinstance判断对象是否是特定类的实例:

![image-20190821135814389](http://ww3.sinaimg.cn/large/006y8mN6gy1g679dtysjzj30u606mq3q.jpg)

**查看对象所属的类, 可使用属性\_\_class\_\_:`s.__class__`**

![image-20190821140018081](http://ww3.sinaimg.cn/large/006y8mN6gy1g679fzbqaij30ua01ywem.jpg)

**还可以使用tepe(s)获悉其所属的类:`type(s)`**

* 多个超类

![image-20190821232842438](http://ww2.sinaimg.cn/large/006y8mN6ly1g67pveuh5xj30ue0e8tb7.jpg)

子类TalkingCalculator本身无所作为, 其所有的行为都是从超类继承的; 从Calculator继承了calculate, 并从Talker继承talk

多个超类使用复数形式的`__bases__`:

![image-20190821233150759](http://ww2.sinaimg.cn/large/006y8mN6ly1g67pynxw1cj30ve03wwfd.jpg)

**若多个超类以不同的方式实现了同一个方法(即有多个同名方法), 必须在class语句中小心排列这些超类, 因为位于前面的类的方法将覆盖位于后面的类的方法**

* 接口和内省

接口这一概念与多态相关, 处理多态对象是, 只关心其接口(协议)-对外暴露的方法和属性; 在pyhton中, 不显示地指定对象必须包含哪些方法才能作用参数

hasattr函数用于检查所需方法是否存在:`hasattr(tc, 'talk')`

callable/getattr(指定属性不存在是使用默认值, 这里为None)函数用于检查属性是否可调用:`callable(getattr(tc,'talk',None))`

setattr与getattr功能相反, 可用于设置对象的属性:

![image-20190821234328813](http://ww3.sinaimg.cn/large/006y8mN6ly1g67qas0b9kj30tu02y0t0.jpg)

要查看对象中存储的所有值, 可检查其`__dict__`属性

![image-20190821234439165](http://ww2.sinaimg.cn/large/006y8mN6ly1g67qbzqr41j30tk02674f.jpg)

* 抽象基类

P229略

小结：

![image-20190821235209060](http://ww1.sinaimg.cn/large/006y8mN6ly1g67qjsstdmj30yq0okqel.jpg)

* 异常处理

事实上, 每个异常都是每个类的实例, 可通过各种方法引发和捕获这些实例, 从而逮住错误并采取措施, 而不是放任整个程序失败

raise语句将一个类(必须是Exception的子类)或实例作为参数; 将类作为参数时, 将自动创建一个实例`raise Exception`通用异常; `raise Exception('hyperdrive overload')`指定错误消息‘hyperdrive overload'

python库参考手册的'Built-in Exceptions', 描述了所有内置异常类, 都可用于raise语句:`raise ArtithmeticError`

创建异常类, 务必直接或间接地继承Exception(这意味着从任何内置异常类派生都可以): `class SomeCustomException(Exception):pass`

* 捕获异常

使用try/except语句捕获异常

![image-20190822214941042](http://ww2.sinaimg.cn/large/006y8mN6gy1g68smpxvfmj30uy064t9s.jpg)

若异常捕获后, 要重新引发它(即继续向上传播), 可调用raise且不提供任何参数

如果无法处理异常, 在except子句中使用不带参数的raise通常是不错的选择, 但有时你可能想引发别的异常; 在这种情况下, 导致进入except子句的异常将作为异常上下文存储起来, 并出现在最终的错误消息中

可使用raise...from...语句来提供自己的异常上下文, 也可使用None来禁用上下文

![image-20190825225550152](https://tva1.sinaimg.cn/large/006y8mN6ly1g6cbefx7bnj30ts07m0tr.jpg)

可在try/except语句中添加多个except子句, 捕获多种错误, 或使用元组指定异常: `except (ZeroDivisionError, TypeError, NameError)`; 若except子句没有提供错误或异常的名称, 它将处理所有错误与异常

在没有异常时执行一个代码很有用, 为此, 可像条件语句和循环一样, 给try/except语句添加一个else子句

![image-20190825230150334](https://tva1.sinaimg.cn/large/006y8mN6ly1g6cbkngcr1j30tw08imya.jpg)

最后, 使用finally子句可用在发生异常时执行清理工作, 与try子句配套

![image-20190825230458793](https://tva1.sinaimg.cn/large/006y8mN6ly1g6cbnx016rj30v20a2dh6.jpg)

因此, 不管try子句中发生了什么异常, 都将执行finally子句

异常处理并不是很复杂, 如果你知道代码可能引发某种异常, 且不希望出现这种异常时程序终止并显示栈跟踪消息, 可添加必要的try/except或try/finally语句(或结合使用)来处理它

**关键是很多情况下, 相比于使用if/else, 使用try/except语句更自然, 也更符合python的风格, 因此你应该尽可能使用try/except语句的习惯, P253异常之蝉**

**python偏向使用try/except的原因, 这种策略可总结为习语'闭眼就跳'---直接去做, 有问题再处理, 而不是预先做大量的检查**

* 魔法方法/特征/迭代器

创建构造函数, 只需将方法init的名称从普通的init改为魔法版\_\_init\_\_即可, 这样以来调用不用init了, 直接完成init:`f=FooBar()`; `f.init()`, 仅需`f=FooBar()`即可

![image-20190827224103073](https://gitee.com/huizhen2014/Pic/raw/master/image-20190827224214240.png)

修改init为\_\_init\_\_

![image-20190827224214240](https://gitee.com/huizhen2014/Pic/raw/master/image-20190827224103073.png)

重写是继承机制的一个重要方面, 对构造函数来说尤其重要; 但是与重写普通方法相比, 重写构造函数时更有可能遇到一个特别的问题: 重写构造函数时, 必须调用超类(继承的类)的构造函数, 否则可能无法正确地初始化对象

使用super函数调用超类的构造函数:

超类:

![image-20190827225124333](https://gitee.com/huizhen2014/Pic/raw/master/image-20190827225124333.png)

重写构造函数super:

![image-20190827225157736](https://gitee.com/huizhen2014/Pic/raw/master/image-20190827225157736.png)

函数super很聪明, 因此即便有多个超类, 也只需调用函数super一次

* 基本到序列和映射协议

序列和映射基本上是元素(item)的集合, 要实现它们的基本行为(协议), 不可变对象需实现2个方法, 而可变对象需要实现4个

`__len__(self)`: 这个方法应返回集合包含的项数, 对序列来说为元素个数, 对映射来说为键-值对数, 如果`__len__`返回零, 对象在布尔上下文中将被视为假(就像空的列表, 元组, 字符串和字典一样)

`__getitem__(self,key)`: 这个方法应返回与指定键相关联的值

`__setitem__(self, key, value)`: 这个方法应以与键相关联的方式存储值, 以便以后能够使用`__getitem__`来获取, 仅当对象可变时才需要实现这个方法

`__delitem__(self, key)`: 该方法在对对象的组成部分使用`__del__`语句时被调用, 应删除与key相关联的值

**对于序列, 如果键为负值, 从末尾往前数: x[-n] == x[len(x)-n]**

**若键类型不合适, 可能引发TypeError异常; 对于序列, 如果索引的类型正确的, 但不在允许的范围内, 应引发IndexError异常**

**使用`super().__init__(args)`继承list，使用list所有内置函数**

* 特性

![image-20190915234459350](https://tva1.sinaimg.cn/large/006y8mN6ly1g70mu3egu5j311807s75l.jpg)

get_size和set_size是假想属性size的存取方法, 这个属性是一个width和height组成的元组; 若想使size成为真正的属性: 使用函数property

![image-20190915234957368](https://tva1.sinaimg.cn/large/006y8mN6ly1g70mz7wjsuj311409edhg.jpg)

在此新版的Rectangle中, 通过调用函数property并将存取方法作为参数(获取方法在前, 设置方法在后)创建了一个特性, 然后将名称size关联到这个特性。

![image-20190915235356911](https://tva1.sinaimg.cn/large/006y8mN6ly1g70n3djtbxj30yo06m3z4.jpg)

实际上, 调用函数property时, 还可以不指定参数，指定一个参数或三或四个参数。

![image-20190915235908380](https://tva1.sinaimg.cn/large/006y8mN6ly1g70n8rzmmnj311g0cctb3.jpg)

property其实并不是函数, 而是一个类. 它的实例包含一些魔法方法, 而所有的魔法都是由这些方法完成的. 这些魔法方法为`__get__`,`__set__`,`__delete__`, 它们一道定义了所谓的描述符协议。p277

* 静态方法和类方法 

略

* 迭代器

迭代(iterate)意味着重复多次, 就像循环那样. 方法`__iter__`返回一个迭代器, 它是包含方法`__next__`的对象, 而调用这个方法时可不提供任何参数. 当你调用方法`__next__`时, 迭代器应返回其下一个值. 如果迭代器没有可供返回的值, 应引发StopIteration异常. 可使用内置的便利函数next, 此时, next(it)与`it.__next__()`等效.

![image-20190916233847850](https://tva1.sinaimg.cn/large/006y8mN6ly1g71s9xgsjmj30y60920tv.jpg)

可通过可迭代对象调用内置函数iter, 可获得一个可迭代器:

![image-20190916234312481](https://tva1.sinaimg.cn/large/006y8mN6ly1g71seiaep5j30xe06oaar.jpg)

使用构造函数list显示地将迭代器转换为列表:

![image-20190916234559648](https://tva1.sinaimg.cn/large/006y8mN6ly1g71sheo4t8j311e0bagna.jpg)

* 简单生成器

![image-20190916234848887](https://tva1.sinaimg.cn/large/006y8mN6ly1g71skchtpfj30u804qaas.jpg)

其工作原理与列表推导相同, 但不是创建一个列表(即不立即执行循环), 而是返回一个生成器, 让你能够逐步执行计算. 不同与列表推导式, 这里使用的是圆括号.

![image-20190916235134728](https://tva1.sinaimg.cn/large/006y8mN6ly1g71sn7zmhyj315u04cjsn.jpg)

或在一对既有圆括号内(如在函数调用中)使用生成器推导, 无需再添加一对圆括号(如上).

* 递归生成器

使用两个for循环可实现两层嵌套列表, 处理任意层嵌套列表, 使用递归:

![image-20190916235653306](https://tva1.sinaimg.cn/large/006y8mN6ly1g71ssqy9odj310207qwfl.jpg)

处理递归时存在两种情况: 基线条件和递归条件, 上式中, 基线情况下展开一个单元, 若为单个元素, 将引发TypeError异常.

![image-20190916235926911](https://tva1.sinaimg.cn/large/006y8mN6ly1g71svefp3oj30y00200t0.jpg)

这里若nested是字符穿或类似字符串对象, 属于序列, 不会引发TypeError异常. 因此, 可在开头尝试将其与一个字符串拼接检查:

![image-20190917000126858](https://tva1.sinaimg.cn/large/006y8mN6ly1g71sxhhpa5j310q0demz8.jpg)

* 通用生成器

生成器是包含了关键字yield的函数, 但被调用时不会执行函数体内的代码, 而是返回一个迭代器, 每次请求值, 都将执行生成器的代码, 直到遇到yield或return. **yield意味着应生成一个值, 而return意味着生成器停止执行(即不再生成值, 仅当在生成器调用return时, 才能不提供任何参数).**

生成器由两个单独部分组成: 生成器的函数和生成器的迭代器. 生成器的函数由def语句定义, 其中包含yield. 生成器的迭代器就是这个函数返回的结果.

外部世界可访问生成器的方法send, 类似于next, 但接受一个参数.

注意: 如果要以某种形式返回值, 就不管三七二十一, 将其用圆括号括起来.

方法throw: 用于在生成器中(yield表达式处)引发异常, 调用时提供一个异常类型, 一个可选值和一个traceback对象

方法close: 用于停止生成器,调用时无需提供任何参数.

* 八皇后问题

状态表示: 使用元组(或列表)来表示可能的解(或其一部分), 其中每个元素表示相应中皇后的所在位置(即列). 例如: state[0]==3, 表示第1行的皇后放置在第4列(从0计算).

检测冲突: 函数conflict接受既有的皇后位置, 并确定下一个皇后的位置是否冲突:

p296????

总结:

* 构造函数: 很多面向对象语言中都有构造函数, 对于你自己编写的每个类, 都可能需要为它实现一个构建函数. 构建函数名为`_init_`, 在对象构建后被自动调用.
* 迭代器: 简单地说, 迭代器是包含方法`_next_`的对象, 可用于迭代一组值. 没有更多的值可供迭代时, 方法`_iter_`, 它返回一个像序列一样可用于for循环中的迭代器. 通常, 迭代器也是可迭代的, 即包含返回迭代器本身的方法`_iter_`.
* 生成器: 生成器的函数是包含关键字yield的函数, 它在被调用时返回一个生成器, 即一种特殊的迭代器. 要与活动的生成器交互, 可使用方法send, throw和close.

`iter(obj)`: 从可迭代对象创建一个迭代器

`next(it)`: 让迭代器前进一步并返回下一个元素

`property(fget, fset, fdel, doc)`: 返回一个特性; 所有参数都是可选的

`super(class, obj)`: 返回一个超类的关联实例

* 模块就是程序

创建简单模块hello.py: `print("Hello, world!")`

`import sys`; `sys.path.append("/dir/to/hello.py")`

`import hello`: Hello, world!

发现模块hello.py所在目录会出现一个名为`_pycache_`的子目录, 包含处理后的文件, Python能够更高效地处理它们. 重复导入不会执行代码, 因为模块不是用来执行操作的, 而是定义变量, 函数, 类等. 鉴于定义只需做一次, 因此导入模块多次和导入一次的效果相同.

若一定要重新加载模块, 可使用模块importlib中的函数reload, 接受一个参数(需要重新加载的模块), 并返回重新加载的模块:

`import importlib`

`hello=importlib.reload(hello)`: Hello, world!

* 模块使用来下定义的

在模块中定义函数, 像处理模块那样, 让程序可用后, 可使用`python -m progname args`, 使用命令行参数args来执行程序progname

![image-20200216213257410](https://tva1.sinaimg.cn/large/0082zybpgy1gbykg53gtfj31a004cdgd.jpg)

![image-20200216213312729](https://tva1.sinaimg.cn/large/0082zybpgy1gbykgebkc6j30zy02u74u.jpg)

可在模块中加入测试代码, 例如在`def hello():...`后加上`hello()`, 那么在`import`时, 若正确就会执行`hello()`. 但这不是一个好的结果, 若要避免, **关键是检查模块是否作为程序运行还是导入另一个程序**. 为此, 使用变量`__name__`

![image-20200216213917276](https://tva1.sinaimg.cn/large/0082zybpgy1gbykmq240yj30zm04caaa.jpg)

**在主程序(包括解释器的交互式提示符), 变量`__name__`的值为`__main__`; 而在导入的模块中, 该值被设置为该模块的名称.**

![image-20200216214559910](https://tva1.sinaimg.cn/large/0082zybpgy1gbyktqvggcj30zm07ugm1.jpg)

![image-20200216214630501](https://tva1.sinaimg.cn/large/0082zybpgy1gbyku8ltvgj30zq05qmyh.jpg)

如果将该模块当程序运行, 将执行函数hello(), 若导入它, 则像其他普通模块一样; 同时使用了`if`函数, 可通过`hello4.test()`独立测试.

* 让模块可用

根据模块目录`sys.path`将模块放在正确的位置:

![image-20200216215031814](https://tva1.sinaimg.cn/large/0082zybpgy1gbykyf0atnj311i0aajus.jpg)

告诉解释器到哪里去查找

`export PYTHONPATH=$PYTHONPATH:~/python`

* 包

为组织模块, 可将其编组为包(package). 包其实就是另一种模块, 但有趣的是他们可包含其他模块. 模块存储在扩展名为`.py`的文件中, **而包则是一个目录. 要被python视为包, 目录必须包含文件`__init__.py`.  如果像普通模块一样导入包, 文件`__init__.py`的内容就将是包的内容.** 例如

![image-20200216220050204](https://raw.githubusercontent.com/huizhen2014/Pic/master/0082zybpgy1gbyl958m8kj311m04et97.jpg)

那么, 若要将模块加入包中, 只需将模块文件放在包的目录中即可:

![image-20200216220946319](https://tva1.sinaimg.cn/large/0082zybpgy1gbylig43maj311s064dhc.jpg)

仅导入`constants`时, 仅能使用`___init__.py`中的值, 不能使用模块`hello2.py`, 需单独导入.

* 模块包含什么

要查明模块包含哪些东西, 可使用函数`dir`, 它列出对象的所属性(对于模块, 它列出所有的函数, 类, 变量等).  在这些名称中, 有几个以下划线打头, 根据约定, 这意味着它们并非供外部使用.

![image-20200217094806810](https://tva1.sinaimg.cn/large/0082zybpgy1gbz5p1wbrmj31d606w405.jpg)

`dir(copy)`返回清单中包含`__all__`, 为模块内部设置, 避免模块包含大量其他程序不需要变量, 函数和类, 若不设置`__all__` , 则会在`from copy import *`导入所有不以下划线打头的全局名称.

* 使用help获得帮助

`help(copy.copy)`/`help(copy)`

`__doc__`模块文档字符串就是函数开头编写的字符串, 用于对函数进行说明, 而函数的属性`__doc__`可能包含这个字符串, 同时, 模块也可能有文档字符穿(位于模块的开头), 而类也可能如此(位于类的开头).

![image-20200217191159179](https://tva1.sinaimg.cn/large/0082zybpgy1gbzlzrqauhj311w04smxu.jpg)

![image-20200217094630920](https://tva1.sinaimg.cn/large/0082zybpgy1gbz5neis8dj31be0463z1.jpg)

**`deepcopy(x)`创建x的属性的副本并依次类推; 而`copy(x)`只复制x, 并将副本的属性关联到x的属性值**

* 使用源代码

但要真正理解python语言, 可能需要了解一些不阅读源代码就无法了解的事情, 事实上, 要学习python, 阅读源代码时除手动编写代码外的最佳方式

![image-20200217095550216](https://tva1.sinaimg.cn/large/0082zybpgy1gbz5x39ihdj31c802mq3d.jpg)

* 标准库

**模块sys**

`argv`: 命令行参数, 包括脚本名

`exit([arg])`: 退出当前程序, 可通过可选参数指定返回值或错误消息

`modules`: 一个字典, 将模块名映射到加载的模块

`path`: 一个列表, 包含要在其中查找模块的目录的名称

`stdin`: 标准输入流, 一个类似于文件的对象

`stdout`: 标准输出流, 一个类似于文件的对象

`stderr`: 标准错误流, 一个类似于文件的对象

**模块os, 可用于访问多个操作系统服务, 除此之外, os及其子模块os.path还包含多个查看, 创建和删除目录及文件的函数,  以及一些操作路径的函数(例如, os.path.split/os.path.join让你在大多数情况下都可以忽略os.pathsep)**

`environ`: 包含环境变量的映射

`system(command)`: 在子shell中执行操作系统命令

`sep`: 路径中使用的分隔符

`pathsep`: 分隔不同路径的分隔符

`linesep`: 行分隔符('\n', '\r'或'\r\n')

**模块time**

元组(2008,1,21,12,2,56,0,21,0)表示2008年1月21日12时2分56秒, 星期一, 2008年的第21天(不考虑夏令时)

**python日期元祖中的字段(索引从0开始): 年, 月, 日, 时, 分, 秒(0-61), 星期(0-6), 儒略日(1-366), 夏令时(0/1/-1)**

模块time中的重要函数

`asctime([tuple])`: 将时间元组转换为字符串

`localtime([secs])`: 将秒数转换表示为当地时间的日期元组

`mktime(tuple)`: 将时间元组转换为当地时间

`sleep(secs)`: 休眠(什么都不做)secs秒

`strptime(string[, format])`: 将字符串转换为时间元组

`time()`: 当前时间(从新纪元开始后的秒数, 以UTC为准)

![image-20200217133155323](https://tva1.sinaimg.cn/large/0082zybpgy1gbzc5xryrnj311q08e40q.jpg)

**模块random**包含生成伪随机数的函数(其背后的系统时可预测的), 有助于编写模拟程序或生成随机输出的程序. 若要求真正的随机, 考虑使用模块os中的函数urandom.

`random()`: 返回一个0-1(含)的随机实数

`getrandbits(n)`: 以长整数方式返回n个随机的二进制位

`uniform(a,b)`: 返回一个a-b(含)的随机实数

`randrange([start],stop,[strp])`: 从range(start,stop,step)中随机地选择一个数

`choice(seq)`: 从序列seq中随机地选择一个元素

`shuffle(seq[, random])`: 就地打乱序列seq

`sample(seq,n)`: 从序列seq中随机地选择n个值不同的元素

![image-20200217182430401](https://tva1.sinaimg.cn/large/0082zybpgy1gbzkmdb8v2j310w08stal.jpg)

![image-20200217183352260](https://tva1.sinaimg.cn/large/0082zybpgy1gbzkw40drcj314i042my2.jpg)

`shuffle(deck)`; `while deck:input(deck.pop())`

* 集合, 堆和双端队列

以前集合是由模块sets中的Set类实现的, 较新的版本中, 集合是由内置类set实现, 可直接创建集合, 无需导入模块sets

![image-20200217105009545](https://tva1.sinaimg.cn/large/0082zybpgy1gbz7hm7gvdj310q05kzl7.jpg)

集合主要用于成员资格检查, 因此将忽略重复的元素, 与字典一样, 集合中元素的排列顺序是不确定的. 集合可用于各种标准集合操作, 如并集和交集, 为此可使用对整数执行按位操作的运算符(参考附录B)

![image-20200217105303113](https://tva1.sinaimg.cn/large/0082zybpgy1gbz7kmexxfj310w05uaao.jpg)

计算两个集合的并集的函数时, 可使用set中方法union的未关联版本, 搭配reduce使用(**接受的参数和map类似, 一个函数f, 一个list, 但是行为和map不同, reduce传入的函数f必须接受两个参数, reduce对list的每个元素反复调用函数f, 并返回最终结果值; map每次调用函数后, 返回包含返回值的列表, py2为列表, py3为迭代器**):

![image-20200217111130427](https://tva1.sinaimg.cn/large/0082zybpgy1gbz83u3b91j311k06s75p.jpg)

![image-20200217112343143](https://tva1.sinaimg.cn/large/0082zybpgy1gbz8gjknd1j311i0cwdhq.jpg)

集合时可变的, 因此不能用作字典中的键. 另一个问题是, 集合只能包含不可变的值, 因此不能包含其他集合. 可使用frozenset类型, 它表示不可变的集合:

![image-20200217130203240](https://tva1.sinaimg.cn/large/0082zybpgy1gbzbaujtxcj311o06uaay.jpg)

堆(heap), 一种优先队列. 优先队列让你能够以任意球顺序添加对象, 并随时(可能是在两次添加对象之间)找出(并删除)最小的元素. 相比于列表方法min, 这样做的效率要高得多. 堆操作函数模块`heapq`, 包含6个函数:

`heappush(heap,x)`: 将x压入堆中

`heappop(heap)`: 从堆中弹出最小的元素

`heapify(heap)`: 让列表具备堆特征

`heapreplace(heap,x)`: 弹出最小的元素, 并将x压入堆中

`nlargest(n,iter)`: 返回iter中n个最大的元素

`nsmallest(n,iter)`: 返回iter中n个最小的元素

**堆特征: 位于i处的元素总是大于位置`i//2`处的元素(反过来说就是小于位置`i*2`和`i*2 + 1`处的元素), 这是底层堆算法的基础, 称为堆特征(heap property).**

在需要按添加元素的顺序进行删除时, 双端队列很有用. 在模块collections中, 包含类型deque以及其他几个集合(collection)类型. 和集合(set)一样, 双端队列也是从可迭代对象创建的:

![image-20200217131737246](https://tva1.sinaimg.cn/large/0082zybpgy1gbzbr23c3wj31dk0gwn0o.jpg)

**双端队列支持队首(左端)高效弹出和附加元素, 还可以高效地旋转元素(将元素向右或向左移, 并在到达一端时环绕到另一端); 此外还支持`extend`和`extendleft`, 注意用于`extendleft`的可迭代对象中的元素将按照相反的顺序出现在双端队列中.**

![image-20200217132145937](https://tva1.sinaimg.cn/large/0082zybpgy1gbzbvev1qqj30za036q3a.jpg)

* shelve和json

对于模块shelve, 唯一感兴趣的函数`open`. 这个函数将一个文件名作为参数, 并返回一个`Shelf`对象, 供你用来存储数据. 可像操作普通字典那样操作(只是键必须为字符串), 操作完毕(并将所做的修改存盘)时, 可调用其他方法`close`.

![image-20200217190350863](https://tva1.sinaimg.cn/large/0082zybpgy1gbzlrayfb4j312006ydgu.jpg)

这里列表['a','b','c']被存储到了s的‘x'键下; 将‘d'附加到这个新列表末尾, 但这个修改后的版本未被存储; 最后再次获得原来版本, 其中没有'd'.

要正确地修改使用模块shelve存储的对象, 必须将获取的副本赋给一个临时变量, 并在修改这个副本后再次存储:

![image-20200217190734322](https://tva1.sinaimg.cn/large/0082zybpgy1gbzlv6gxn9j311m066dgj.jpg)

另一个方法是, 将函数open的参数writeback设置为True, 使得shelf对象读取或赋给它的所有数据结构都将保存到内存(缓存)中, 并等到你关闭shelf对象(`temp.close()`)时才将它们写入磁盘(`t=open('test.dat',writeback=True)`).

* re

正则表达式是可匹配文本片段的模式. 最简单的正则表达式为普通字符串, 与它自己相匹配.

通配符: 点好`.`除了换行符外和所有其他字符匹配, 仅匹配一个字符, 而不与零或两个字符匹配

转义: 就是让特殊字符的行为与普通字符一样, `python\\.org`只与`python.org`匹配. **为表示模块re要求的单个反斜扛, 需要在字符串中书写两个反斜扛, 让解释器对其进行转义(包含两层转义: 解释器执行的转义和模块re执行的转义).** 也可以使用原始字符串`r'python\.org'`

字符集: `[a-zA-Z0-9]`表示匹配大写字母, 小写字母和数字, 也只能匹配一个字符; 若要排除可在开头加上`^`: `[^abc]`表示匹配除a/b/c以外的其他任何字符; 同样, 对于右括号(])和连字符(-), 要么放在字符集开头, 要么使用反斜杠对其进行转义, 连字符也可放在末尾.

二选一和子模式: 使用圆括号限定选择部分, 使用管道字符(|)隔开子模式, `p(ython|erl)`

可选模式和重复模式: 通常在子模式后面加上问号, 可将其指定为可选的:

`(pattern)?`: 一次或零次

`(pattern)*`: 重复零次或1次或多次

`(pattern)+`: 重复1或多次

`(pattern){m,n}`: 重复m～n次

字符串的开头和末尾: 脱字符(^)指定开头匹配; 指定字符串末尾匹配使用美元符号($)

`compile(pattern[,flags])`: 根据包含正则表达式的字符串创建模式对象, 提高匹配效率

`search(pattern, string[,flags])`: 在字符串中查找模式

`match(pattern, string[,flags])`: 在字符串开头匹配模式, 仅匹配开头, 若完全匹配后加$符号

`split(pattern, string[,maxsplit=0])`: 根据模式来分隔字符串

`findall(pattern, string)`: 返回一个列表, 其中包含字符串中所有与模式匹配的子串

`sub(pat, repl, string[,count=0])`: 将字符串中与模式pat匹配的子串都替换成repl

`escape(string)`: 对字符串中所有的正则表达特殊字符都进行转义

![image-20200217215214542](https://tva1.sinaimg.cn/large/0082zybpgy1gbzqmillx8j311g038mxo.jpg)

![image-20200217215646316](https://tva1.sinaimg.cn/large/0082zybpgy1gbzqr80ntej311q02wq3i.jpg)

**如果模式包含圆括号, 将在分割得到的子串之间插入括号中的内容**

![image-20200217215905061](https://tva1.sinaimg.cn/large/0082zybpgy1gbzqtmqme9j310y024q33.jpg)

函数re.sub从左往右将与模式匹配的子串替换为指定内容:

![image-20200217220237761](https://tva1.sinaimg.cn/large/0082zybpgy1gbzqxbm8rvj311a03q3z2.jpg)

re.escapes是一个工具函数, 对于字符串中所有可能被视为正则表达式运算符的字符进行转义:

![image-20200217220349062](https://tva1.sinaimg.cn/large/0082zybpgy1gbzqyk5obuj312204udh6.jpg)

匹配对象和编组: 查找与模式匹配的子串的函数都在找到时返回MatchObject对象. **这种对象包含与模式匹配的子串的信息, 还包括模式的哪部分与子串的哪部分匹配的信息, 这些子串部分称为编组(group). ** 编组就是放在圆括号内的子模式, 它们时根据左边的括号数编号的, 其中编组0指的是整个模式.

![image-20200217221826441](https://tva1.sinaimg.cn/large/0082zybpgy1gbzrdrz5joj31fw0f2myy.jpg)

re匹配对象的重要方法:

`group([group1,...])`: 获得与给定子模式(编组)匹配的子串

`start([group])`: 返回与给定编组匹配的子串的起始位置

`end([group])`: 返回与给定编组匹配的子串的终止位置(与切片一样, 不包含终止位置)

`span([group])`: 返回与给定编组匹配的子串的起始和终止位置

![image-20200217222511134](https://tva1.sinaimg.cn/large/0082zybpgy1gbzrks9qwzj311y08gmy9.jpg)

替换中的组号和函数: 若只是字符串替换, 也可使用字符串方法`replace(old, new[,count])`; 为利用sub函数的强大功能, 最简单的方法是在替换字符串中使用组号

要让正则表达式容易理解, 一种方法是在调用模块re中的函数时使用标志VERBOSE. 这使得能在模式中添加空白(空格, 制表符, 换行符等), 而re将忽略它们, 除非将它放在字符类中或使用反斜杠对其进行转义, 在这样的正则表达式中, 你还可以添加注释:

![image-20200217223215806](https://tva1.sinaimg.cn/large/0082zybpgy1gbzrs5g6yjj31f209ego2.jpg)

模版(template)是一种文件, 可在其中插入具体的值来得到最终的文本. Python提供了一种高级模版机制: 字符串格式设置, 使用正则表达式可让这个系统更加高级.

![image-20200220201318123](https://tva1.sinaimg.cn/large/0082zybpgy1gc34mhect9j31200420t2.jpg)

![image-20200220201733984](https://tva1.sinaimg.cn/large/0082zybpgy1gc34qx3fhfj312e046q3u.jpg)

* 其他有趣标准模块

`argparse`: 提供功能齐备的命令行界面

`cmd`: 编写类似Python交互式解释器的命令行解释器

`csv`: csv指的是逗号分隔的值(comma-seperated values), 模块`csv`帮助轻松读写csv文件,  以非常透明的方式处理CSV格式的一些棘手部分

`datetime`: 支持特使的日期和时间对象, 并让你能够以各种方式创建和合并这些对象

`difflib`: 确定两个序列的相似程度, 帮组从很多序列中找出与指定序列最为相似的序列. 可使用difflib来创建简单的搜索程序

`enum`: 枚举类型是一种只有少数几个可能取值的类型

`hashlib`: 使用该模块可计算字符串的小型“签名”(数), 可用来计算大型文件的签名, 这个模块在加密和安全领域有很多用途

`functools`: 在调用函数时只提供部分参数(部分求值, partial evaluation), 以后再填充其他的参数. 在Python3.0中, 这个模块包含filter和reduce

`itertools`: 包含大量用于创建和合并迭代器(或其他可迭代对象)的工具,其中包括可以串接可迭代对象, 创建返回无限连续整数的迭代器(类似于range, 但没有上限), 反复遍历可迭代对象以及具有其他作用的函数

`logging`: 提供了一系列标准工具, 可用于管理一个或多个中央日志, 它还支持多种优先级不同的日志消息

`statistics`: 使用该模块进行高级运算

`timeit, profile, trace`: 模块timeit(和配套的命令脚本)是一个测量代码执行时间的工具; 模块profile(和配套模块pstats)可用于对代码段的效率进行更全面的分析; 模块trace可帮助你进行覆盖率分析(即代码的哪些部分执行了, 哪些部分没有执行), 在编写测试代码时很有用

* 打开文件

调用模考io中的open函数, 通过指定模式来显示指出这点:`r` 读取模式(默认值); `w` 写入模式; `x` 独占写入模式; `a` 附加模式; `b` 二进制模式(与其他模式结合使用); `t` 文本模式(默认值, 与其他模式结合使用); `+` 读写模式(与其他模式结合使用)

`w` 写入模式能够在文件不存在时创建它, 此时打开的文件, 既有内容将被删除(截断), 并从文件开头处写入; 若要在既有文件末尾继续写入, 可使用附加模式  `x` 独占写入模式会在文件已经存在时引发FileExistsError异常; `+` 可与其他任何模式结合起来使用, 表示既可读取也可写入, 例如`r+`表示打开进行读写, `w+`则会截断文本

![image-20200220204714665](https://tva1.sinaimg.cn/large/0082zybpgy1gc35ltasxrj312003074r.jpg)

* 读取和写入

write:

![image-20200220205244282](https://tva1.sinaimg.cn/large/0082zybpgy1gc35rk4q00j314m07kaae.jpg)

read:

![image-20200220205430209](https://tva1.sinaimg.cn/large/0082zybpgy1gc35te3lk9j314u05s74i.jpg)

* 使用管道重定向输出

例如编写脚本统计单词数目:

![image-20200220205916861](https://tva1.sinaimg.cn/large/0082zybpgy1gc35ycyqqnj31140d6abq.jpg)

我们将文件都视为流, 只能按顺序从头到尾读取. 实际上, 可在文件中移动, 只访问感兴趣的部分(称为随机存取). 使用文件对象两个方法: seek 和 tell

`seek`设置偏移量:

![image-20200220210608406](https://tva1.sinaimg.cn/large/0082zybpgy1gc365gnrk2j31220d8mzc.jpg)

`tell`返回当前位于文件的什么位置:

![image-20200220210725508](https://tva1.sinaimg.cn/large/0082zybpgy1gc366uephrj311w08iq3d.jpg)

* 读取和写入行

要读取一行(从当前位置到下一个分行符的文本), 使用方法`readline`, 调用时不提供任何参数(读取一行并返回它); 也可提供一个非负整数, 指定readline最对可读取多少个字符. 若要读取文本中所有行, 并以列表方式返回, 可使用方法`readlines`; 方法`writelines`与`readlines`相反, 接受一个字符串列表(可以是任何序列或可迭代对象), 并将这些字符串都写入到文件(或流)中.

* 关闭文件

对于写入过的文件, 一定要将其关闭, 因为Python可能缓冲你写入的数据(将数据暂时存储在某个地方, 以提供效率). 因此如果程序因某种原因崩溃, 数据可能根本不会写入到文本中. 安全的做法是, 使用完文件后就将其关闭. 如果要重置缓冲, 让所做的修改反应到磁盘文件中, 但又不想关闭文件, 可使用方法flush.

![image-20200220211514889](https://tva1.sinaimg.cn/large/0082zybpgy1gc36f0bdgzj314m06kmxe.jpg)

专门为此设计的语句, `with`语句. 能够打开文件并将其赋给一个变量. 在语句体中, 你将数据写入文件(可能是做其他事情). 到达该语句末尾时, 将自动关闭文件, 即便出现异常亦如此

![image-20200220211740465](https://tva1.sinaimg.cn/large/0082zybpgy1gc36hi9ebyj314m02mq35.jpg)

* 使用文件的基本方法

`open("test.py","r").read()`

`open("test.py","r").readline()`

`open("test.py","r").readlines()`

`open("t.txt","a").write("This \n is \n no \n haiku")`

![image-20200220213047424](https://tva1.sinaimg.cn/large/0082zybpgy1gc36v6b38dj314s08kt9l.jpg)

* 迭代文件内容

一种最常见的文本操作是迭代其内容, 并在迭代过程中反复采用某种措施

![image-20200220213521740](https://tva1.sinaimg.cn/large/0082zybpgy1gc36zxb1zij314q02ojrf.jpg)

更有用的实现包括将数据存储在数据结构中, 计算总和, 使用模块re进行模式替换以及添加行号

* 每次一个字符(或字节)

最简单(也可能是最不常见)的文件内容迭代方式是, 在while循环中使用方法read

![image-20200220213937520](https://tva1.sinaimg.cn/large/0082zybpgy1gc374cf493j310604kjrr.jpg)

或使用while True/break技巧

![image-20200220214114037](https://tva1.sinaimg.cn/large/0082zybpgy1gc3760dss4j30zw05cwer.jpg)

* 每次一行

![image-20200220214219398](https://tva1.sinaimg.cn/large/0082zybpgy1gc37761pbcj314m060jry.jpg)

* 读取所有内容

如果文件不太大, 可一次读取整个文件; 为此, 可使用方法read并不提供任何参数(将整个文件读到一个字符串中)

![image-20200220214552440](https://tva1.sinaimg.cn/large/0082zybpgy1gc37av0h9vj314a03qdfz.jpg)

也可使用方法readlines(将文件读取到一个字符串列表中, 其中每个字符串都是一行)

![image-20200220214638132](https://tva1.sinaimg.cn/large/0082zybpgy1gc37bn4rrmj314o03kglu.jpg)

* 使用fileinput实现延迟行迭代

Python中, 在可能的情况下, 应首选for循环; 模块fileinput会负责打开文件, 只需要提供一个文件名即可

![image-20200220215117979](https://tva1.sinaimg.cn/large/0082zybpgy1gc37gi863aj312u07yaal.jpg)

* 文件迭代器

文件实际上是可以迭代的, 这意味着可在for循环中直接使用它们来迭代

![image-20200220215312413](https://tva1.sinaimg.cn/large/0082zybpgy1gc37ihdqxdj311s08ejrl.jpg)

在不将文件对象赋给变量的情况下迭代文件

![image-20200220215447194](https://tva1.sinaimg.cn/large/0082zybpgy1gc37k35pkxj312o0703z6.jpg)

和其他文件一样, `sys.stdin`也是可以迭代的, 因此要迭代标准输入中的所有行

![image-20200220215619073](https://tva1.sinaimg.cn/large/0082zybpgy1gc37lpzeq2j312a05sdg1.jpg)

另外可对迭代器做的事情基本上都可以对文件做, 如(使用list(open(filename))))将其转换为字符列表, 其效果与使用readlines相同

![image-20200220220237730](https://tva1.sinaimg.cn/large/0082zybpgy1gc37sdaph4j31hc0iamzp.jpg)

注意, 使用print来写入文件, 这将自动在提供的字符串后面添加换行符; 写入文件后将其关闭, 以确保数据得以写入磁盘.

***

#### Miscellaneous	

* Jupyter Notebook

Jupyter Notebook是一个JSON文件, 拥有概况,  同时包含一系列输入和输出的有序cells, 这些cells包含了代码, MarkDown文件, 数学表达式, 图形, 表格和媒体. Jupyter Notebooks使用`.ipynb`文件后缀.

Jupyter Notebook可以转换成一系列不同的格式, 例如, HTML, slides, PDF, Markdown甚者Python. 该文件非常方便构建逐步的交互Python程序. 非常适合于数据分析和绘图.

![Jupyter Notebook: A Beginner's Tutorial](https://raw.githubusercontent.com/huizhen2014/Pic/master/007S8ZIlgy1giyc3eoujdj30mc02r74m.jpg)

安装并加载

![Jupyter Notebook: A Beginner's Tutorial](https://raw.githubusercontent.com/huizhen2014/Pic/master/007S8ZIlgy1giyc3qaeooj30m701dglm-20200924171854493.jpg)

`print (2+3)`; Shift+Enter, return 5, 交互式形式

* % (String Formatting Operator)

根据指定的格式来格式化字符串: `%[key][flags][width][.precison][length type] conversion type % values`

`%`是必须的, 标志着指定的开始;  `key`可选, 由括号包围的字符; `flags`可选, 转换字符; `width`可选, 最小的字符宽度, 若指定为`*`表示实际宽度来自元组中的下一个值宽度; `precision`可选, 以点开头随后数字表示精度`.3`; `length type`可选, 长度修订符号; `conversion type`: 可选, 转换类型; `values`必须, 数字, 字符串或包含值的一个变量, 用于替代转换类型.

`conversion flags`: `#`表示使用替换模式(alternate form); `0`针对数字做0填充宽度; `-`左对称; ` `空格, 针对正数左边使用空格填充;`+`代替空格填充.

`conversion types`: `d`含符号整数;  `i`含符号整数; `e/E`浮点指数格式; `f/F`浮点十进制格式; `g/G`浮点格式; `r` 字符串, 使用`repr()`转换字符; `s`字符串, 使用`str()`转换字符; `%`不转换, 结果输出`%`字符.

`print '(%(language)s has %(number)03d quote types.' % {"language":"Python", "number":2})`

`Python has 002 quote types.`

`print ("%s %s",("foo","bar"))`

`foo bar`

`dct = {"foo":10,"bar":20}`

`print("%(foo)s" % dct)`

`10`

`print ("%s" % "aaa")`

`aaa`

































