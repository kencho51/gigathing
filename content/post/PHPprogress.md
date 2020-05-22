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
    `gettype(); var_dump();`    
    - string functions  
    `strrev();strtolower(); strtoupper(); str_repeat();`  
    - substring  
    `substr_count();`  
    - number function  
    `abs(); round();`  
    - generating random numbers  
    `rand(); getrandmax(); ceil();`  
    - documentation  
    `str_pad();`  
    - check value in array\
    `in_array("valuetocheck", $array)`


5. Ordered Arrays 
    - can be integer or string or any data type    
    `$my_array = array(); or $my_array=[];`       
    - returns the array length  
    `count($array);`        
    - print the array in  array list  
    `print_r();`      
    - print the array into string  
    `implode ("glue", array);`  
    - accessing the array  
    `$my_array[pos];`  
    - adding and changing elements
    `$my_array[pos] = new value;`  
    - pushing and popping  
        - remove the last element  
        `array_pop();`  
        - append the element
        `array_push();`  
        - remove first element  
        `array_shift();`  
        - prepend the element  
        `array_unshit();`       
        - remove the first element  
        `array_shift();` 
        - nestede array  
        `value = $my_array[][][]`  

6. Associative Arrays 
        - concept of dictionary   
        - key and valure pair  
        `$my_array = array("key"=>"value"); or $my_array = ["key"=>"value"];`   
        - remove element  
        `unset();`  
        - joining the array in union manner  
        - assign by reference
```
function changeArrayValue(&$new) 
{
 $new["new"] = "old";
 return $new;
};
```

7. PHP and HTML  
    7.1 PHP was designed as a back-end web development language  
    7.2 HTML is a front-end language  
    7.3 example code  
```
<?php 
  echo "<h3>Hello! I'm {$about_me["name"]}!</h3>";
  echo "<p> I'm " . calculateAge($about_me). " years old! That's pretty cool, right?</p>";
  echo "<div>What more is there to say? I love {$about_me["favorite_food"]}, and that's pretty much it!</div>"; 
?>
```    
  
8. HTML From Handling in PHP, `Superglobals` 
    8.1 `<?=` is shorthand for `<?php echo`  
    8.2 `$_GET` is an associative array containing data from a GET request.  
    8.3 `$_POST` is an associative array containing data from a POST request.  
    8.4 `$_REQUEST`is an associative array containing data from both GET and POST requests.  
    8.5 eg. `<form method="get" or "post" action="greet.php">` 
  
9. Booleans and Comparision operators   
    9.1 identical and not identical operators
        `===`  or `!==`  
    9.2 built-in function to get current month  
        `date("F")`  
    9.3 multiple condition  
        `elseif(condition){action;}`    
    9.4 switch statement
```    
switch($condition){
    case "condition A":
        echo "action":  
        break;
```   
    9.5 ternary operator  
```
function ternaryCheckout($items) 
{ 
    return $items <= 12 ? "express lane" : "regular lane";
}
```
10. Logical Operators and Compound Conditions  
    10.1 `&&` has higer precedence than `||`\
    10.2 `T || T` is True, `T xor T` is False\
11. Loops  
    11.1 while loop  
    11.2 do...while loop,`the loop will execute at least one time`  
    11.3 for loop  
    11.4 foreach  
    11.5 break and continue  
        11.5.1 `break`: execute, stop and leave  
        11.5.2 `continue`: skip and move on  
12. Loops in HTML  
    12.1 `foreach`  
```
<?php
$footwear = [
  "sandals" => 4,
  "sneakers" => 7,
	"boots" => 3
];
?>
<p>Our footwear:</p>
<h3>foreach</h3>
<?php
foreach ($footwear as $type => $brands):
?>
<p>We sell <?=$brands?> brands of <?=$type?></p>
<?php
endforeach;
?>
```   
\
        12.2 `for`

```
<h3>for</h3>
<?php
$types = [
  "sandals",
  "sneakers",
	"boots"
];
$quantities = [
  4,
  7,
	3
];
for ($i=0; $i<count($types); $i++):
?>
<p>We sell <?=$quantities[$i]?> brands of <?=$types[$i]?></p>
<?php
endfor;
?>
```
\
    12.3 `while`

```
<h3>while</h3>
<?php
$types = [
  "sandals",
  "sneakers",
	"boots"
];
$quantities = [
  4,
  7,
	3
];
$i = 0;
while ($i<count($types)):
?>
<p>We sell <?=$quantities[$i]?> brands of <?=$types[$i]?></p>
<?php
$i++;
endwhile;
?>
```  

13. Intro to form validation  
14. Intro to Regular expression 
    - eg. regex to match the following pattern  
    `^[\d|\(][\s|\d]\d[.|\d|-][\)|\d][\s|\d]\d[.|\d|-]\d[\s|\d]?\d*`    
```
718-555-3810
9175552849
1 212 555 3821
(917)5551298
212.555.8731
``` 
15. Intro to PHP form validation  
16. Classes and Object  

