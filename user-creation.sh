#!/bin/bash

set -e

vagrant ssh master <<EOF
    sudo useradd -m -G sudo altschool
    echo -e "password\npassword\n" | sudo passwd altschool 
    sudo usermod -aG root altschool
    sudo useradd -ou 0 -g 0 altschool
    sudo -u altschool ssh-keygen -t rsa -b 4096 -f /home/altschool/.ssh/id_rsa -N "" -y
    sudo cp /home/altschool/.ssh/id_rsa.pub altschoolkey
    sudo ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""
    sudo cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@192.168.20.6 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
    sudo cat ~/altschoolkey | sshpass -p "vagrant" ssh vagrant@192.168.20.6 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
    sshpass -p "password" sudo -u altschool mkdir -p /mnt/altschool/slave
    sshpass -p "password" sudo -u altschool scp -r /mnt/* vagrant@192.168.20.6:/home/vagrant/mnt
    sudo ps aux > /home/vagrant/running_processes
    exit
EOF