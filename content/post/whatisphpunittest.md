+++
description = "What is PHPUnit?"
title = "PHPUnit"
date = 2020-06-16T09:54:47+08:00
tag = ["phpunit", "php"]
author = "Ken Cho"
+++

### What is PHPUnit?
The goal of unit testing is 
>`to isolate each part of the programme and show that the individual parts are correct`.

# What does `Assertions` mean?
Just asserting that something match the expected value or does something you wanted to do.

# Whats the flow of running `phpunit`?
1. Install the [PHPUnit](https://phpunit.readthedocs.io/en/9.2/installation.html)  
2. Configure the `phpunit.xml`  
```xml
<?xml version="1.0" encoding="utf-8" ?>
<phpunit bootstrap="vendor/autoload.php"
         colors="true"
         verbose="true"
         stopOnFailure="false">
     <testsuites>
         <testsuite name="unit">
             <directory>tests/unit</directory>
         </testsuite>
     </testsuites>
</phpunit>
```

3. Create `app`, `app/Models`and `tests/unit` folders  
4. Build codes bite by bite, and then run phpunit  
`./vendor/bin/phpunit`  


### Reference
1. Unit testing with PHPUnit, [Youtube](https://www.youtube.com/watch?v=k9ak_rv9X0Y)
2. [PHPUnit Beginner](https://www.startutorial.com/articles/view/phpunit-beginner-part-1-get-started)
3. [PHPunit docs](https://phpunit.readthedocs.io/en/9.2/installation.html)
