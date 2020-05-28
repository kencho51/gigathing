+++
description = " Yii learning progress"
title = "Yii 1.1"
date = 2020-05-27T12:50:48+08:00
tags = ["Yii 1.1"]
author = "Ken Cho"

+++
### What is Yii?

>Yii is a high-performance, component-based PHP framework for developing large-scale Web applications rapidly. 
>It enables maximum reusability in Web programming and can significantly accelerate your Web application development process. 

### What is Yii best for?
>Yii is a generic Web programming framework that can be used for developing virtually any type of Web application. 
>Because it is light-weight and equipped with sophisticated caching mechanisms, it is especially suited to high-traffic applications, such as portals, forums, content management systems (CMS), e-commerce systems, etc.
### Set up webserver with nginx and PHP-FPM using Docker, [link](https://medium.com/@isakhauge/create-a-basic-web-server-with-nginx-and-php-fpm-using-docker-5def5c32e628)
1. Build the images  
`sudo docker build -t peter/fpm ./images/fpm/ && docker build -t peter/ngx ./images/nginx/`

2. Build and start the container  
`docker-compose up`

### Installation and create skeleton application, [link](https://www.yiiframework.com/doc/blog/1.1/en/start.testdrive#user-notes)
1. download Yii 1.1 source code at [here](https://www.yiiframework.com/download)
2. unpack the .tar.gz and move to dockerfolder/app/ 
 `tar -xvzf yii-1.1.22.bf1d26.tar.gz`  
3. go into the framework folder  
 `./yiic webapp ../testdrive`  

### Update the ngx_conf/locations.conf
```
# yii-1.1.22 location
location /yii-1.1.22/ {
    autoindex on;
    autoindex_exact_size on;
    autoindex_format html;
    autoindex_localtime on;
} 
```

### Make sqlite db connection in protected/config/main.php 
```
return array(
// sqlite database connection
    'components'=>array(
        'db'=>array(
            'connectionString'=>'sqlite:protected/data/testdrive.db',
        ),
    ),
);
```
