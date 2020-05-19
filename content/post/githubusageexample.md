+++
description = "How to make changes in gigadb-website repo"
title = "Github usage example"
date = 2020-05-19T15:55:27+08:00
tags = ["github", "gigadb-website", "develop"]
author = "Ken Cho"

+++
## The development cycle of the gigadb.  
 
### 1. fork [gigadb-website](https://github.com/gigascience/gigadb-website)

### 2. clone the gigadb-website into local SSD  
```git clone https://github.com/kencho51/gigadb-website.git```

### 3. add remote origin  
```git remote add origin https://github.com/kencho51/gigadb-website.git```

### 4. add remote upstream origin
```git remote add upstream https://github.com/gigascience/gigadb-website.git```

### 5. follow [here](https://github.com/kencho51/gigadb-website/tree/develop) to build the docker container for the testing.  

### 6. The flow to make changes:  

6.1 Create branch for an issue
```git branch issue-no```  

6.2 Go to that branch  
```git checkout issue-no```  

6.3 Make some changes, save and add the changes      
```git add modifiedfiles```  

6.4 Commit the changes with msg    
```git commit -m 'commit msg'``` 

6.5 Push the changes to the git repo     
```git push```  

6.6 Create pull request to review in web git repo    

6.7 Delete the branch if the pull request closed and merged  
```git branch -d issue-no```  


### 7. How to undo commits, steps follow [here](https://devconnected.com/how-to-undo-last-git-commit/)  
```To undo the last commit```
```eg. git reset --hard HEAD~1```  

