# <div align="center">One-Command</div>

<div align="center">Spins up NGINX and PostgreSQL containers with Ansible using one command.</div>

<div align="center">
 
![One](https://github.com/rehtsira/One-Command/blob/main/images/one.gif)
 
 The one command: `ansible-playbook -vv one.yml --ask-vault-pass`

![Nginx-check](https://github.com/rehtsira/One-Command/blob/main/images/NGINX-check.png) 
 
Verifies that NGINX is returning a webpage with a status code and the HTML elements
 
![PostgreSQL-check](https://github.com/rehtsira/One-Command/blob/main/images/PostgreSQL%20ping.png)  
 
Verifies that PostgreSQL is up and running
 
![Docker-Compose-Process](https://github.com/rehtsira/One-Command/blob/main/images/Docker-Compose%20Processes.png)
 
Checking the running container processes
 
![before-compose](https://github.com/rehtsira/One-Command/blob/main/images/before-compose.gif)
 
Before the NGINX container was brought up
 
![after-compose](https://github.com/rehtsira/One-Command/blob/main/images/after-compose.gif)
 
After the NGINX container was brought up
 
![table-check](https://github.com/rehtsira/One-Command/blob/main/images/postgres-check.gif)
 
A table has already been created with a couple rows

---

 <b> Overview: </b>
 The goal of this project is to spin up NGINX and PostgreSQL containers using Ansible and Docker with one criteria: the deployment of it all should be executed as a single command. To make this possible, Ansible played a vital role. It contains numerous modules to execute what you want done. You could, theoretically, utilize the 'command' module to install packages, copy files, setup docker, and everything. However, you may have to worry about idempotency which is not the approach I wanted in this project. 
</div>
So, I utilized several Ansible modules such as:

uri
- Get HTML content from NGINX

copy
- Copy files such as *create.sql*, *docker-compose.yml*, *index.html* to the remote server

file
- Create a directory to store the files to be copied from /src

docker_compose
 - Execute the docker-compose.yml file that spins up both NGINX and PostgreSQL. Instead of utilizing the docker module, I chose with docker_compose to spin up multiple containers in one go.
 
pip
- Install files using pip such as docker-compose, psycopg2-binary, docker-ce, docker

apt
- Install packages such as aptitude, python3, apt-transport-https, ca-certificates, curl, software-properties-common, gnupg, lsb-release, python3-pip, python3-setuptools

apt_key
- To add Docker's GPG key

apt_repository
 - To add docker repository
 
postgresql_ping
 - Pings the PostgreSQL database to verify that it is online
 
import_playbook
 - The heart and soul of how this project was possible. This executes all of the different playbooks one by one in order from start to finish. 
---
Much like how Ansible has numerous modules, I, too, wanted to modularized all of the tasks. Instead of trying to cram in all of the different Ansible modules into one playbook and running it, I separated each tasks into its own playbook. That way, if there was an issue with a task, I will just need to focus on that one playbook instead of having to re-run the entire automation just to see if it works. This makes it easier to modify the playbook if needed.

To add some security, I also utilized Ansible-Vault to store the SSH password of the remote server. Instead of having to type the password for the remote server (i.e. `ansible-playbook copy-files.yml -kK` which would prompt for the SSH password, `ansible-playbook copy-files.yml --ask-vault-pass` will take care of the rest. 

There is also a file called *env_vars.yml* that stores the environment variables which can be modified in one place if required. If ever additional variables are needed, one can simply add a variable and store it in this file. 

To add more functionality, *create.sql* was created which creates a schema, database, and values which are initially loaded into the PostgreSQL container at startup. If additional tables/records are needed, one can modify this file. 

---
<b> To get started: </b>
Either execute *env_setup.sh* bash script with execute permission to install QEMU/KVM for virtualization along with Ansible or use your own virtual machine manager (VMWare, Hyper-V, VirtualBox). Use an Ubuntu ISO and proceed with the installation process. Once that is complete, establish SSH between the host and remote server by creating an SSH key.

From the Ansible host:
<br>
`ssh-keygen -t rsa` (Press enter twice)
<br>
`cd ~/.ssh`
<br>
`cat id_rsa.pub >> authorized_keys`
<br>
`scp authorized_keys 192.168.122.81:/home/aer/.ssh` (Change the IP address with the IP of your remote server. Also change the home directory of your user)

On the remote server:
`ssh-keygen -t rsa` (Press enter twice)

With git installed, run the command below on */etc/ansible/* (once you have Ansible installed)
`git clone https://github.com/rehtsira/One-Command.git`

In */etc/ansible/playbooks/vars/* directory, create a file called *aerbuntu-pass.yml*. Inside that file, put inside `password: "your_password"` which is the password of your root user of the remote server. Execute the command below: <br>
`ansible-vault encrypt aerbuntu-pass.yml` (It will prompt for a password. This is also the password you will type for `--ask-vault-pass`)

Once this is encrypted, you can go to the playbooks directory (*/etc/ansible/playbooks*) and simply execute `ansible-playbook -vv one.yml --ask-vault-pass`

Watch as an NGINX and PostgreSQL docker containers are created on your remote server using Ansible and with merely one command.
 
 
