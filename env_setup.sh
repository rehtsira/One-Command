#!/bin/bash

#Install apt packages
apt install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager ssh python3.8 python3-pip software-properties-common -y

#Adding apt repository to install Ansible
add-apt-repository --yes --update ppa:ansible/ansible

#Install Ansible
apt install ansible

#Allow SSH connections
ufw allow ssh

#Adding users to utilize Virtual Machine
adduser 'aer' libvirtd
adduser 'aer' kvm

#Once virtual machine is created with the Ubuntu ISO, set up the SSH keys manually between the host and remote server.
#ssh-keygen -t rsa 
#Cd ~/.ssh
#cat id_rsa.pub >> authorized_keys
#scp authorized_keys 192.168.122.81:/home/aer/.ssh

