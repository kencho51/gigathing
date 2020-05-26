+++
description = "Yii learning progress"
title = "Yii"
date = 2020-05-26T11:05:40+08:00
tags = ["Yii", "php", "composoer"]
author = "Ken Cho"

+++
### Install Composer via Composer on Mac OS X
`curl -sS https://getcomposer.org/installer | php` 
`sudo mv composer.phar /usr/local/bin/composer`  

### Install Yii
`composer create-project --prefer-dist yiisoft/yii2-app-basic basic` 

### Installing Assets
`Add the following lines to /basic/composer.json`
```
"replace": {
    "bower-asset/jquery": ">=1.11.0",
    "bower-asset/inputmask": ">=3.2.0",
    "bower-asset/punycode": ">=1.3.0",
    "bower-asset/yii2-pjax": ">=2.0.0"
},
```
### Verify the Installation
Go into the basic/  
`php yii serve`  
User browser to access:  
`http://localhost:8080/`

### CHeck if the minimum requirements are met by running
`cd basic`  
`php requirements.php`

### Apache Configuration
Update `/etc/apache2/httpd.conf` accordingly
```
# Set document root to be "basic/web"
DocumentRoot "path/to/basic/web"

<Directory "path/to/basic/web">
    # use mod_rewrite for pretty URL support
    RewriteEngine on
    
    # if $showScriptName is false in UrlManager, do not allow accessing URLs with script name
    RewriteRule ^index.php/ - [L,R=404]
    
    # If a directory or a file exists, use the request directly
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    
    # Otherwise forward the request to index.php
    RewriteRule . index.php

    # ...other settings...
</Directory>
```
