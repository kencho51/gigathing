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
- Precise and concise description of the changes.
 
6.7 Delete the branch if the pull request closed and merged  
```git branch -d issue-no```  


### 7. How to undo commits, steps follow [here](https://devconnected.com/how-to-undo-last-git-commit/)  

7.1 To undo the last commit, for example:    
`git reset --hard HEAD~1`  
`git push --force`  

### 8. How to [sync with Fork repo](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork) after making a successful pull request  
`git checkout develop`  
`git fetch upstream` to see any updates from the develop fork   
`git merge upstream/develop` to get the updates from develop fork to local  
`git push` to update the remote repo  

### 9. How to delete a branch after the issue has been fixed
   
9.1 To list all the branch.  
`git branch --list`  
9.2 To switch to another branch.    
`git checkout branch_name`  
9.3 To delete a branch.  
`git branch -d branch_name_to_delete`  
9.4 To update the remote.  
`git push --force`  
9.5 To delete branch in remote repo manually.  
9.6 To clean up local branch after merging  
`git fetch -p`
