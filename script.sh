#!/bin/bash

# creating user;
useradd webmaster > /dev/null
echo 'Creating user webmaster if needed..................[done]'
# setting password;
# echo "webmaster:Pa$$w0rd" | chpasswd
passwd webmaster
echo 'Creating password for user webmaster..................[done]'
# installing semanage;
yum -y install policycoreutils-python > /dev/null
echo 'Installing semanage if needed..................[done]'
# link user webmaster with selinux user staff_u;
semanage login -a -s staff_u -r s0-s0:c0.c1023 webmaster 
# assigning possible roles for selinux user staff_u;
semanage user -m -R 'staff_r webadm_r system_r' staff_u
echo 'making SELinux magic..................[done]'
# making changes in sudoers config;
echo 'webmaster ALL=(ALL) TYPE=webadm_t ROLE=webadm_r ALL' > /etc/sudoers.d/webmaster  
echo 'Creating sudo rules..................[done]'
