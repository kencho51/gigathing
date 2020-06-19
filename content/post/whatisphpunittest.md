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


### [`doc block`](https://phpunit.readthedocs.io/en/7.3/annotations.html)
As an alternative to prefixing your test method names with `test`, you can use the `@test` annotation in a method’s DocBlock to mark it as a test method.
```php
/**
 * @test
 */
public function initialBalanceShouldBe0()
{
    $this->assertSame(0, $this->ba->getBalance());
}
```
### What are the Assertion methods, [link](https://phpunit.de/manual/6.5/en/appendixes.assertions.html)
 
### Why need namespace? 
Namespaces are basically a way of organizing your PHP classes and preventing from any kind of code conflicts.


### Reference
1. Unit testing with PHPUnit, [Youtube](https://www.youtube.com/watch?v=k9ak_rv9X0Y)
2. [PHPUnit Beginner](https://www.startutorial.com/articles/view/phpunit-beginner-part-1-get-started)
3. [PHPunit docs](https://phpunit.readthedocs.io/en/9.2/installation.html)
4. [w3 PHPUnit tutorial](https://www.w3resource.com/php/PHPUnit/a-gentle-introduction-to-unit-test-and-testing.php)
5. [Interpreting PHPUnit output](https://stackoverflow.com/questions/18142699/interpreting-php-unit-output)
6. [PHPUnit Tutorial notes](https://unityconstruct.org/uc/phpunit)
7. [PHP Documentation](https://manual.phpdoc.org/HTMLSmartyConverter/HandS/phpDocumentor/tutorial_phpDocumentor.howto.pkg.html)