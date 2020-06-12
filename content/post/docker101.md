+++
description = "Docker Introduction"
title = "Docker 101"
date = 2020-06-11T17:27:08+08:00
tags = ["Docker"]
author = "Ken Cho"

+++
### What is Docker?
![img](/image/docker_beginner.webp)

> In simpler words, Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.

>The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development.

>Unlike virtual machines, containers do not have high overhead and hence enable more efficient usage of the underlying system and resources.

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

### Terminology
- `Images`: the blueprints form the basis of containers.  
- `Containers`: created from docker images and run the actual application.  
- `Docker Daemon`: the background service running on the host that manage building, running and distributing docker containers.
- `Docker Client`: The command line tool that allows the user to interact with the daemon.  
- `Docker Hub`: A registry of docker images.  


### Reference
1. [Docker Containers 101](https://www.youtube.com/watch?v=eGz9DS-aIeY)
2. [Docker curriculum](https://docker-curriculum.com/)
