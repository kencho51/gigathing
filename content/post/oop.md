+++
description = "Wha is Object Oriented Programming?"
title = "OOP"
date = 2020-05-26T10:13:43+08:00
tags = ["OOP", "php"]
author = "Ken Cho"

+++
### What is OOP?
Object-oriented programming is a style of coding that allows developers to group similar tasks into classes. This helps keep code following the tenet "don't repeat yourself" (DRY) and easy-to-maintain.
>Object-oriented programming is a style of coding that allows developers to group similar tasks into classes.
### What is a class?
>A `blueprint for a house`. It defines the shape of the house on paper, with relationships between the different parts of the house clearly defined and planned out, even though the house doesn't exist.
### What is an object?
>An objectis like the `actual house` built according to that blueprint. The data stored in the object is like the wood, wires, and concrete that compose the house: without being assembled according to the blueprint, it's just a pile of stuff. However, when it all comes together, it becomes an organized, useful house.

### WHy OOP is so powerful?
`Classes form the structure of data and actions` and use that information `to build objects`. `More than one object` can be built from the `same class` at the `same time`, each one `independent` of the others.
`OOP keeps objects as separate entities.`
### Some useful terms and syntax
1. `class MyClass {}`
2. `public`: determine the visiblity of the property.  
3. `->`: accesses the contained properties and methods of a given object.  
4. `$this`: When working within a method, use $this in the same way you would use the object name outside the class.   
### Example code
```
<?php
 
class MyClass
{
  public $prop1 = "I'm a class property!";
 
  public function setProperty($newval)
  {
      $this->prop1 = $newval;
  }
 
  public function getProperty()
  {
      return $this->prop1 . "\n";
  }
}
 
// Create two objects
$obj = new MyClass;
$obj2 = new MyClass;
 
// Get the value of $prop1 from both objects
echo $obj->getProperty();
echo $obj2->getProperty();
 
// Set new values for both objects
$obj->setProperty("I'm a new property value!");
$obj2->setProperty("I belong to the second instance!");
 
// Output both objects' $prop1 value
echo $obj->getProperty();
echo $obj2->getProperty();
 
?>
```
The above code will return as below:  
>I'm a class property!  
>I'm a class property!  
>I'm a new property value!  
>I belong to the second instance  

### What are the Magic Methods in OOP in PHP?
[link](https://code.tutsplus.com/tutorials/object-oriented-php-for-beginners--net-12762)

### Comparing Object Oriented and Procedural Code
##### The Procedural Approach
```
<?php
 
function changeJob($person, $newjob)
{
  $person['job'] = $newjob; // Change the person's job
  return $person;
}
 
function happyBirthday($person)
{
  ++$person['age']; // Add 1 to the person's age
  return $person;
}
 
$person1 = array(
  'name' => 'Tom',
  'job' => 'Button-Pusher',
  'age' => 34
);
 
$person2 = array(
  'name' => 'John',
  'job' => 'Lever-Puller',
  'age' => 41
);
 
// Output the starting values for the people
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
// Tom got a promotion and had a birthday
$person1 = changeJob($person1, 'Box-Mover');
$person1 = happyBirthday($person1);
 
// John just had a birthday
$person2 = happyBirthday($person2);
 
// Output the new values for the people
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
?>
```
The code above will output:
```
Person 1: Array
(
  [name] => Tom
  [job] => Button-Pusher
  [age] => 34
)
Person 2: Array
(
  [name] => John
  [job] => Lever-Puller
  [age] => 41
)
Person 1: Array
(
  [name] => Tom
  [job] => Box-Mover
  [age] => 35
)
Person 2: Array
(
  [name] => John
  [job] => Lever-Puller
  [age] => 42
)
``` 
##### The OOP Aproach
```
<?php
 
class Person
{
  private $_name;
  private $_job;
  private $_age;
 
  public function __construct($name, $job, $age)
  {
      $this->_name = $name;
      $this->_job = $job;
      $this->_age = $age;
  }
 
  public function changeJob($newjob)
  {
      $this->_job = $newjob;
  }
 
  public function happyBirthday()
  {
      ++$this->_age;
  }
}
 
// Create two new people
$person1 = new Person("Tom", "Button-Pusher", 34);
$person2 = new Person("John", "Lever Puller", 41);
 
// Output their starting point
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
// Give Tom a promotion and a birthday
$person1->changeJob("Box-Mover");
$person1->happyBirthday();
 
// John just gets a year older
$person2->happyBirthday();
 
// Output the ending values
echo "<pre>Person 1: ", print_r($person1, TRUE), "</pre>";
echo "<pre>Person 2: ", print_r($person2, TRUE), "</pre>";
 
?>
```
The code above will output:
```
Person 1: Person Object
(
  [_name:private] => Tom
  [_job:private] => Button-Pusher
  [_age:private] => 34
)
 
Person 2: Person Object
(
  [_name:private] => John
  [_job:private] => Lever Puller
  [_age:private] => 41
)
 
Person 1: Person Object
(
  [_name:private] => Tom
  [_job:private] => Box-Mover
  [_age:private] => 35
)
 
Person 2: Person Object
(
  [_name:private] => John
  [_job:private] => Lever Puller
  [_age:private] => 42
)
```


### Reference 
1. [Object-Oriented PHP for Beginners](https://code.tutsplus.com/tutorials/object-oriented-php-for-beginners--net-12762)
2. [OOP](https://searchapparchitecture.techtarget.com/definition/object-oriented-programming-OOP) 
