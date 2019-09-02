#####gawk中的正则表达模式是使用//限定每条输入匹配内容，例如模式/foo/匹配任何含有三个连续字符'foo'的输入记录。

1. 输出包含/foo/的记录的第二个区间内容

   gawk '/foo/{print $2}' file.txt

2. 采用'~'和'!~"分别表示匹配和不匹配形式

   gawk '$1 ~ /foo/' file.txt 等同 

   gawk '\$1 ~ /foo/ {print}' file.txt 等同

   gawk '{if($1 ~ /foo/)print}' file.txt

   gawk '$1 !~ /foo/' file.txt 表示不匹配

3. 反斜线表示取消元字符意义，表示该字符字面意义

   "a\qc" 就等同于 "aqc"，因为任何字符前含有\都表示此时为该字符字面意义

   \\\ 表示\

   \/ 表示/

   \\"表示"

   \\$表示\$

4. 正则表达操作符

   ^: 匹配输入字符串开头, "^@chapter" 比对以"@chapter"开头的字符串，但是^不会匹配一行的开头("\n"新行后的开头): if( "line1\nLINE2" ~ /^L/)不匹配

   \$: 匹配输入字符串的结尾, 同上，不会匹配一行的结尾("\n"后的新行): if("line1\nLINE2" ~ /1\$/)不匹配

   .: 匹配任何单个字符

   \[…\]: 匹配中括号内任何单个字符, \[0-9\]等同与0123456789

   \[^…\]: 匹配除中括号以外的任何单个字符

   |: 可选操作符, "^P|[aeiouy]" 匹配P开头或aeiouy任何一个字符

   (…): 对正则表达进行分组，可以用来连接可选操作符"|", "@(sample|code)\\{|\[^}]+\\}" 可以匹配"@code{foo}" 或 "@sample{bar}"

   *: 表示前一个字符(单个)重复任意次

   +: 表示前面单个字符至少匹配1次

   ?: 表示前面单个字符匹配一次或者0次

   {n}, {n,} {n,m}限定前面单个

5. 使用中括号表达

   \[:album:\]: 字符和数字 等同 /\[A-Za-z0-9\]/

   \[:alpha:\]: 字母

    \[:blank:\]: 空格或tab字符

   \[:digit:\]: 数字

   \[:lower:\]: 小写字母

   \[:upper:\]: 大写字母

6. 使用正则内容/\\*/即可表示"\*", 如果使用字符串，则需要"\\\\\*", 第一斜杠作用于第二个字符。因此，使用正则内容更容易理解，且减少错误

7. gawk特殊正则操作符

   \\s: 匹配任何空字符，等同\[[:space:\]]

   \\S: 匹配任何空字符以外字符，等同\[^[:space:]]

   \w: 匹配任何连续字符，匹配任何字符，数字或下划线，等同[[:alnum:]_]

   \W: 匹配任何非word-costituent，等同\[^[:album:]_]

   \\<: 锁定开头字符

   \\>: 锁定结尾字符

   \\y: 匹配单词的开头或结尾的空字符串, /\yballs?\y/匹配单个单词'ball'或'balls' 

   \\B: Matches the empty string that occurs between two word-constituent characters. For example, /\Brat\B/ matches ‘crate’, but it does not match ‘dirty rat’.

8. 标准正则表达式内容时

   当/foo/在~的右边, 表达式为(/foo/)时，就相当于(\$0 ~ /foo/)，因此: if(\$0~/barfly/ || $0 ~ /camelot/) 等同于 if(/barfly/ || /camelot/)

   当/foo/在~左边时, if(/foo/~\$1)，实际上该表达式为: (\$0 ~ /foo/) ~ \$1, 也就是说先匹配这个输入，根据匹配结果其结果为1或者0，然后该结果再匹配$1；另一种情况为，matches=/foo/，则给予当前输入匹配/foo/与否，赋值matches1或者0。

9. gawk正则特色

   That is, you cannot define a scalar variable whose type is “regexp” in the same sense that you can define a variable to be a number or a string: 

   ```bash
   num = 42    Numeric variable
   str = "hi"    String variable
   re = /foo/    Wrong! re is the result of $0 ~ /foo/
   ```

   For a number of more advanced use cases, it would be nice to have regexp constants that are strongly typed; in other words, that denote a regexp useful for matching, and not an expression. 

   gawk provides this feature. A strongly typed regexp constant looks almost like a regular regexp constant, except that it is preceded by an ‘@’ sign: 

   re = @/foo/     Regexp variable 

***

#####通配符(wildcards)是内建模块，用于创造定义文件或路径的模式

1.  基本字符

   *: 匹配文件文文件名中0个或者多个字符，包括空字符

   ?: 匹配文件名中的任何当个字符

   []: 匹配[]中所包含任何字符，[0-9]所有数字字符

   \[!]: 匹配非！后的任何字符 ，[!0-9]不是数字的字符

   \[1,2]: 1或者2


***

#### gawk数组

