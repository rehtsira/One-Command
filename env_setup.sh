#!/bin/bash

#Purpose: Install the required packages to install Virtual Manager and Ansible. After that is complete, a connection must be established between the two servers using ssh-keygen. 

#Adding apt repository to prepare for Ansible installation
add-apt-repository --yes --update ppa:ansible/ansible

#Install apt packages
apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager ssh python3.8 python3-pip software-properties-common ansible -y

#Allow SSH connections
ufw allow ssh

#Adding users to utilize Virtual Machine
adduser 'aer' libvirtd
adduser 'aer' kvm

#Once the virtual machine is created with an Ubuntu ISO, set up the SSH keys manually between the host and remote server with these commands. Change the IP Address with your remote server's IP and also its home directory location of SSH.
#ssh-keygen -t rsa 
#Cd ~/.ssh
#cat id_rsa.pub >> authorized_keys
#scp authorized_keys 192.168.122.81:/home/aer/.ssh

