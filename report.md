Лабораторная работа №3

2.1 Управление доступом к файлам

#2.1.1
mkdir ~/test
cd ~/test
touch file
ls -l file

#2.1.2
chmod 000 file
echo "hello" > file
cat file

#2.1.3
chmod 200 file
echo "hello" > file
cat file

#2.1.4
chmod 240 file
cat file

#2.1.5
chmod 640 file
cat file

#2.1.6
mkdir dir
echo "hello" > dir/new_file
ls -l dir

#2.1.7
chmod 644 dir
cat dir/new_file
rm dir/new_file

#2.1.8
chown root file

#2.1.9
umask 077
touch new_file
ls -l new_file

#2.1.10
umask 000
touch new_file_all
ls -l new_file_all

#2.1.11
sudo su
chown root /home/vlxally/test/file
chmod 400 /home/vlxally/test/file
exit

#2.1.12
cat file
sudo su
chmod 440 /home/vlxally/test/file
exit
cat file



2.2 Управление пользователями и группами

#2.2.1
id

#2.2.2
grep "vlxally" /etc/passwd
grep ":1000" /etc/group

#2.2.3
sudo groupadd labgroup
grep "labgroup" /etc/group

#2.2.4
sudo useradd -m -s /bin/bash labuser
grep "labuser" /etc/passwd

#2.2.5
sudo passwd labuser
su - labuser
whoami
id
pwd
exit

#2.2.6
su - labuser
touch file
ls -l file
exit

#2.2.7
sudo usermod -aG labgroup labuser
id labuser
su - labuser
id
exit

#2.2.8
sudo useradd -m -s /bin/bash labuser2
sudo usermod -aG labgroup labuser2
grep "labgroup" /etc/group

#2.2.9
mkdir /tmp/lab_shared
sudo chown root:labgroup /tmp/lab_shared
sudo chmod 770 /tmp/lab_shared
su - labuser
touch /tmp/lab_shared/file
exit

#2.2.10
su - labuser
touch /tmp/lab_shared/file
exit
su - labuser2
cat /tmp/lab_shared/file
echo "hello" > /tmp/lab_shared/file
rm /tmp/lab_shared/file
exit

#2.2.11
sudo chmod 2770 /tmp/lab_shared
su - labuser
touch /tmp/lab_shared/file_1
ls -l /tmp/lab_shared/file_1
exit
su - labuser2
touch /tmp/lab_shared/file_2
ls -l /tmp/lab_shared/file_2
exit

#2.2.12
mkdir /tmp/test
sudo chmod 1777 /tmp/test
su - labuser
touch /tmp/test/file_1
exit
su - labuser2
touch /tmp/test/file_2
rm /tmp/test/file_1
exit

#2.2.13
sudo usermod -L labuser
su - labuser
sudo usermod -U labuser
su - labuser
exit

#2.2.14
sudo chage -l labuser

#2.2.15
sudo usermod -s /bin/sh labuser
grep "labuser" /etc/passwd
sudo usermod -s /bin/bash labuser

#2.2.16
sudo userdel labuser2
ls -l /home
sudo ls -la /home/labuser2

#2.2.17
cat /etc/passwd
grep "vlxally" /etc/passwd

#2.2.18
grep -E "UID_MIN|UID_MAX|SYS_UID_MIN|SYS_UID_MAX" /etc/login.defs
awk -F: '$3 >= 100 && $3 < 1000 {print $1, $3}' /etc/passwd
awk -F: '$3 >= 1000 && $3 <= 60000 {print $1, $3}' /etc/passwd

#2.2.19
sudo useradd -m testuser
sudo useradd -r testsystem
grep -E "testuser|testsystem" /etc/passwd

#2.2.20
sudo userdel testsystem
sudo useradd -r -m -s /bin/bash
ls -l /home
grep "testsystem" /etc/passwd

#2.2.21
grep -E "nologin|false" /etc/passwd
which nologin
which false

#2.2.22
sudo usermod -s /usr/sbin/nologin testuser
su - testuser
sudo -u testuser whoami

#2.2.23
sudo usermod -s /usr/bin/false testuser
su - testuser

#2.2.24
sudo usermod -s /bin/bash testuser
su - testuser
exit

#2.2.25
sudo usermod -s /bin/ls testuser
su - testuser
sudo usermod -s /bin/bash testuser

#2.2.26
sudo groupadd -r testsystemgroup
sudo groupadd testgroup
grep -E "testsystemgroup|testgroup" /etc/group

#2.2.27
grep -E "GID_MIN|GID_MAX|SYS_GID_MIN|SYS_GID_MAX" /etc/login.defs

#2.2.28
sudo useradd -r -g testsystemgroup -s /usr/sbin/nologin -M serviceuser
grep "serviceuser" /etc/passwd

#2.2.29
su - testuser
sudo whoami
exit

#2.2.30
which id
sudo visudo 
testuser ALL=(root) NOPASSWD: /usr/bin/id
su - testuser
sudo id
sudo ls
exit

#2.2.31
sudo visudo
testuser ALL=(root) NOPASSWD: /usr/bin/id, /usr/bin/whoami
su - testuser
sudo id
sudo whoami
sudo ls
exit

#2.2.32
sudo groupadd testadmins
sudo visudo
%testadmins ALL=(root) NOPASSWD: /usr/bin/id
sudo usermod -aG testadmins testuser
su - testuser
sudo id
exit
sudo gpasswd -d testuser testadmins
su - testuser
sudo id
exit


sudo cp /etc/login.defs /etc/login.defs/backup


#2.2.33
cat /etc/login.defs
grep -E "UID|GID|PASS" /etc/login.defs

#2.2.34
tail -n 10 /etc/passwd
sudo nano /etc/login.defs
sudo useradd -m configuser1
id configuser1
sudo userdel -r configuser1
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.35
awk -F: '$3 >= 100 && $3 < 1000 {print $3}' /etc/passwd | sort -n
sudo nano /etc/login.defs
sudo useradd -r sysconfig1
sudo useradd -r sysconfig2
sudo useradd -r sysconfig3
grep "sysconfig" /etc/passwd
sudo userdel sysconfig1
sudo userdel sysconfig2
sudo userdel sysconfig3
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.36
grep -E "GID_MIN|GID_MAX" /etc/login.defs
tail -n 10 /etc/group
sudo nano /etc/login.defs
sudo groupadd configgroup1
grep "configgroup1" /etc/group
sudo groupdel configgroup1
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.37
awk -F: '$3 >= 100 && $3 < 1000 {print $3}' /etc/group | sort -n
sudo nano /etc/login.defs
sudo groupadd -r sysconfiggroup1
sudo groupadd -r sysconfiggroup2
sudo groupadd -r sysconfiggroup3
grep "sysconfiggroup" /etc/group
sudo groupdel sysconfiggroup1
sudo groupdel sysconfiggroup2
sudo groupdel sysconfiggroup3
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.38
sudo nano /etc/login.defs
sudo useradd homeuser1
ls -ld /home/homeuser1
sudo nano /etc/login.defs
sudo useradd homeuser2
ls -ld /home/homeuser2
sudo userdel -r homeuser1
sudo userdel homeuser2
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.39
sudo nano /etc/login.defs
sudo useradd -r syshome1
ls -ld /home/syshome1
sudo useradd -r -m syshome2
ls -ld /home/syshome2
sudo userdel syshome1
sudo userdel -r syshome2
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.40
grep -E "UMASK|HOME_MODE" /etc/login.defs
sudo useradd -m umask_user1
ls -ld /home/umask_user1
sudo nano /etc/login.defs
sudo useradd -m umask_user2
ls -ld /home/umask_user2
sudo userdel -r umask_user1
sudo userdel -r umask_user2
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.41
grep "USERGROUPS_ENAB" /etc/login.defs
sudo useradd -m groupuser1
id groupuser1
grep "groupuser1" /etc/group
sudo nano /etc/login.defs
sudo useradd -m groupuser2
id groupuser2
grep "groupuser2" /etc/group
sudo userdel -r groupuser1
sudo userdel -r groupuser2
sudo cp /etc/login.defs.backup /etc/login.defs

#2.2.42
cat /etc/default/useradd
sudo nano /etc/default/useradd
sudo useradd -m defaultuser1
grep "defaultuser1" /etc/passwd
sudo userdel -r defaultuser1

#2.2.43
sudo mkdir /test
sudo nano /etc/default/useradd
sudo useradd -m defaultuser2
grep "defaultuser2" /etc/passwd
sudo userdel -r defaultuser2
sudo rmdir /test
