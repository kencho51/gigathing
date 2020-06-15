+++
description = "Docker Introduction"
title = "Docker 101"
date = 2020-06-11T17:27:08+08:00
tags = ["Docker"]
author = "Ken Cho"

+++

![image](https://travis-ci.org/kencho51/gigathing.svg?branch=develop)

### What is Docker?
![img](/image/docker_beginner.webp)

> In simpler words, Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.

>The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development.

>Unlike virtual machines, containers do not have high overhead and hence enable more efficient usage of the underlying system and resources.

![img](/image/docker_os.jpeg)
>Docker runs containers, which use the same host operating system, and only virtualize at a software level.

>Docker Engine runs on Linux, Windows, and macOS, and supports Linux and Windows for Docker containers.

![imag](/image/docker_flow.jpeg)

### Playing with Docker
1. `pull` the image from docker registry  
`docker pull busybox`  
2. list images  
`docker images`  
3. run a docker container based on `busybox` image  
`docker run busybox echo "hello from busybox`   
4. show running containers  
`docker ps`  
`docker ps -a` 
`docker container ls`   
5. go into a docker container  
`docker run -it busybox sh`  
>>Since Docker creates a new container every time, everything will be rebuilt again in each instance.
6. `docker run` multiple times and leaving stray containers will eat up disk space. `docker rm` to clean up containers.  
`docker rm contain-ID`  
`docker rm $(docker ps -a -q -f status=exited)`  
-q: return numeric ID  
-f: filters output based on conditions provided  
`docker container prune` can be used to remove all the stopped containers. 
7. to delete docker images  
`docker rmi`   
8. Build a container from an image and remove it when it exits.  
`docker run --rm image`  
`docker run -d -P --name xxx image`  
`-d`: will detach terminal  
`-p`: publish all exposed port to random ports  
`--name`: container name we want to give   
9. Check the ports, then open `http://localhost:port` in browser.  
`docker port xxx`  
10. to stop a detached container  
`docker stop xxx`  


### Terminology
- `Images`: the blueprints form the basis of containers.  
- `Containers`: created from docker images and run the actual application.  
- `Docker Daemon`: the background service running on the host that manage building, running and distributing docker containers.
- `Docker Client`: The command line tool that allows the user to interact with the daemon.  
- `Docker Hub`: A registry of docker images.  

### Docker Images
Docker images are the basis of containers. To see the list of images that are available locally, use the `docker images` command.

### How to build an image
1. `git clone` [dokcer repo](https://github.com/prakhar1989/docker-curriculum)  
2. `cd docker-curriculum/flask-app`  
3. make `Dockerfile`: a simple text file that contains a list of commands that the Docker client calls while creating an image.
4. create docker image from a `Dockerfile`  
`docker build -t test/flask . `
`-t`: optional tag name  
5. run the image  






### Reference
1. [Docker Containers 101](https://www.youtube.com/watch?v=eGz9DS-aIeY)
2. [Docker curriculum](https://docker-curriculum.com/)
3. [How to write a docker file](https://semaphoreci.com/blog/docker-benefits)
4. [Doker for beginners](https://github.com/groda/big_data/blob/master/docker_for_beginners.md)
5. [What does Docker do, and when should you use it?](https://www.cloudsavvyit.com/490/what-does-docker-do-and-when-should-you-use-it/)
6. [Getting Started with Docker for Developers](https://dev.to/pavanbelagatti/getting-started-with-docker-for-developers-3apo)

