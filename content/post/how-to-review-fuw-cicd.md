+++
description = "Steps to review fuw-cicd"
title = "How to Review Fuw Cicd"
date = 2021-05-20T11:45:59+08:00
tags = ["fuw"]
author = "Ken Cho"

+++  
# PR546 details at [here](https://github.com/gigascience/gigadb-website/pull/546), [gist](https://gist.github.com/kencho51/6b5cebd15c9419484e73b2439a34f0d1)

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
- [x] 1. Building Stage
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

0. Remove all existing container database config
`rm -rf ~/.container-data/default-gigadb`  
   
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
private gitlab token:
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

##### Review 3
Request Gitlab permission for `GROUP`   
Update `GROUP_VARIABLES_URL` in `.env`  
`GROUP_VARIABLES_URL="https://gitlab.com/api/v4/groups/gigascience%2FForks/variables?per_page=100"`

4. Rerun `./up.sh`
```bash
+ echo 'Starting all services...'
Starting all services...
+ docker stop socat
socat
+ docker rm socat
socat
+ docker run --name socat -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:2375:2375 bobrik/socat TCP-LISTEN:2375,fork UNIX-CONNECT:/var/run/docker.sock
a57ebfc289c5f1be12506d23db1258b16e35512b3a834bd3882489b17a7b250c
+ '[' -f ./.env ']'
+ docker-compose run --rm config
Creating deployment_config_run ... done
Current working directory: /var/www
An .env file is present, sourcing it
Running /var/www/ops/scripts/generate_config.sh for environment: dev
Retrieving variables from https://gitlab.com/api/v4/groups/gigascience%2FForks/variables?per_page=100
Retrieving variables from https://gitlab.com/api/v4/groups/3501869/variables
Retrieving variables from https://gitlab.com/api/v4/projects/gigascience%2Fforks%2Fkencho51-gigadb-website/variables
Sourcing secrets
Retrieving private_key variable for Google API from https://gitlab.com/api/v4/projects/gigascience%2Fforks%2Fkencho51-gigadb-website/variables
* ---------------------------------------------- *
done.
.
.
.
(Running about 1hour)
.
.
.
+ docker-compose up -d chrome
Creating deployment_chrome_1 ... 

ERROR: for deployment_chrome_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for chrome  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)
ERROR: An HTTP request took too long to complete. Retry with --verbose to obtain debug information.
If you encounter this issue regularly because of slow network conditions, consider setting COMPOSE_HTTP_TIMEOUT to a higher value (current value: 60).

```

`$ docker ps`
```bash
CONTAINER ID   IMAGE                                        COMMAND                  CREATED          STATUS          PORTS                                                        NAMES
e6c266106fc7   selenium/standalone-chrome:3.141.59-oxygen   "/opt/bin/entry_poin…"   13 minutes ago   Up 10 minutes   0.0.0.0:4444->4444/tcp                                       deployment_chrome_1
ee98bde0c32f   deployment_web                               "/usr/local/bin/enab…"   35 minutes ago   Up 35 minutes   0.0.0.0:9170->80/tcp, 0.0.0.0:8043->443/tcp                  deployment_web_1
6465ae74e7f0   deployment_fuw-admin                         "docker-php-entrypoi…"   35 minutes ago   Up 35 minutes   9000/tcp, 9002/tcp                                           deployment_fuw-admin_1
898b9ce82485   deployment_fuw-public                        "docker-php-entrypoi…"   35 minutes ago   Up 35 minutes   9000-9001/tcp                                                deployment_fuw-public_1
4343b2b35e0f   deployment_application                       "docker-php-entrypoi…"   35 minutes ago   Up 35 minutes   9000/tcp                                                     deployment_application_1
6947a60f961f   deployment_console                           "docker-php-entrypoi…"   35 minutes ago   Up 35 minutes   9000-9001/tcp                                                deployment_console_1
9fc5a2a1daa2   deployment_watcher                           "/sbin/boot.sh"          35 minutes ago   Up 35 minutes                                                                deployment_watcher_1
5da97ed07996   deployment_tusd                              "tusd -dir /var/inbo…"   35 minutes ago   Up 35 minutes   1080/tcp                                                     deployment_tusd_1
d23cb014a7c6   postgres:9.6-alpine                          "docker-entrypoint.s…"   35 minutes ago   Up 35 minutes   0.0.0.0:54321->5432/tcp                                      deployment_database_1
8690acc870db   deployment_ftpd                              "/run.sh -l puredb:/…"   35 minutes ago   Up 35 minutes   0.0.0.0:30000-30009->30000-30009/tcp, 0.0.0.0:9021->21/tcp   deployment_ftpd_1
a60fa71c68bc   bobrik/socat                                 "socat TCP-LISTEN:23…"   58 minutes ago   Up 58 minutes   127.0.0.1:2375->2375/tcp                                     socat
```

`$ docker-compose log chrome`
```bash
Attaching to deployment_chrome_1
chrome_1             | 2021-05-21 07:21:57,840 INFO Included extra file "/etc/supervisor/conf.d/selenium.conf" during parsing
chrome_1             | 2021-05-21 07:21:57,846 INFO supervisord started with pid 10
chrome_1             | 2021-05-21 07:21:58,850 INFO spawned: 'xvfb' with pid 13
chrome_1             | 2021-05-21 07:21:58,852 INFO spawned: 'selenium-standalone' with pid 14
chrome_1             | 2021-05-21 07:21:58,858 INFO success: xvfb entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
chrome_1             | 2021-05-21 07:21:58,859 INFO success: selenium-standalone entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
chrome_1             | 2021-05-21 07:21:58,859 INFO exited: xvfb (exit status 0; expected)
chrome_1             | 07:22:00.056 INFO [GridLauncherV3.parse] - Selenium server version: 3.141.59, revision: e82be7d358
chrome_1             | 07:22:00.241 INFO [GridLauncherV3.lambda$buildLaunchers$3] - Launching a standalone Selenium Server on port 4444
chrome_1             | 2021-05-21 07:22:00.335:INFO::main: Logging initialized @1402ms to org.seleniumhq.jetty9.util.log.StdErrLog
chrome_1             | 07:22:00.844 INFO [WebDriverServlet.<init>] - Initialising WebDriverServlet
chrome_1             | 07:22:01.122 INFO [SeleniumServer.boot] - Selenium Server is up and running on port 4444
```

5. After checking, the `deployment_chrome_1` is up and running, so rerun `./up.sh`    
```bash
+ docker-compose exec console /app/yii migrate/fresh --interactive=0
Yii Migration Tool (based on Yii v2.0.42.1)

Exception 'yii\db\Exception' with message 'SQLSTATE[08006] [7] could not translate host name "dockerhost" to address: Name or service not known'

in /app/vendor/yiisoft/yii2/db/Connection.php:649

Caused by: Exception 'PDOException' with message 'SQLSTATE[08006] [7] could not translate host name "dockerhost" to address: Name or service not known'

in /app/vendor/yiisoft/yii2/db/Connection.php:719

Stack trace:
#0 /app/vendor/yiisoft/yii2/db/Connection.php(719): PDO->__construct('pgsql:host=dock...', 'fuw', 'vagrant', NULL)
#1 /app/vendor/yiisoft/yii2/db/Connection.php(638): yii\db\Connection->createPdoInstance()
#2 /app/vendor/yiisoft/yii2/db/Connection.php(1059): yii\db\Connection->open()
#3 /app/vendor/yiisoft/yii2/db/Connection.php(1046): yii\db\Connection->getMasterPdo()
#4 /app/vendor/yiisoft/yii2/db/Schema.php(463): yii\db\Connection->getSlavePdo()
#5 /app/vendor/yiisoft/yii2/db/Connection.php(938): yii\db\Schema->quoteValue('public')
#6 /app/vendor/yiisoft/yii2/db/Command.php(211): yii\db\Connection->quoteValue('public')
#7 /app/vendor/yiisoft/yii2/db/Command.php(1126): yii\db\Command->getRawSql()
#8 /app/vendor/yiisoft/yii2/db/Command.php(1147): yii\db\Command->logQuery('yii\\db\\Command:...')
#9 /app/vendor/yiisoft/yii2/db/Command.php(453): yii\db\Command->queryInternal('fetchAll', 7)
#10 /app/vendor/yiisoft/yii2/db/pgsql/Schema.php(182): yii\db\Command->queryColumn()
#11 /app/vendor/yiisoft/yii2/db/Schema.php(237): yii\db\pgsql\Schema->findTableNames('public')
#12 /app/vendor/yiisoft/yii2/db/Schema.php(780): yii\db\Schema->getTableNames('', false)
#13 /app/vendor/yiisoft/yii2/db/Schema.php(207): yii\db\Schema->getSchemaMetadata('', 'schema', false)
#14 /app/vendor/yiisoft/yii2/console/controllers/MigrateController.php(300): yii\db\Schema->getTableSchemas()
#15 /app/vendor/yiisoft/yii2/console/controllers/BaseMigrateController.php(472): yii\console\controllers\MigrateController->truncateDatabase()
#16 [internal function]: yii\console\controllers\BaseMigrateController->actionFresh()
#17 /app/vendor/yiisoft/yii2/base/InlineAction.php(57): call_user_func_array(Array, Array)
#18 /app/vendor/yiisoft/yii2/base/Controller.php(181): yii\base\InlineAction->runWithParams(Array)
#19 /app/vendor/yiisoft/yii2/console/Controller.php(184): yii\base\Controller->runAction('fresh', Array)
#20 /app/vendor/yiisoft/yii2/base/Module.php(534): yii\console\Controller->runAction('fresh', Array)
#21 /app/vendor/yiisoft/yii2/console/Application.php(181): yii\base\Module->runAction('migrate/fresh', Array)
#22 /app/vendor/yiisoft/yii2/console/Application.php(148): yii\console\Application->runAction('migrate/fresh', Array)
#23 /app/vendor/yiisoft/yii2/base/Application.php(392): yii\console\Application->handleRequest(Object(yii\console\Request))
#24 /app/yii(23): yii\base\Application->run()
#25 {main}
2021-05-21 07:51:05 [-][-][-][error][yii\db\Exception] PDOException: SQLSTATE[08006] [7] could not translate host name "dockerhost" to address: Name or service not known in /app/vendor/yiisoft/yii2/db/Connection.php:719
Stack trace:
#0 /app/vendor/yiisoft/yii2/db/Connection.php(719): PDO->__construct('pgsql:host=dock...', 'fuw', 'vagrant', NULL)
#1 /app/vendor/yiisoft/yii2/db/Connection.php(638): yii\db\Connection->createPdoInstance()
#2 /app/vendor/yiisoft/yii2/db/Connection.php(1059): yii\db\Connection->open()
#3 /app/vendor/yiisoft/yii2/db/Connection.php(1046): yii\db\Connection->getMasterPdo()
#4 /app/vendor/yiisoft/yii2/db/Schema.php(463): yii\db\Connection->getSlavePdo()
#5 /app/vendor/yiisoft/yii2/db/Connection.php(938): yii\db\Schema->quoteValue('public')
#6 /app/vendor/yiisoft/yii2/db/Command.php(211): yii\db\Connection->quoteValue('public')
#7 /app/vendor/yiisoft/yii2/db/Command.php(1126): yii\db\Command->getRawSql()
#8 /app/vendor/yiisoft/yii2/db/Command.php(1147): yii\db\Command->logQuery('yii\\db\\Command:...')
#9 /app/vendor/yiisoft/yii2/db/Command.php(453): yii\db\Command->queryInternal('fetchAll', 7)
#10 /app/vendor/yiisoft/yii2/db/pgsql/Schema.php(182): yii\db\Command->queryColumn()
#11 /app/vendor/yiisoft/yii2/db/Schema.php(237): yii\db\pgsql\Schema->findTableNames('public')
#12 /app/vendor/yiisoft/yii2/db/Schema.php(780): yii\db\Schema->getTableNames('', false)
#13 /app/vendor/yiisoft/yii2/db/Schema.php(207): yii\db\Schema->getSchemaMetadata('', 'schema', false)
#14 /app/vendor/yiisoft/yii2/console/controllers/MigrateController.php(300): yii\db\Schema->getTableSchemas()
#15 /app/vendor/yiisoft/yii2/console/controllers/BaseMigrateController.php(472): yii\console\controllers\MigrateController->truncateDatabase()
#16 [internal function]: yii\console\controllers\BaseMigrateController->actionFresh()
#17 /app/vendor/yiisoft/yii2/base/InlineAction.php(57): call_user_func_array(Array, Array)
#18 /app/vendor/yiisoft/yii2/base/Controller.php(181): yii\base\InlineAction->runWithParams(Array)
#19 /app/vendor/yiisoft/yii2/console/Controller.php(184): yii\base\Controller->runAction('fresh', Array)
#20 /app/vendor/yiisoft/yii2/base/Module.php(534): yii\console\Controller->runAction('fresh', Array)
#21 /app/vendor/yiisoft/yii2/console/Application.php(181): yii\base\Module->runAction('migrate/fresh', Array)
#22 /app/vendor/yiisoft/yii2/console/Application.php(148): yii\console\Application->runAction('migrate/fresh', Array)
#23 /app/vendor/yiisoft/yii2/base/Application.php(392): yii\console\Application->handleRequest(Object(yii\console\Request))
#24 /app/yii(23): yii\base\Application->run()
#25 {main}

Next yii\db\Exception: SQLSTATE[08006] [7] could not translate host name "dockerhost" to address: Name or service not known in /app/vendor/yiisoft/yii2/db/Connection.php:649
Stack trace:
#0 /app/vendor/yiisoft/yii2/db/Connection.php(1059): yii\db\Connection->open()
#1 /app/vendor/yiisoft/yii2/db/Connection.php(1046): yii\db\Connection->getMasterPdo()
#2 /app/vendor/yiisoft/yii2/db/Schema.php(463): yii\db\Connection->getSlavePdo()
#3 /app/vendor/yiisoft/yii2/db/Connection.php(938): yii\db\Schema->quoteValue('public')
#4 /app/vendor/yiisoft/yii2/db/Command.php(211): yii\db\Connection->quoteValue('public')
#5 /app/vendor/yiisoft/yii2/db/Command.php(1126): yii\db\Command->getRawSql()
#6 /app/vendor/yiisoft/yii2/db/Command.php(1147): yii\db\Command->logQuery('yii\\db\\Command:...')
#7 /app/vendor/yiisoft/yii2/db/Command.php(453): yii\db\Command->queryInternal('fetchAll', 7)
#8 /app/vendor/yiisoft/yii2/db/pgsql/Schema.php(182): yii\db\Command->queryColumn()
#9 /app/vendor/yiisoft/yii2/db/Schema.php(237): yii\db\pgsql\Schema->findTableNames('public')
#10 /app/vendor/yiisoft/yii2/db/Schema.php(780): yii\db\Schema->getTableNames('', false)
#11 /app/vendor/yiisoft/yii2/db/Schema.php(207): yii\db\Schema->getSchemaMetadata('', 'schema', false)
#12 /app/vendor/yiisoft/yii2/console/controllers/MigrateController.php(300): yii\db\Schema->getTableSchemas()
#13 /app/vendor/yiisoft/yii2/console/controllers/BaseMigrateController.php(472): yii\console\controllers\MigrateController->truncateDatabase()
#14 [internal function]: yii\console\controllers\BaseMigrateController->actionFresh()
#15 /app/vendor/yiisoft/yii2/base/InlineAction.php(57): call_user_func_array(Array, Array)
#16 /app/vendor/yiisoft/yii2/base/Controller.php(181): yii\base\InlineAction->runWithParams(Array)
#17 /app/vendor/yiisoft/yii2/console/Controller.php(184): yii\base\Controller->runAction('fresh', Array)
#18 /app/vendor/yiisoft/yii2/base/Module.php(534): yii\console\Controller->runAction('fresh', Array)
#19 /app/vendor/yiisoft/yii2/console/Application.php(181): yii\base\Module->runAction('migrate/fresh', Array)
#20 /app/vendor/yiisoft/yii2/console/Application.php(148): yii\console\Application->runAction('migrate/fresh', Array)
#21 /app/vendor/yiisoft/yii2/base/Application.php(392): yii\console\Application->handleRequest(Object(yii\console\Request))
#22 /app/yii(23): yii\base\Application->run()
#23 {main}
Additional Information:

```
##### Problem
The setup thinks its on staging, it is because the variables in `.secrets` is for staging.

##### Review 4
Update the following variables in gitlab fork:
```
FUW_TESTDB_HOST=
FUW_TESTDB_NAME=
FUW_TESTDB_USER=
FUW_TESTDB_PASSWORD=
FUW_DB_HOST=
FUW_DB_NAME=
FUW_DB_USER=
FUW_DB_PASSWORD=
FUW_JWT_KEY=
```

##### Problem
```
ERROR: for deployment_tusd_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for deployment_ftpd_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for deployment_console_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for deployment_watcher_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for deployment_application_1  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for tusd  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for ftpd  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for console  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for watcher  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)

ERROR: for application  UnixHTTPConnectionPool(host='localhost', port=None): Read timed out. (read timeout=60)
ERROR: An HTTP request took too long to complete. Retry with --verbose to obtain debug information.
If you encounter this issue regularly because of slow network conditions, consider setting COMPOSE_HTTP_TIMEOUT to a higher value (current value: 60).
```

### Steps to review - Go through the steps mentioned in the FUW workflow [video](https://drive.google.com/file/d/1kkMMApX0J8Fcyt8ftwCe2PKPrtu5rQ6N/view?usp=sharing)  


### Reference


[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

