+++
description = "Steps to review fuw-cicd"
title = "How to Review Fuw Cicd"
date = 2021-05-20T11:45:59+08:00
tags = ["fuw"]
author = "Ken Cho"

+++  
# PR546 details at [here](https://github.com/gigascience/gigadb-website/pull/546)

# Suggestion from Rija, google [doc](https://docs.google.com/document/d/1Ns_OkaRn6mXtcDW37JbrSGZzILzFRGPZJQ2oPe2EuSw/edit)
here's a suggestion on how to review and merge

0. Me: Rebase the latest change (the "Use CSV file to provide data for test" PR I saw you've just merged Peter)

1. You: get the branch deployed and working (all tests passing and deployed to AWS)

2. You: make a list of areas of the codebase that you think was changed or added

3. Me: I'll add additional/orthogonal areas to the list I think are missing/worth talking about  if any

4. All of us: for each area, we organise meetings over Zoom (one per area or we bundle areas whenever it makes sense) for a group code review of that area(s) where I walk you through the changes.

5. All of us: you spend more time in areas you want to understand more while I make the changes necessary at this time resulting from any eventual feedback

6. You: merge the resulting branch to "develop"

## Progress
- [x] 0. Clone the repo to local
- [ ] 1. Building Stage
- [ ] 2. Go through the steps mentioned in the FUW workflow [video](https://drive.google.com/file/d/1kkMMApX0J8Fcyt8ftwCe2PKPrtu5rQ6N/view?usp=sharing)
- [ ] 3. Pass Unit test
- [ ] 4. Pass Functional test
- [ ] 5. Pass Acceptance test

### Steps to review - Clone the repo
1. Clone the target repo
   `git clone https://github.com/rija/gigadb-website.git`

2. Set the upstream
   `git remote add upstream https://github.com/gigascience/gigadb-website.git`

3. Sync the local `develop` with `upstream/develop`
```
git checkout develop
git fetch upstream
git rebase upstream/develop
```

4. Sync the feature branch `fuw-cicd` with local `develop`
```
git checkout fuw-cicd
git fetch origin
git rebase develop
```

##### Review 1 
To fix a merge conflict,
```
Auto-merging protected/components/StoredDatasetConnections.php
CONFLICT (content): Merge conflict in protected/components/StoredDatasetConnections.php
error: could not apply 57148420d... Fix acceptance tests and alleviate DOI resolver timeout
```

`git rebase --continue`

### Steps to review - Buiding Stage

1. List, stop and remove all running containers
```
docker ps
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
```

2. Get started
   `./up.sh`

```bash
+ echo 'Starting all services...'
Starting all services...
+ docker stop socat
Error response from daemon: No such container: socat
+ docker run --name socat -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:2375:2375 bobrik/socat TCP-LISTEN:2375,fork UNIX-CONNECT:/var/run/docker.sock
Unable to find image 'bobrik/socat:latest' locally
latest: Pulling from bobrik/socat
Image docker.io/bobrik/socat:latest uses outdated schema1 manifest format. Please upgrade to a schema2 image for better future compatibility. More information at https://docs.docker.com/registry/spec/deprecated-schema-v1/
de1f1ae900b1: Pull complete 
0ddb9b45f8f3: Pull complete 
a3ed95caeb02: Pull complete 
Digest: sha256:afea7dbd06940b9979cec0f1b9e8ccb7111d6feb671687ba9281a57136c1564e
Status: Downloaded newer image for bobrik/socat:latest
83195d9bf8b947adaaccd46fce33100952746bdcdf0e5b263388381f6fd29153
+ '[' -f ./.env ']'
+ read -sp 'To create .env, enter your private gitlab token and name of the name of your fork on GitLab: ' token
To create .env, enter your private gitlab token and name of the name of your fork on GitLab:
```

##### Review 2 
`To create .env, enter your private gitlab token and name of the name of your fork on GitLab: ` is not clear, change it to:  
`To create .env, enter your private gitlab token`  

```text
Variables to create .env 
name of your fork on GitLab: kencho51-gigadb-website
private gitlab token: bxEkhUaWRpLNLrm7nYnQ
```

3. Rerun `./up.sh`
```bash
+ echo 'Starting all services...'
Starting all services...
+ docker stop socat
socat
+ docker rm socat
socat
+ docker run --name socat -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:2375:2375 bobrik/socat TCP-LISTEN:2375,fork UNIX-CONNECT:/var/run/docker.sock
9d27b8fcc8698924d73cc1a6deabb9a3272acbfdfdca29fb7f3ce41a974b17ce
+ '[' -f ./.env ']'
+ read -sp 'To create .env, enter your private gitlab token and name of the name of your fork on GitLab: ' token
To create .env, enter your private gitlab token and name of the name of your fork on GitLab: + read -p 'To create .env, enter the name of your fork on GitLab: ' reponame
To create .env, enter the name of your fork on GitLab: kencho51-gigadb-website
+ cp ops/configuration/variables/env-sample .env
+ sed -i.bak s/#GITLAB_PRIVATE_TOKEN=/GITLAB_PRIVATE_TOKEN=bxEkhUaWRpLNLrm7nYnQ/ .env
+ sed -i.bak 's/REPO_NAME="<Your fork name here>"/REPO_NAME="kencho51-gigadb-website"/' .env
+ rm .env.bak
+ docker-compose run --rm config
Creating deployment_config_run ... done
Current working directory: /var/www
An .env file is present, sourcing it
Running /var/www/ops/scripts/generate_config.sh for environment: dev
Retrieving variables from https://gitlab.com/api/v4/groups/gigascience/variables?per_page=100
jq: error (at <stdin>:0): Cannot index string with string "key"
```

##### Problem
`curl -s --header "PRIVATE_TOKEN:bxEkhUaWRpLNLrm7nYnQ" "https://gitlab.com/api/v4/groups/gigascience/variables?per_page=100"` is 
```json
{"message":"401 Unauthorized"}
```


4. `postgresql-client-9.4 is not available` error when runing `docker-compose build web test console`
```
Package postgresql-client-9.4 is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Package 'postgresql-client-9.4' has no installation candidate
ERROR: Service 'test' failed to build : The command '/bin/sh -c if [ ${INSTALL_PG_CLIENT} = true ]; then     mkdir -p /usr/share/man/man1 &&     mkdir -p /usr/share/man/man7 &&     apt-get update -yq &&     apt-get install -y postgresql-client-${PG_CLIENT_VERSION} ;fi' returned a non-zero code: 100
```



### Reference


[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

