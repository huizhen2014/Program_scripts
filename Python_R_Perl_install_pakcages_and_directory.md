##### 默认条件下在用户HOME目录下创建R安装包，Python安装包及执行文件，避免HOME下内存不过，修改其安装路径

* 在HOME下创建.Rprofile 文件，对R进行配置：

1. 设置安装包路径：.libPaths("/the/path/to/the/R/packages/")
2. 避免出现网络连接故障，设置：options(download.file.methon="libcurl"), 该选项可在help(options)中可见

* python存在2和3两个版本，首先查看不同版本下的配置位置：python2/3 -m site ; 发现USER_BASE安装目录也默认出现在HOME目录下：$HOME/.local; USER_SIET: \$HOME/.local/lib/python2/3/site-packages，为避免HOME空间不够，修改其路径

1. 参考[pip](https://pip.pypa.io/en/stable/user_guide/#configuration)官网说明，设置user scheme， 添加PYTHONUSERBASE路径到.bashrc或.bash_profile中，例如：export PYTHONUSERBASE=/share/Data/xxx/bin/.local
2. 在安装python2/3对应packages时，使用--user选项，例如：pip2/3 install --user pakcage_name，即可对应将packages安装至$PYTHONUSERBASE/lib/python2/3/site-packages, 同时可执行文件会出项在\$PATHONUSERBASE/bin中，将该路径添加到PATH中即可

* python包其他路径设置问题

1. python窗口添加：打开python3; import sys; sys.path 显示当前路径(或pyhton3 -m site)
2. 直接添加：sys.path.append("/your/path/to/add")，这样每次运行都需重复

![image-20190529093743781](http://ww2.sinaimg.cn/large/006tNc79gy1g3hxsx3q6rj313804mgmb.jpg)

3. 另一种方法，无需每次添加。在site-packages内添加文件，例如rgiapp.pth，后缀必须为.pth，同时直接写上路径即可：/your/path/to/add

![image-20190529094105672](http://ww3.sinaimg.cn/large/006tNc79gy1g3hxwfa1agj30se01uaa6.jpg)

4. 添加环境变量PYTHONPATH, python会添加此路径下模块，在.bash_profile中：export PYTHONPATH=/usr/local/lib/dir:$PATHONPATH
5. 如果安装了模块仍然显示无法查询到，简单方法，重装，甚至重装更上级模块

* pip3 uninstall biopython
* pip3 install biopython
* pip3 install Bio

#### Perl 非@INC路径模块安装及使用

* perl模块安装路径存于@INC中，简写脚本

`#!/usr/bin/env perl`

`foreach $a (@INC){`

`print $a,"\n"}`

![image-20190601181429324](http://ww2.sinaimg.cn/large/006tNc79gy1g3ltlitelhj30o40ay0ua.jpg)

* 或查看否个模块安装路径：perldoc -l module，或者cpan -l列出所有cpan安装的模块
* 安装local::lib包，创建并安装模块到perl's builtin @INC以外的路径
* 下载local::lib文件，解压缩，按照说明安装，本机默认设定其他路径为~/.perl5

![image-20190601185642477](http://ww1.sinaimg.cn/large/006tNc79gy1g3lutfzr8hj312k0aigns.jpg)

* 经$HOME/perl5/lib/perl5，export到PERL5LIB中

本机

![image-20190601185802402](http://ww1.sinaimg.cn/large/006tNc79gy1g3luxetfflj313e05qwfu.jpg)

echo `eval "$(perl -I $HOME/perl5/lib/perl5 -Mloca::lib)"` >> ~/.bash_proifile ##很重要

* 使用cpanm安装路径会默认安装到~/perl5中，可指定-l安装路径

`export PERL_CPANM_OPT="--prompt --reinstall -l ~/perl --mirror http://cpan.cpantesters.org"`，将指定cpanm安装模块dir和mirror

* 好多年不用perl，好气人，http://learnperl.scratchcomputing.com/tutorials/configuration/#local_lib
* 摘抄生信技能树

但是如果是非root用户，那么就麻烦了，很难用自动的cpan下载器，这样只能下载模块源码，然后编译，但是编译有个问题，很多模块居然是依赖于其它模块的，你的不停地下载其它依赖模块，最后才能解决，特别麻烦

但是，只需要运行下面的代码：``
``

> ```
> wget -O- http://cpanmin.us | perl - -l ~/perl5 App::cpanminus local::lib
> eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`
> echo 'eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`' >> ~/.profile
> echo 'export MANPATH=$HOME/perl5/man:$MANPATH' >> ~/.profile
> ```

就能拥有一个私人的cpan下载器，`~/.profile可能需要更改为.bash_profile, .bashrc, etc等等，取决于你的linux系统！`

然后你直接运行`cpanm Module::Name，就跟root用户一样的可以下载模块啦！`

关于circos软件配置GD perl模块无法安装，直接brew install perl，不使用自带perl

***



