+++
description = "Commands for running and testing Local gigaDB"
title = "Commands use to run gigadb"
date = 2020-07-24T16:03:12+08:00
tags = ["gigadb", "yii2", "docker", "psql"]
author = "Ken Cho"

+++  
### To start a local gigaDB server
`docker-compose run --rm webapp`  
[Link](http://gigadb.gigasciencejournal.com:9170/) to test if the web page is up
 
### If there are some build errors
1. Rebuild and up the webapp containers again.  
`docker-compose run --rm webapp`  
2. If not work, `restart` the docker container app and rebuild the containers.  
3. If not work, check if psql, `gigadb`, database is presented in `~/.containers/-data` and remove it.  
`rm -rf ~/.containers-data/gigadb`
4. Run `docker-compose run --rm webapp` again to rebuild the containers.  

### How to remove images
1. List all images  
`docker images -a`  
2. Remove all images  
`docker rmi $(docker images -a -q)`  

### How to remove container
1. List all containers  
`docker ps -a`  
2. Stop the containers  
`docker stop $(docker ps -a -q)`    
2. Remove stopped containers  
`docker rm $(docker ps -a -q)`  
[source](https://linuxize.com/post/how-to-remove-docker-images-containers-volumes-and-networks/)  
[digital ocean](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)  

### How to run a functional test in a docker environment for testing?
1. Write unit test script and place in `protected/tests/functional-test` folder.
2. Change the `unit_functional` script
`./bin/phpunit protected/tests/functional-test  --verbose --configuration protected/tests/phpunit.xml --no-coverage`
3. Run specific unit test:  
`docker-compose run --rm test ./tests/unit_functional`
4. Output will be like this:
```bash
PHPUnit 5.7.27 by Sebastian Bergmann and contributors.

Runtime:       PHP 7.1.30 with Xdebug 2.9.6
Configuration: /var/www/protected/tests/phpunit.xml

...                                                                 3 / 3 (100%)

Time: 7.15 seconds, Memory: 14.00MB

OK (3 tests, 7 assertions)
```

### How to run a functional test on a single file in docker environment?
1. docker oneliner  
`docker-compose run --rm test ./bin/phpunit --testsuite functional --bootstrap protected/tests/bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/functional/AdminSiteAccessTest.php`  
2. Or go into docker bash and run `phpunit`  
`docker-compose run --rm test bash`  
`root@45a46a8441d3:/var/www# ./bin/phpunit --testsuite functional --bootstrap protected/tests/bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/functional/AdminSiteAccessTest.php`  
```bash
root@45a46a8441d3:/var/www# ./bin/phpunit --testsuite functional --bootstrap protected/tests/bootstrap.php --verbose --configuration protected/tests/phpunit.xml --no-coverage protected/tests/functional/AdminSiteAccessTest.php

PHPUnit 5.7.27 by Sebastian Bergmann and contributors.

Runtime:       PHP 7.1.30 with Xdebug 2.9.6
Configuration: /var/www/protected/tests/phpunit.xml

...                                                                 3 / 3 (100%)

Time: 4.18 seconds, Memory: 14.00MB

OK (3 tests, 7 assertions)
```

### How to run a Behat test in a docker environment for testing
1. Update the `scenario syntax` specific *.feature file, like:  
```gherkin
@ok @files
	Scenario: Files - Call to Actions
		Given I am not logged in to Gigadb web site
		When I go to "/dataset/101001"
		And I follow "Files"
		Then I should see a link "(FTP site)" to "ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/" with title "FTP site"
		Then I should see a button "Table Settings"
```
2. Check if related functions in `features/bootstrap/*.php` needed to be updated, eg:
```php
public function iShouldSeeTabWithTable($arg1, TableNode $table)
    {
        if ("Funding" == $arg1) {
            $this->minkContext->getSession()->getPage()->clickLink($arg1);
            //| Funding body                    | Awardee           | Award ID      | Comments |
            foreach($table as $row) {
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Funding body'])
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Awardee'])
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Award ID'])
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Comments'])
                );
            }
        }
        elseif("Files" == $arg1) {
            //| File name                                        | Sample ID  | Data Type         | File Format | Size      | Release date | link |
            foreach($table as $row) {
                $link = $row['link'];
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['File name']), "File name match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Sample ID']), "Sample ID match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Data Type']), "Data Type match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['File Format']), "File Format match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Size']), "Size match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Release date']), "Release date match"
                );
                if ($link) {
                    $this->minkContext->assertSession()->elementExists('css',"a.download-btn[href='$link']");
                }
            }
        }
        elseif("Sample" == $arg1) {
            //| Sample ID  | Common Name  | Scientific Name         | Sample Attributes                                                                                                                   | Taxonomic ID | Genbank Name |
            foreach($table as $row) {
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Sample ID']), "Sample ID match"
                );
                if($row['Common Name']) {
                    PHPUnit_Framework_Assert::assertTrue(
                        $this->minkContext->getSession()->getPage()->hasContent($row['Common Name']), "Common Name match"
                    );
                }
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Scientific Name']), "Scientific Name match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Sample Attributes']), "Sample Attributes match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Taxonomic ID']), "Taxonomic ID match"
                );
                PHPUnit_Framework_Assert::assertTrue(
                    $this->minkContext->getSession()->getPage()->hasContent($row['Genbank Name']), "Genbank Name match"
                );
            }
        }
        else {
            PHPUnit_Framework_Assert::fail("Unknown type of tab");
        }
    }
```
3. Assign @wip tag to the working scenario in .feature file, this can smooth the running of behat test.  
```gherkin
@wip @files
	Scenario: Files - Call to Actions
		Given I am not logged in to Gigadb web site
		When I go to "/dataset/101001"
```

4. Run the Behat test command on specific scenario.  
`docker-compose run --rm test bin/behat -vv --stop-on-failure --tags @wip`

5. Or can first shell into test container and then run the command:  
```bash
$ docker-compose run --rm test bash
root@2f0dd679a934:/var/www# bin/behat --tags @wip
```


### How to connect postgreSQL in PhpStorm
1. Click Database top right of PhpStorm screen.  
2. Data Source chose `postgreSQL` and input following information:  
    - Host: localhost
    - Port: 54321
    - User: gigadb
    - pw:
    - URL: `jdbc:postgresql://localhost:54321/gigadb`


### Reference
1. [Run specific behat test](https://github.com/gigascience/gigadb-website/issues/356)
2. [gigaDB github](https://github.com/gigascience/gigadb-website/tree/develop)


[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


