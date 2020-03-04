#### [rvest][https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/]

Easily Harvest(Scrape) Web Pages

With the amount of data available over the web, it opens new horizons of possibility for a Data Scientist. I strongly believe web scraping is a must have skill for any data scientist. In today's world, all the data that you need is already available on the internet - the only thing limiting you from using it is the ability to access it. 

Most of the data available over the web is not readily available. It is present in an unstructured format(HTML format) and is not dowloadable. 

Web scraping is a technique for conveting the data present in unstructured format over the web to the structured format which can easily be accessed and used.

1. 从网路读取HTML code

`read_html`/`read_xml`: 读取html/xml; 获得, 一个XML文档, HTML也将会标准化为XML

`read_xml(x, encoding="",as_html=FALSE...)`: x, 字符串, 一个链接; encoding, 指定文件默认的encoding

`library('rvest')`

`url <- "https://www.imdb.com/search/title/?count=100&release_date=2016,2016&title_type=feature"`

`webpage <- read_html(url)`

2. 根据对应的CSS selector 提示, 抓取对应部分; 转换格式为文本

`html_nodes/html_node`: 使用XPath和CSS selectors从HTML文件中提取内容块. CSS selectors和[http://selectorgadget.com]连用很有用.

`html_modes(x, css, xpath)`: x, 文件, 一组节点或单个节点; css, 选择的节点; xpath, XPath 1.0 selector

`html_text/html_name/html_attrs`: 从html中提取属性, 文本和标签名称

`html_text(x, trim=FALSE)`: x, 文本/节点/节点集; trim, 是否去除首位的空格

`rank_data_html <- html_nodes(webpage, '.text-primary')`

`rank_data <- html_text(rank_data_html)`























