+++
description = "Learning PHP at Codecademy"
title = "PHP progress"
date = 2020-05-19T17:48:07+08:00
tags = ["php", "develop"]
author = "Ken Cho"

+++
### Learning PHP at [Codecademy](https://www.codecademy.com/learn/learn-php)

##### Topics
1. String and variables - Done  
2. Number - Done  
3. Functions - Done  
4. Intro to Built-in PHP functions - Done  
    - find variable types  
    ```gettype(); var_dump();```  
    - string functions  
    ```strrev();strtolower(); strtoupper(); str_repeat();```
    - substring  
    ```substr_count();```
    - number function  
    ```abs(); round();```
    - generating random numbers  
    ```rand(); getrandmax(); ceil();```  
    - documentation  
    ```str_pad();```


5. Ordered Arrays 
    - can be integer or string or any data type    
    ```$my_array = array(); or $my_array=[];```       
    - returns the array length  
    ```count($array);```      
    - print the array in  array list  
    ```print_r();```      
    - print the array into string  
    ```implode ("glue", array);```  
    - accessing the array  
    ```$my_array[pos];```  
    - adding and changing elements
    ```$my_array[pos] = new value;```  
    - pushing and popping  
        - remove the last element  
        ```array_pop();```  
        - append the element
        ```array_push();```  
        - remove first element  
        ```array_shift();```  
        - prepend the element  
        ```array_unshit();```       
        - remove the first element  
        ```array_shift();``` 
        - nestede array  
        ```value = $my_array[][][]```  

6. Associative Arrays 
        - concept of dictionary   
        - key and valure pair  
        ```$my_array = array("key"=>"value"); or $my_array = ["key"=>"value"];```   
        - remove element  
        ```unset();```  
        - joining the array in union manner  
        - assign by reference

  
`function changeArrayValue(&$new)`         
`{`      
` $new["new"] = "old";`       
` return $new;`    
`};`    


7. PHP and HTML  
    7.1 PHP was designed as a back-end web development language  
    7.2 HTML is a front-end language  
    7.3 example code  

`<?php`       
  `echo "<h3>Hello! I'm {$about_me["name"]}!</h3>";`    
  `echo "<p> I'm " . calculateAge($about_me). " years old! That's pretty cool, right?</p>";`   
  `echo "<div>What more is there to say? I love {$about_me["favorite_food"]}, and that's pretty much it!</div>";`    
`?>`    


  
8. HTML From Handling in PHP  
9. Booleans and Comparision operators  
10. Logical Operators and Compound Conditions  
11. Loops  
12. Loops in HTML  
13. Intro to form validation  
14. Intro to Regular expression  
15. Intro to PHP form validation  
16. Classes and Object  


