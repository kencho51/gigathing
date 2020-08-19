+++
description = "Pagination - Go to page button"
title = "How to make go to page feature"
date = 2020-08-18T12:15:31+08:00
tags = ["Yii", "JavaScript","#437"]
author = "Ken Cho"

+++  
### Problem
1. To add a go to page feature in navigating file table. 
2. Details refer to this issue [View files from large db #437](https://github.com/gigascience/gigadb-website/issues/437)

### How
1. Create a `Go to page` button
    - match the button style with the whole webpage
    - create `btn_click` class for this onclick button
    - create input box for `number`, and assign `id=pageTarget`
```html
<style>
    .btn_click {
        border: solid 1px #0eb23c;
        color: #0fad59;
        padding: 4px 6px 3px 6px;
        text-decoration: none;
        background-color: Transparent;
        outline:none;
    }
    input {
        width: 3%;
    }
    input::-webkit-outer-spin-button,
    input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    .text_box {
        color: #0fad59;
        background: #fff;
        border: solid 1px #0eb23c;
        outline:none;
    }
</style>
<button class="btn_click" onclick="goToPage()"><strong>Go to page</strong></button>
<input type="number" id="pageTarget" class="text_box">
<a class="color-background"><strong> of <?= $files->getDataProvider()->getPagination()->getPageCount()?></strong></a>
```

2. Create a `goToPage()` function in `JavaScript`
    - `document.getElementById('pageTarget').value` gets the value of the input box
    - `<?php echo $model->identifier?>` gets the paper ID number
    - `<?php echo $files->getDataProvider()->getPagination()->getPageCount()?>` gets the max page count
    - some requirements:
        - disable input box arrows
        - when userInput > max, return to max
        - when userInput < min, return to min
    - `window.location.pathname` will get current page `url`, will crash when `go to page 2 and then press 1`
        - so to create an array with default values: 
        - `let targetUrlArray = ["", "dataset", "view", "id", pageID];`
    
```javascript
    function goToPage() {
        var targetPageNumber = document.getElementById('pageTarget').value;
        var pageID = <?php echo $model->identifier?>;
        //To validate page number
        var userInput = parseInt(targetPageNumber);
        var max = <?php echo $files->getDataProvider()->getPagination()->getPageCount() ?>;
        //To output total pages
        // console.log(max);
        var min = 1;
        if (userInput >= min && userInput <= max) {
            console.log("Valid page number!");
        }else if (userInput > max) {
            targetPageNumber = max;
            console.log("Error, return to " + max);
        } else if (userInput < min) {
            targetPageNumber = min;
            console.log("Error, return to " + min);
        }
        // var targetUrlArray = Array.apply(null, Array(5)).map(function(_,i) { return window.location.pathname.split("/")[i]});]
        // Create array with default values
        let targetUrlArray = ["", "dataset", "view", "id", pageID];
        targetUrlArray.push('Files_page', targetPageNumber);
        window.location = window.location.origin + targetUrlArray.join("/");
        // Uncomment will show the target url in console.
        // console.log(window.location.origin + targetUrlArray.join("/"))
    }
```
### Behat test
1. Test the `Go to page` button
```gherkin
@done @files @javascript @pr437
	Scenario: Files - Pagination
		Given I am not logged in to Gigadb web site
		And I am on "/dataset/101001"
		And I follow "Files"
		Then I should see an onclick button "Go to page"
		When I input page number 2
		Then I should see "Files" tab with table
		| File name | Sample ID | Data Type | File Format 	| Size | Release date | link |
		| pre_03AUG2015_update 								|				| Directory 		| UNKNOWN 		| 50.00 MiB 	| 2015-08-03  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/pre_03AUG2015_update |
		| readme.txt 										|				| Readme 			| TEXT 			| 337 B 		| 2013-01-23  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/readme.txt |
		When I input page number 1
		Then I should see "Files" tab with table
		| File name              							| Sample ID  	| Data Type       	| File Format 	| Size  		| Release date| link |
		| Anas_platyrhynchos.cds 							| Pekin duck 	| Coding sequence  	| FASTA 	   	| 21.50 MiB     | 2015-08-03  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos.cds |
		| Anas_platyrhynchos.gff 							| Pekin duck 	| Annotation 		| GFF        	| 10.10 MiB 	| 2015-08-03  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos.gff |
		| Anas_platyrhynchos.pep 							| Pekin duck 	| Protein sequence 	| FASTA      	| 7.80 MiB  	| 2015-08-03  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos.pep |
		| Anas_platyrhynchos_domestica.RepeatMasker.out.gz 	| Pekin duck 	| Other 			| UNKNOWN    	| 7.79 MiB  	| 2015-03-23  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/Anas_platyrhynchos_domestica.RepeatMasker.out.gz |
		| duck.scafSeq.gapFilled.noMito 					| Pekin duck 	| Sequence assembly	| FASTA 		| 1.03 GiB 		| 2013-01-23  | ftp://climb.genomics.cn/pub/10.5524/101001_102000/101001/duck.scafSeq.gapFilled.noMito |

```

2. Test the `Go to page` button and the `page number`



### Done


### Reference


[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


