###preface

Most of bioinformaticians know how to analyze data with Perl or Python programming. However, not all of them realize that it is not always necessary to write programs. Sometimes, using UNIX commands is much more convenient and can save a lot of time spent on some trivial, yet tedious, routines.

Here are some UNIX commands I frequently use in data analyses. I do not mean to give a complete reference to these commands, but aim to introduce their most useful bits with examples.

### xargs

Xargs is one of my most frequently used UNIX commands. Unfortunately, many UNIX users overlook how powerful it is.

1. delete all *.txt files in a directory:

2. - find . -name "*.txt" | xargs rm

3. package all *.pl files in a directory:

4. - find . -name "*.pl" | xargs tar -zcf pl.tar.gz

5. kill all processes that match "something":

6. - ps -u `whoami` | awk '/something/{print $1}' | xargs kill

7. rename all *.txt as *.bak:

8. - find . -name "*.txt" | sed "s/\.txt$//" | xargs -i echo mv {}.txt {}.bak | sh

9. run the same command for 100 times (in case of bootstraing, for example):

10. - perl -e 'print "$_\n"for(1..100)' | xargs -i bsub echo bsub -o {}.out -e {}.err some_cmd | sh

11. submit all commands in a command file (one command per line):

12. - cat my_cmds.sh | xargs -i echo bsub {} | sh

The last three examples only work with GNU xargs. BSD xargs does not accept '-i'.

### find

In a directory, find command finds all the files that meet certain criteria. You can write very complex rules at the command line, but I think the following examples are most useful:

1. find all files with extension as "*.txt" (files can exist in subdirectory):

2. - find . -name "*.txt"

3. find all directories:

4. - find . -type d

### awk

Awk is a programming language that is specifically designed for quickly manipulating space delimited data. Although you can achieve all its functionality with Perl, awk is simpler in many practical cases. You can find a lot of online tutorials, but here I will only show a few examples which cover most of my daily uses of awk.

1. choose rows where column 3 is larger than column 5:

2. - `awk '$3>$5' input.txt > output.txt`

3. extract column 2,4,5:

4. - awk '{print $2,$4,$5}' input.txt > output.txt
   - awk 'BEGIN{OFS="\t"}{print $2,$4,$5}' input.txt

5. show rows between 20th and 80th:

6. - awk 'NR>=20&&NR<=80' input.txt > output.txt

7. calculate the average of column 2:

8. - awk '{x+=$2}END{print x/NR}' input.txt

9. regex (egrep):

10. - awk '/^test[0-9]+/' input.txt

11. calculate the sum of column 2 and 3 and put it at the end of a row or replace the first column:

12. - awk '{print $0,$2+$3}' input.txt
    - awk '{$1=$2+$3;print}' input.txt

13. join two files on column 1:

14. - awk 'BEGIN{while((getline<"file1.txt")>0)l[$1]=$0}$1 in l{print $0"\t"l[$1]}' file2.txt > output.txt

15. count number of occurrence of column 2 (uniq -c):

16. - awk '{l[$2]++}END{for (x in l) print x,l[x]}' input.txt

17. apply "uniq" on column 2, only printing the first occurrence (uniq):

18. - awk '!($2 in l){print;l[$2]=1}' input.txt

19. count different words (wc):

20. - awk '{for(i=1;i!=NF;++i)c[$i]++}END{for (x in c) print x,c[x]}' input.txt

21. deal with simple CSV:

22. - awk -F, '{print $1,$2}'

23. substitution (sed is simpler in this case):

24. - awk '{sub(/test/, "no", $0);print}' input.txt

### cut

Cut cuts specified columns. The default delimiter is a *single* TAB.

1. cut the 1st, 2nd, 3rd, 5th, 7th and following columns:

2. - cut -f1-3,5,7- input.txt

3. cut the 3rd column with columns separated by a *single* space:

4. - cut -d" " -f 3 input.txt

Note that awk, like Perl's split, takes continuous blank characters as the delimiter, but cut only takes a single character as the delimiter.

### sort

Almost all the scripting languages have built-in sort, but none of them are so flexible as sort command. In addition, GNU sort is also space efficient. I used to sort a 20Gb file with less than 2Gb memory. It is not trivial to implement so powerful a sort by yourself.

1. sort a space-delimited file based on its first column, then the second if the first is the same, and so on:

2. - sort input.txt

3. sort a huge file (GNU sort ONLY):

4. - sort -S 1500M -t $HOME/tmp input.txt > sorted.txt

5. sort starting from the third column, skipping the first two columns:

6. - sort +2 input.txt

7. sort the second column as numbers, descending order; if identical, sort the 3rd as strings, ascending order:

8. - sort -k2,2nr -k3,3 input.txt

9. sort starting from the 4th character at column 2, as numbers:

10. - sort -k2.4n input.txt

### other tips

1. use brackets:

2. - (echo hello; echo world; cat foo.txt) > output.txt
   - (cd foo; ls bar.txt)

3. save stderr output to a file:

4. - some_cmd 2> output.err

5. direct stderr output to stdout:

6. - some_cmd 2>&1 | more
   - some_cmd >output.outerr 2>&1

7. view a text file using 4 as a TAB size and without line wrapping:

8. - less -S -x4 text.txt

9. [sed] substitute 'foo(\d+)' as "(\d+)bar":

10. - sed "s/foo\([0-9]*\)/\1bar/g"
    - perl -pe 's/foo(\d+)/$1bar/g"

11. [uniq] count the occurrence of different strings at column 2:

12. - cut -f2 input.txt | uniq -c

13. grep "--enable" in a file (use "--" to prevent grep from parsing command options):

14. - grep -- "--enable" input.txt
