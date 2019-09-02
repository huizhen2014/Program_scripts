###fork,source,exec

1. exec和shell都属于内部命令，外部命令是通过系统调用或独立的程序实现的，如sed，awk等；内部命令是由特殊的文件格式(.def)所实现的，如cd/history/exec等
2. fork是linux系统调用，用来创建子进程(child process)，子进程是父进程(parent process)的一个副本，从父进程那里获得一定的资源分配以及继承父进程的环境。子进程和父进程唯一不同的地方在于pid(process id)。环境变量(传给子进程的变量)只能单向从父进程传给子进程。不管子进程的环境变量如何变化，都不会影响父进程的环境变量。
3. 有两种方法执行shell scripts，一种是新产生一个shell，然后执行在其下执行命令，执行完child，会返回parent；另一种是通过source命令，不再产生新的shell(sub-shell)，而在当前shell下执行一切命令。产生新的shell然后再执行的方法是在scrits文件开头加入以下语句：#!/bin/sh；source命令即点(.)命令。
4. exec命令在执行时会把当前的shell process关闭，然后换到后面的命令继续执行，系统调用exec是以新的进程去代替原来的进程，但进程的PID保持不变，运行完毕之后不会回到原先的程序中去。因此，可以这样认为，exec系统调用并没有创建新的进程，只是替换了原来进程上下文的内容。原进程的代码段，数据段，堆栈段被新的进程所代替。
5. I/O重定向通常与FD(file discriptor)有关，shell的FD通常位10个，即0～9，常用的FD有3个，为0(stdin, 标准输入), 1(stdout, 标准输出), 2(stderr, 标准错误输出)；&-关闭标准输出，n&-表示将n号输出关闭
6. 其他，date日期函数，date <+事件日期格式>; date +"%Y-%m-%d", 2019-03-18。wait，wait [n]，表示当前shell中某个执行的后台命令的pid，wait命令会等待该后台进程执行完毕才允许下一个shell语句执行；如果没指定则代表当前shell后台执行的语句，wait会等待到所有的后台程序执行完毕为止。

***

### shell实现多线程

1. 实例一：全前台进程：

   ```bash
   #!/bin/bash
   #filename:simple.sh
   starttime=$(date +%s)
   for ((i=0;i<5;i++));do
           {
                   sleep 3;echo 1>>aa && endtime=$(date +%s) && echo "我是$i,运行了3秒,整个脚本执行了$(expr $endtime - $starttime)秒"
           }
   done
   cat aa|wc -l
   rm aa
   ```

2. 实例二：使用'&'+wait 实现“多进程”实现

   ```bash
   #!/bin/bash
   #filename:multithreading.sh
   starttime=$(date +%s)
   for ((i=0;i<5;i++));do
           {
                   sleep 3;echo 1>>aa && endtime=$(date +%s) && echo "我是$i,运行了3秒,整个脚本执行了$(expr $endtime - $starttime)秒"
           }&
   done
   wait
   cat aa|wc -l
   rm aa
   ```

3. 实例三：可控制后台进程数量的“多进程”shell

   尚不能理解，😢😢😢😢

   https://blog.csdn.net/dubendi/article/details/78919322