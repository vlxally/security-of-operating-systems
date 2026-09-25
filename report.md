Лабораторная работа №1

2.1 Перемещение по файловой системе

#2.1.2
whoami 
pwd

#2.1.3
cd /
cd ..

#2.1.4
ls

#2.1.5
ls /etc

#2.1.6
cd

#2.1.7
ls

#2.1.8
ls -la

2.2 Работа с файловой системой

#2.2.1
mkdir fruits

#2.2.2
cd /
mkdir ~/animals

#2.2.3
touch tmp/temp

#2.2.4
echo "Hello" > tmp/temp
echo "world" >> tmp/temp
nano tmp/temp

#2.2.5
cd ~/fruits
touch apple && touch banana && touch pineaple && touch lion

#2.2.6
touch ../animals/cat.txt ../animals/dog.txt ../animals/elephant.txt

#2.2.7
ls a*

#2.2.8
ls *e

#2.2.9
ls *a*n*

#2.2.10
cp /etc/passwd ~
wc -l ~/passwd
ln -s ~/passwd ~/passwd_link
ls -i ~/passwd_link

#2.2.11
cat /etc/issue

#2.2.12
cp /etc/issue apple
cat apple

#2.2.13
mv lion ../animals

#2.2.14
mv pineaple pineapple

#2.2.15
ln ~/.bash_history ~/bash_history_link
ls -l ~/bash_history_link

#2.2.16
cd
rm -r fruits

#2.2.17
cat var/log/syslog

#2.3.1
cut -d: -f1 etc/passwd | sort

#2.3.2
grep "bin/bash" etc/passwd | wc -l

#2.3.3
grep "bin/bash" etc/passwd | cut -d: -f1 | sort -r

#2.3.4
cut -d: -f1,7 etc/passwd | tr ':' '\t'


#2.4.1


#2.4.2


#2.4.3


#2.4.4


#2.4.5








