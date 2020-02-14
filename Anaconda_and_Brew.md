###Anaconda

####Managing conda

conda --version

Conda update conda

#### Managing Environments

1. 工作环境可包含文件，包以及所依赖，同时不会和其他环境冲突

   命名环境为snowflakes，安装包BioPython

   conda create --name snowflakes biopython

   删除环境

   conda-env remove --name name 

   conda remove -n py36 --all

2. 查看安装环境及激活

   conda info --envs

   base	/home/username/Anaconda3

   snowflakes	* /home/username/Anaconda3/envs/snowflakes

   激活的环境为标*

   激活环境

   **source activate /home/…**

   **source deactivate /home/….**

3. 修改环境名字

   conda create -n tmp --clone source 

   conda-env remove -n name -p path

#### Managing Python

1. 当创建新环境，该环境会安装下载安装anaconda相同版本的python

2. 创建新环境且包含pyhton 3.5

   conda create --name snakes python=3.5

   source activate snakes

   conda info --envs		标星号表示激活	(snakes)$

#### Managing packages

1. 查看已经安装的包

   conda search beautifulsoup4

2. 在当前环境安装包

   conda install beautifulsoup4

3. 查看当前环境安装的包

   conda list

#### Install conda

1. 查看conda是否安装

   echo $PAHT

   which python

2. silent mode安装conda

   bash -b -p $HOME/anaconda anaconda.sh

   -b Batch mode: 不在~/.bashrc 中添加conda路径

   -p 安装路径, 需先建立目录。用conda的建议是  conda install -p   /yourpath， 然后在bashrc里   set PATH=$PATH:/yourpath/bin, 这样不污染环境, 

   -f 加入-p即使指定的路径存在，强制安装

   example：

   ```
   wget https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ~/miniconda.sh
   bash ~/miniconda.sh -b -p $HOME/miniconda
   export PATH="$HOME/miniconda/bin:$PATH"
   ```

   激活：	source $HOME/minicoda/bin/activate

   永久修改路径，需要修改~/.bashrc

   升级： conda update conda

   卸载：rm -rf ~/miniconda 

   或者修改~/.bash_profile将miniconda路径从PATH中删除

   rm -rf ~/.condarc ~/.conda ~/.continuum

   删除 .condarc	.conda	.continuum

   检查安装		conda list

#### Configuration

1. .condarc 默认不会生成，当运行conda config时会在$HOME或root目录生成
2. .condarc 包含

* where conda looks for packages
* If and how conda uses a proxy server
* where conda lists known environments
* whether to update the bash prompt with the current activated environment name
* Whether user-built packages should be uploaded to anaconda.org
* Default packages or features to include in new environments

3. 使用conda config 命令行或文本编辑来创建或修改.condarc

   conda config --add channels conda-forge

   conda cofig --set auto_update_conda False

#### .condarc 一般配置

1. channels，会优先于默认的channel，默认的能为default

   ```bash
   channels:
     - <anaconda_dot_org_username>
     - http://some.custom/channel
     - file:///some/local/directory
     - defaults
   ```

   如果在单独环境中修改.condarc，将其置于环境根目录，或在conda config 时指定--env

   ```bash
   allow_other_channels: False 允许其他channel
   ```

   ```bash
   default_channels:	设置默认channels
     - <anaconda_dot_org_username>
     - http://some.custom/channel
     - file:///some/local/directory
   ```

   ```bash
   auto_update_conda: False		update itself when update or install packages
   ```

   ```bash
   always_yes: True				when install
   ```

   ```bash
   show_channel_urls: True			conda list
   ```

   ```bash
   changeps1: False				使用activate时，提示符不显示当前环境
   ```

   ```bash
   add_pip_as_python_dependency: False			add pip, wheel and setuptools as dependencies of python, this ensures that pip, wheel and setuptools are always installed any time python is installed. The default is True.
   ```

   删除channels

   `conda config --remove-key channels`

   set a channels alias -c or --channel

   ```bash
   conda install --channel asmeurer <package>
   ```

   Equal to 

   ```bash
   conda install --channel https://conda.anaconda.org/asmeurer <package>
   ```

   ```bash
   update_dependencies: False		同时升级所有依赖的包
   conda install numpy=1.9.3 		安装指定版本包
   ```

2. 指定环境路径(envs_dirs)

   ```bash
   envs_dirs:
     - ~/my-envs
     - /opt/anaconda/envs
   ```

3. 指定包路径(pkgs_dirs)

   ```bash
   pkgs_dirs:
     - /opt/anaconda/pkgs
   ```

#### uninstall conda

1. 直接简单的移除即可
   * macOS rm -rf ~/anaconda
2. 或者通过anaconda-clean
   * 安装anaconda-clean package, conda install anaconda-clean
   * 运行 anaconda-clean / anaconda-clean —yes
   * 删除anaconda-clean 备份文件~/.anaconda_backup, 然后使用方法1直接删除

3. 最后，删除.bash_proifle 或者 .bashrc中anaconda的路径以及主目录下的~/.condarc ~/.conda ~/.continuum文件及目录

### pip

1. Mac同时拥有python2和python3，切换到不同的conda环境，再使用pip安装

   base:	

   $pip -V
   pip 18.1 from /Users/carlos/Bin/anaconda3/lib/python2.7/site-packages/pip (python 2.7)

   /Users/carlos/Bin/python3:

   pip -V
   pip 18.1 from /Users/carlos/Bin/python3/lib/python3.6/site-packages/pip (python 3.6)

















### Brew

1. dyld: Library not loaded: @@HOMEBREW_PREFIX@@/opt/gcc/lib/gcc/7/libgomp.1.dylib

* Try to re-install libtool by:

```bash
brew reinstall libtool --universal && brew unlink libtool && brew link libtool
```

* If that doesn't help, try removing libtool completely, and then retry the steps above:

```bash
brew uninstall libtool
```

------

* If it still doesn't work after trying the steps above, check to see if you have the **DYLD_FALLBACK_LIBRARY_PATH** variable defined somewhere on the system (e.g. ~/.profile) and try unsetting it before trying the steps above again.

------

* Other commands which could be useful for identifying the issue:

```bash
$ libtool --version
$ whereis libtool
$ set | grep DYLD_FALLBACK_LIBRARY_PATH
$ echo $DYLD_FALLBACK_LIBRARY_PAT
```

2. could not determine the version of cd-hit by Roary issues<https://github.com/sanger-pathogens/Roary/issues/322>