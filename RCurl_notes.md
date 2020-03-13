

The RCurl package is an R-interface to the libcurl library that provides HTTP facilities. This allows us to download files from Web servers, post forms, use HTTPS(the secure HTTP), use persistent connections, upload files, use binary content, handle redirects, password authentication, etc.

RCurl程序包提供了由R到libcurl库的接口，从而实现HTTP的一些功能。例如，从服务器下载文件，保持连接，上传文件，采用二进制格式读取，句柄重定向，密码认证等。

curl: 利用URL语法在命令行下工作的开源文件传输工具，curl背后的库就是libcurl

#### HTTP协议

协议是计算机通信网络中两台计算机之间进行通信所必须共同遵守的规定或规则，超文本传输协议(HTTP)是一种通信协议，它允许将超文本标记语言(HTML)文档从Web服务器传送到客户端的浏览器，目前我们使用的HTTP/1.1版本

![img](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ueq2i2opj30cv06qmz9.jpg)

##### URL详解

![image-20191011175257162](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uerrzwowj31hc0u0wni.jpg)

基本格式：`scheme://host[:post#]/path/.../[?query-string][#anchor]`

scheme：指定底层使用的协议(例如: http, https, ftp)

host：HTTP服务器的IP地址或着域名

port#：HTTP服务器的默认端口是80，这种情况下端口号可以省略

path：访问资源的路径

query-string：发给http服务器的数据

anchor：锚

##### 请求request

![image-20191011175838056](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uexp0jjuj31hc0u0jzg.jpg)

Method：表示请求方法，比如"GET","POST","HEAD","PUT"等

![image-20200313194022052](https://tva1.sinaimg.cn/large/00831rSTgy1gcsjb3i2qvj30mi07ljrs.jpg)

Path-to-resource：表示请求的资源

Http/version-number：表示HTTP协议的版本号

##### 请求报头

![image-20191011180100308](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uf05jnokj31hc0u0jz5.jpg)

Host：服务器地址

Accept：浏览器可以接受的媒体类型，text/html

Accept-encoding：浏览器接收的编码方法，通常所指的是压缩方法

Accept-language：浏览器声明自己接受的语言

User-agent：告诉服务器客户端的操作系统，浏览器版本

Cookie：最重要的请求报头的成分，为了辨识用户身份，进行session跟踪而储存在用户本地终端上的数据(通常经过加密)

Referer：跳转页

Connection：客户端与服务器的连接状态

##### 相应response

![image-20191011180440446](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uf41ex1hj31hc0u0dhp.jpg)

状态行/消息报头/相应正文

HTTP/version-number：表示HTTP协议的版本号

status-code和message表示状态码以及状态信息

##### status-code(状态码)

状态码用来告诉HTTP客户端，HTTP服务器是否产生了预期的Response

HTTP/1.1中定义了5类状态码，状态码由三位数字组成，第一数字定义了响应的类别

1XX：提示信息，表示请求已经被成功接收，继续处理

2XX：成功，表示请求已被成功接收，理解，接受

3XX：重定向，要完成请求必须进行更进一步的处理

4XX：客户端错误，请求有语法错误或请求无法实现

5XX：服务器端错误，服务器未能实现合法的请求

##### 消息报头

![image-20191011181559156](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uffs7pdqj31hc0u013j.jpg)

Server：服务器的软件信息，如nginx

Data：响应日期

Last-Modified：上次修改时间

Content-type：服务器告诉浏览器自己相应的对象类型，text/html

Connection：服务器和客户端是否保持链接

X-Powered-By：表示网站是什么技术开发的，如PHP

Content-Length：请求返回的字节长度

Set-Cookie：响应最重要的一个header，用于把cookie发给相应的浏览器，每一个写入cookie成一个set-cookie

#### HTML

HTML中标签指的是会指定其中包装的文本作为在浏览器分页的标题栏显示的标题，在实际语法中标签通常以一个< >符号包括起来，起始标签、内容和终止标签组合起来则成为元素，如下代码所示:

`<title> Chinars | 统计之都 </title>`

起始标签和终止标签都用<>符号包裹, 以便和内容进行区分, 不同的是终止标签会有一个`/`符号以示区别. 一般而言, 每个元素都有一个起始标签和终止标签, 但也不是全部. 例如,` <br>`标签表示换行, 则无需`</br>`标签表示终止.

[常用HTML标签如下][http://www.w3school.com.cn/tags/]:

![image-20200310133038394](https://tva1.sinaimg.cn/large/00831rSTgy1gcorre2ab5j31200iamzi.jpg)

标签最重要的一个特征就是属性:

`<a href="/chinar/chinar-2013/">第六届中国R语言会议</a>`, 标签`<a>`能够把相关的文本(这里指"第六届中国R语言会议")和一个指向另一个地址的超链接关联起来. `href="/chinar/chinar-2013/"`这个属性指定锚链接, 浏览器会自动把这类元素转化为带有下划线并且可以点击的样式. 总之, 属性就是让标签能够描述其内容处理方式的选型. 具体属性的作用则根据响应的标签来定.

属性总是处于起始标签的内部, 标签名的右侧, 一个标签拥有多个属性也是常见操作, 多个属性之间用空格分开:

![image-20200310133635362](https://tva1.sinaimg.cn/large/00831rSTgy1gcorxmoosqj311o0223yk.jpg)

树状结构

就像文档结构图一样, HTML最大的一个特点就是它呈现出树形结构的样子:

![image-20200310133752232](https://tva1.sinaimg.cn/large/00831rSTgy1gcoryy4xo6j311e08s3yt.jpg)

`<!DOCTYPE html>`是文档定义类型标签, 忽略这个的话这个例子的第一个元素就是`<html>`元素, 在这个元素的起始和终止标签内, 又有几个标签分别起始和终止: `<head><title>`和`<body>`. `<head>`和`<body>`标签是直接被`<html>`元素包含的, `<title>`标签则包含在`<head>` 标签内. 一个典型的树形结构就这样被描述.

所谓对HTML的解析, 就是获得有用的HTML文件表征, 运用一个能够理解标记结构特殊含义的程序, 并在某个R的专用数据结构内部重建HTML文本隐含的层次结构, 而不仅仅是读取. 在R语言中, 使用`XML`包中的`htmlParse`函数来解析一个HTML文件得到HTML格式文件(或使用`htmlTreeParse`函数解析HTML文件得到XML格式文件):

![image-20200310134623609](https://tva1.sinaimg.cn/large/00831rSTgy1gcos7swhncj311a03qglt.jpg)

***

#### RCurl三大函数

`getURL()/getForm()/postForm()`查看请求相应相关信息

####getURL()

这些命令下载一个或多个URIs(aka, URLs). `getURLContent`作为一个高级别的函数类似`getURL`和`getBinaryURL`, 但是通过查看HTTP header's Content-Type field对应什么样的内容类型被下载. 使用这个来判断bytes是binary, 还是text.

![image-20191011184820517](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ugdggkcxj31hc0u0wgh.jpg)

url.exists(url="...") 判断url是否存在

d <- debugGatherer() 接受调试信息，累加来自response的text信息

temp <- getURL(url="www.baidu.com",debugfunction=d$update,verbose=TRUE) d以update形式保持更新，会叠加返回信息；verbose设置为TRUE时，保存调试信息，为FALSE则隐藏对应d信息。

**cat(d$value()[3]) 提交个服务器的头信息，注意使用cat输出，储存和打印的不同(请求报头), 'headerOut'表示出去也就是发出的**

![image-20191011183722526](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ug1zulo7j30pu06m0tl.jpg)

**cat(d$value()[1]) 服务器的地址和端口号**

![image-20191011183854971](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ug3lk1u2j30pq05sdgw.jpg)

**cat(d$value()[2]) 服务器返回的头信息(消息报头), 'headerIn'表示进入也就是获得**

![image-20191011183944607](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ug4gly7uj31mk0hen23.jpg)

names(d)

![image-20191011184330851](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ug8dt14vj30gy01y3yk.jpg)

update表示保持更新；value表示对应的值，reset表示清空

d$reset() 清空d\$value()内容

![image-20191011184508107](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uga2p9y4j30wc03a3yq.jpg)

***

**查看服务器返回的头信息，列表形式**

![image-20191011184858883](https://tva1.sinaimg.cn/large/006y8mN6gy1g7uge4s2bij31hc0u0acd.jpg)

**basicHeaderGatherer()/basicTextGatherer() 均返回比较详细的，列表/字符串形式的信息**

h <- basicHeaderGatherer()

text <- getURL(url="http://www.baidu.com",headerfunction=h$update)

names(h$value())

h$value()

![image-20191011185416414](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ugjlgo7vj31h60amdin.jpg)

查看服务器返回的头信息，字符串形式

h <- basicTextGatherer()

txt <- getURL(url="http://www.baidu.com",headerfunction=h$update)

names(h$values())

h$value() / cat(h\$value())

![image-20191011185805481](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ugnjz00ej31g809aaek.jpg)

***

**查看url请求的访问信息，使用句柄的方式查看，就是操作系统时执行每一操作过程中，会给每一窗口一个唯一的特定的句柄，通过句柄来操纵窗口**

![image-20191011190357825](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ugto3q4vj31hc0u0k1t.jpg)

curl <- getCurlHandle() 获取句柄

d <- getURL("http://www.dataguru.cn",curl=curl) 

getCurlInfo(curl)$response.code 获取对应句柄信息

getCurlInfo(curl=curl)

![image-20191011190725073](https://tva1.sinaimg.cn/large/006y8mN6gy1g7ugxdc7inj318k0cu756.jpg)

设置自己的header(代理服务器或伪装浏览器和操作系统设置header)

![image-20191012124301519](https://tva1.sinaimg.cn/large/006y8mN6gy1g7vbfm31psj31hc0u07e5.jpg)

user-Agent：指定访问服务器所使用的浏览器类型及版本、操作系统及版本、浏览器内核、等信息的标识(百度搜索user-agent): `R.version`

![image-20191012225026994](https://tva1.sinaimg.cn/large/006y8mN6ly1g7vszone36j315808sdi7.jpg)

**listCurlOptions() 设置其他句柄参数，170多个之多**

verbose：输出访问的交互信息TRUE

httpheader：设置访问信息报头

.encoding='UTF-8' 'GBK'

debugfunction,headfunction,curl

.params：提交的参数组

dirlistonly：仅读目录，这个在ftp的网页，非常好用

followlocation：支持重定向

maxredirs：最大重定向次数

####getForm()

**提交HTML格式，提交信息直接附加在url后实现提交，可实现搜索; 或者使用POST方式, 将名称-值对信息放到请求的主体部分而不是URL行**

在必应内搜索'Rcurl'的url为

**url <- c("http://cn.bing.com/search?q=Rcurl&go=Search&qs=n&form=QBRE&sp=-1&pq=rcurl&sc=8-5&sk=&cvid=1C525D5532D544C2AD4507EA1EFE102F")**

**这里q=rcurl 这里就是关键字rcurl,以？开始，后续以&为分隔符**

getFormParams(query=url) ##查看url的结构和值

![image-20191012233407197](https://tva1.sinaimg.cn/large/006y8mN6ly1g7vu92tfecj319g08idhc.jpg)

例如: `url <- 'https://cn.bing.com/search?q=RCurl&qs=n&form=QBRE&sp=-1&pq=rcurl&sc=8-5&sk=&cvid=16A9B4786C3240CEA5F5E458E2A00180'`

`getFormParams(query=url)`

![image-20200313203357018](https://tva1.sinaimg.cn/large/00831rSTgy1gcskuuqpbxj30ko04baa2.jpg)

##### postForm()

**以保密的形式上传我们所要页面提交的信息，然后获取服务器端返回该页面信息。例如登陆一个页面，需要账户和密码，那么我们需要提交账户和密码，提交的信息要加密，然后抓取登陆后的页面信息。**

base64用于将口令中不兼容的字符转换为网页兼容字符，不是为了安全隐私目的

#### getBinaryURL()

##### curl部分参数设置

![006y8mN6ly1g7y41afw65j31hc0u0wmj](https://tva1.sinaimg.cn/large/0082zybpgy1gc0bgzg50rj31hc0u0tao.jpg)

乱码可设置encoding为'UTF-8'/'GBK'

* dirlistonly：仅读取目录在ftp很出色

url <- "ftp.xxx"

filename <- getURL(url,dirlistonly=TRUE)

这里filename对应获得就是所有的目录名称

* followloaction设置为TRUE可实现自动跳转

curl <- getCurlHandle()

destination <- getURL("http://www.sina.con",curl=curl, followlocation=TRUE)

getCurlInfo(curl)$response.code

* maxredirs定义重定向次数，防止跳入死循环，一般定义为5或3，防止恶性页面循环

##### getBinaryURL()下载文件

![image-20191014231602529](https://tva1.sinaimg.cn/large/006y8mN6ly1g7y4yvhggjj31hc0u0jyl.jpg)

url <- "http://rfunction.com/code/1201/120103.R"

temp <- getBinaryURL(url)

note <- file("120123.R",open="wb")

writeBin(temp,note)

close(note)

##### 批量下载

![image-20191014232106855](https://tva1.sinaimg.cn/large/006y8mN6ly1g7y546nczij31hc0u07df.jpg)

查看源代码，利用正则表达，筛选出来文件，批量下载

![image-20191014232746551](https://tva1.sinaimg.cn/large/006y8mN6ly1g7y5b33qoyj310k09279l.jpg)

使用函数拆分得到文件名向量，然后设置for循环，依次下载以实现循环下载目的

Sys.sleep(2)防止频繁访问被网站拉黑，休眠2秒

#### XML

XML(eXtensible Markup Language), 可拓展标记语言, 首先它和HTML一样, 为一门标记语言, 那它就该有标记语言的全部特征, 这是XML的共性. XML是被设计用来传输和存储数据的, 这和HTML用来显示数据不大一样, 所以又有网络数据交换最流行格式的美誉:

1. 一个XML文档永远以生明该文档的一行代码来开头:

![image-20200310151307126](https://tva1.sinaimg.cn/large/00831rSTgy1gcouq1yboaj310u022748.jpg)

`version="1.0"`用来声明该XML文档的版本号. `encoding="ISO-8859-1"`表明编码格式. 

2. XML文档必须要有一个根元素, 这个根元素包裹了整个文档, 上例中, 根元素为:

![image-20200310151515753](https://tva1.sinaimg.cn/large/00831rSTgy1gcousa1ovdj310c03kmx2.jpg)

XML是用来传输数据的, 而这个数据通常是放在具体的XML元素中的.

3. 一个XML元素由起始标签和具体内容来定义, 一个元素可以用一个闭合标签来结束, 也可以在起始标签里用一个斜杠(/)来闭合. 元素里可以包含其他元素, 属性, 具体数据等其他内容.

![image-20200310151744972](https://tva1.sinaimg.cn/large/00831rSTgy1gcouuusr1aj310a01s3yf.jpg)

元素标题: city

起始标签: `<city>`

终止标签: `</city>`

数据值: `<rockets>`

##### 下载表格

![image-20191016232020699](https://tva1.sinaimg.cn/large/006y8mN6ly1g80gbyryoyj31hc0u07j8.jpg)

在readHTMLTable(doc)加入参数header= F，可避免页眉解析错误导致的解析失败。中文界面解析失败，选择英文界面解析。

或通过getBinaryURL()直接将整个页面下载下来，保存为"xxx.xls"，抓取中文界面。

##### [XPath][https:///www.w3school.com.cn/xpath/index.asp]

XPath表达式就是选取XML或者HTML文件中节点的方法, 这里的节点, 通常是指XML/HTML文档中的元素.

XPath通过路径表达式(Path Expression)来选择节点信息, 跟文本系统路径一样使用"/"符号来分隔路径:

`nodename`: 选择该节点的所有子节点

`"/"`: 选择根节点

`"//"`: 选择任意节点

`"@"`: 选择属性

例如:

`nbaplayer`: 选取nbaplayer元素所有的子节点

`/nbaplayer`: 选取根节点nbaplayer

`//team`: 选择所有的team子元素

`//@name`: 选择所有的name属性值

除此之外, 可以通过給表达式附加一些条件来选择指定的数据, 所有筛选条件可以附在一个`[]`符号中:

`/nbaplayer/team[1]`:  选择nbaplayer下第一个team子元素

`//city[@name]`: 选择带有name属性的team节点

通过网页中路径抓取信息

![image-20191016232611540](https://tva1.sinaimg.cn/large/006y8mN6ly1g80gi22w9ij31hc0u014f.jpg)

![image-20191017225618278](https://tva1.sinaimg.cn/large/006y8mN6ly1g81l99mnjbj30pc06w0ud.jpg)

##### 试一试

根据Xpath规则和网页信息，设置对应的选择条件，抓去对应信息

url <- "https://www.w3school.com.cn/example/xdom/books.xml"

doc <- xmlParse(getURL(url))

#####添加谓语

getNodeSet(doc,"/bookstore/book[1]")  ##获得根节点外的第一个节点信息
getNodeSet(doc,"/bookstore/[position() < 3]")  ##获取前两本
getNodeSet(doc,"/bookstore/book[last()]")  ##最后一本
getNodeSet(doc, "//title[@lang]")  ##对应属性

例如：

![image-20191017230524986](https://tva1.sinaimg.cn/large/006y8mN6ly1g81liqk4ggj31hc0u0qf7.jpg)

**打开网页源代码，查看目的信息的规则，设置对应的匹配信息；针对无法读到或读到乱码信息，可以重设header信息，再次尝试；多页面可以参考网页地址更替规律，使用循环函数来读取多页**

***

![image-20200218110446357](https://tva1.sinaimg.cn/large/0082zybpgy1gc0dj4huc7j30yw0pa43c.jpg)

***

#### Mischellaneous

![image-20200313194640103](https://tva1.sinaimg.cn/large/00831rSTgy1gcsjicdj9pj30e20e8js6.jpg)