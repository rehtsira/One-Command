# <div align="center">One-Command</div>

<div align="center">Spins up NGINX and PostgreSQL containers with Ansible using one command.</div>

<div align="center">
 
![One](https://github.com/rehtsira/One-Command/blob/main/images/one.gif)
 
 Execute `ansible-playbook -vv one.yml --ask-vault-pass`

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
</div>
---

 <b> Overview </b>
 The goal of this project is to spin up NGINX and PostgreSQL containers using Ansible and Docker with one criteria: the deployment of it all should be executed as a single command. To make this possible, Ansible played a vital role. It contains numerous modules to execute what you want done. You could, theoretically, utilize the 'command' module to install packages, copy files, setup docker, and everything. However, you may have to worry about idempotency which is not the approach I wanted in this project. 
 
 So, I utilized several Ansible modules such as:
 
<b>uri</b>
* Get HTML content from NGINX
 <b>copy</b>
* Copy files such as *create.sql*, *docker-compose.yml*, *index.html* to the remote server
file
* Create a directory to store the files to be copied from /src
docker_compose
 - Execute the docker-compose.yml file that spins up both NGINX and PostgreSQL
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
 
 
 
