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
- [x] 3. Pass Unit test
- [x] 4. Pass Functional test
- [x] 5. Pass Acceptance test
- [x] 6. Pass Coverage test

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

### Steps to review -  Pass Unit test
1. Make sure the `deployment_test_1` container is up  
`docker-compose build test`
2. Run the unit test suite  
`./test/unit_runner`  
   
```
..............................................................  63 / 279 ( 22%)
............................................................... 126 / 279 ( 45%)
............................................................... 189 / 279 ( 67%)
............................................................... 252 / 279 ( 90%)
...........................                                     279 / 279 (100%)

Time: 30.2 seconds, Memory: 30.00MB

OK (279 tests, 843 assertions)
deployment_console_1         docker-php-entrypoint php-fpm    Up      9000/tcp, 9001/tcp                                                                                                                                                                                                                                                                      
Yii Migration Tool (based on Yii v2.0.42.1)

No new migrations found. Your system is up-to-date.
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Backend\tests.unit Tests (24) ------------------------------
✔ DockerManagerTest: Can find matching container (0.32s)
✔ DockerManagerTest: Cannot find container (0.04s)
✔ DockerManagerTest: Cannot see forbidden container (0.00s)
✔ DockerManagerTest: Can make post body (0.01s)
✔ DockerManagerTest: Can load and run command (0.06s)
✔ DockerManagerTest: Can restart container (0.00s)
✔ FiledropAccountTest: Can create writable directories (0.18s)
✔ FiledropAccountTest: Can remove directories (0.17s)
✔ FiledropAccountTest: No op remove directories (0.08s)
✔ FiledropAccountTest: Can create tokens (0.10s)
✔ FiledropAccountTest: Create ftp account (0.09s)
✔ FiledropAccountTest: Remove ftp account (0.09s)
✔ FiledropAccountTest: Remove uploads (0.11s)
✔ FiledropAccountTest: Check ftp account (0.10s)
✔ FiledropAccountTest: Before validate calls account making function (0.09s)
✔ FiledropAccountTest: Before validate calls account making function preps fails (0.09s)
✔ FiledropAccountTest: Before validate calls account making function ft pd fails (0.08s)
✔ FiledropAccountTest: Before validate trigger removal (0.09s)
✔ MoveJobTest: Move job success (0.14s)
✔ MoveJobTest: Move job success file exists (0.09s)
✔ MoveJobTest: Move job upload not found failure (0.12s)
✔ MoveJobTest: Move job copy failure (0.09s)
✔ MoveJobTest: Move job throws file not found (0.08s)
✔ MoveJobTest: Move job create job to update giga db (0.07s)
------------------------------------------------------------


Time: 3.47 seconds, Memory: 30.00MB

OK (24 tests, 69 assertions)
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Frontend\tests.unit Tests (0) ------------------------------
------------------------------------------------------------
DEPRECATION: Calling the "Symfony\Component\EventDispatcher\EventDispatcherInterface::dispatch()" method with the event name as the first argument is deprecated since Symfony 4.3, pass it as the second argument and provide the event object as the first argument instead. /app/vendor/symfony/event-dispatcher/EventDispatcher.php:58


Time: 335 ms, Memory: 10.00MB

No tests executed!
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Common\tests.unit Tests (6) --------------------------------
✔ MessagingServiceTest: Send email (0.06s)
✔ UploadTest: Validate data type error (0.11s)
✔ UploadTest: Validate data type no error (0.05s)
✔ UploadTest: Validate file format error (0.05s)
✔ UploadTest: Validate file format no error (0.05s)
✔ UploadTest: Validate filedrop account missing (0.04s)
------------------------------------------------------------


Time: 781 ms, Memory: 16.00MB

OK (6 tests, 10 assertions)
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Console\tests.unit Tests (10) ------------------------------
✔ UploadFactoryTest: Get file format from file common (0.02s)
✔ UploadFactoryTest: Get file format from file regular (0.00s)
✔ UploadFactoryTest: Get file format from unknown (0.00s)
✔ UploadFactoryTest: Generate ftp link (0.00s)
✔ UploadFactoryTest: Create upload from file with success (0.06s)
✔ UploadFactoryTest: Create upload from file with failure (0.01s)
✔ UploadFactoryTest: Create upload from json with success (0.01s)
✔ UploadFactoryTest: Create upload from json with malformed json (0.00s)
✔ UploadFactoryTest: Create upload from json with doi mismatch (0.00s)
✔ UploadFactoryTest: Create upload from json with save failure (0.01s)
------------------------------------------------------------


Time: 889 ms, Memory: 16.00MB

OK (10 tests, 16 assertions)
Codeception PHP Testing Framework v4.1.20
Powered by PHPUnit 8.5.15 by Sebastian Bergmann and contributors.

Unit Tests (6) ---------------------------------------------
✔ UpdateGigaDBJobTest: Save files (0.19s)
✔ UpdateGigaDBJobTest: Save attributes (0.14s)
✔ UpdateGigaDBJobTest: Save samples (0.12s)
✔ UpdateGigaDBJobTest: Execute (0.12s)
✔ UpdateGigaDBJobTest: Throw exception when failed to find dataset (0.06s)
✔ UpdateGigaDBJobTest: Throw exception when dataset wrong status (0.05s)
------------------------------------------------------------


Time: 2.31 seconds, Memory: 18.00 MB

OK (6 tests, 7 assertions)

```
### Steps to reviews - Pass Functional test
1. Make sure the `deployment_test_1` container is up  
`docker-compose build test`
2. Run the functional test suite  
`./test/functional_runner`
   
```
................................................................ 65 / 95 ( 68%)
..............................                                    95 / 95 (100%)

Time: 1.44 minutes, Memory: 34.00MB

OK (95 tests, 294 assertions)
Restoring current database...
Restarting php container for deployment project...
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Backend\tests.functional Tests (10) ------------------------
✔ FiledropAccountCest: Prepare account set fields (0.34s)
✔ FiledropAccountCest: Checking an ftp account (0.23s)
✔ FiledropAccountCest: Create ftp accounts (0.38s)
✔ FiledropAccountCest: Create accounts database record (0.41s)
✔ FiledropAccountCest: Send rest http post to create account (0.57s)
✔ FiledropAccountCest: Send rest http delete to delete account (0.48s)
✔ FiledropAccountCest: Send rest http put to update filedrop account and send email (0.42s)
✔ FiledropAccountCest: Move files (0.25s)
✔ MockupUrlCest: Add mockup url (0.20s)
✔ UserCreateCest: Create non existent user (0.53s)
------------------------------------------------------------


Time: 5.98 seconds, Memory: 28.00MB

OK (10 tests, 42 assertions)
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Frontend\tests.functional Tests (6) ------------------------
✔ AttributeCest: Test set attributes (0.23s)
✔ AttributeCest: Test add attributes (0.08s)
✔ NotificationCest: Email send (0.14s)
✔ UploadCest: Get upload (0.09s)
✔ UploadCest: Update single upload (0.07s)
✔ UploadCest: Update multiple uploads (0.08s)
------------------------------------------------------------


Time: 1.99 seconds, Memory: 22.00MB

OK (6 tests, 32 assertions)
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.
Running with seed: 


Console\tests.functional Tests (7) -------------------------
ftp: DOI 300001 extracted...
✔ FtpCest: Try with success to create upload for file (0.25s)
✔ FtpCest: Try with default options (0.01s)
About to remove the dropbox for 300001...
✔ FuwCest: Try remove dropbox (0.47s)
actionUpload begins...
✔ TusdCest: Try with success to create upload for file (0.13s)
actionUpload begins...
✔ TusdCest: Try create upload for file from json file (0.12s)
actionUpload begins...
✔ TusdCest: Try create upload for file from json file destination already exists (0.14s)
✔ TusdCest: Try with default options (0.01s)
------------------------------------------------------------


Time: 1.86 seconds, Memory: 24.00MB

OK (7 tests, 35 assertions)

```

### Steps to review - Pass Acceptance test
1. Make sure the `deployment_test_1` container is up  
`docker-compose build test`
2. Make sure a headless browser is up
`docker-compose up -d chrome`
2. Run the acceptance test suite  
`./test/acceptance_runner`
   
```
77 scenarios (77 passed)
734 steps (734 passed)
26m40.98s (16.25Mb)
Codeception PHP Testing Framework v2.5.6
Powered by PHPUnit 6.5.14 by Sebastian Bergmann and contributors.

[Groups] ok 

Common\tests.acceptance Tests (53) -------------------------
⏺ Recording ⏺ step-by-step screenshots will be saved to /app/common/tests/_output/
Directory Format: record_60b0ae792a91b_{filename}_{testname} ----
userId: 346, username: joy_fox
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Accessing admin page's list of datasets to setup drop box for a dataset (18.70s)
userId: 346, username: joy_fox
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Triggering the creation of a drop box for a dataset with the appropriate status (23.09s)
userId: 346, username: joy_fox
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : The drop box is created, we can send email instructions (22.71s)
userId: 346, username: joy_fox
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : send default email instructions (22.74s)
userId: 346, username: joy_fox
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Seeing Popup composer for customizing and sending email instructions (19.70s)
userId: 346, username: joy_fox
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Popup composer for customizing and sending email instructions (24.71s)
userId: 346, username: artie_dodger
✔ : ftp upload triggers new upload record saved in database (55.72s)
userId: 346, username: artie_dodger
✔ : Upload files button when dataset has appropriate status (UserUploadingData) (17.72s)
userId: 346, username: artie_dodger
✔ : Upload files button when dataset has appropriate status (DataPending) (20.23s)
userId: 346, username: artie_dodger
userId: 347, username: chloe_decker
✔ : No Upload files button when dataset hasn't got to the appropriate status yet (23.64s)
userId: 346, username: artie_dodger
✔ : Pressing the upload button bring up File Upload Wizard upload screen (23.03s)
userId: 346, username: artie_dodger
✔ : All files in the queue are uploaded (20.93s)
userId: 346, username: artie_dodger
✔ : Queued files are all uploaded (11.43s)
userId: 346, username: artie_dodger
✔ : There is a Next button (11.83s)
userId: 346, username: artie_dodger
✔ : Next button to proceed to file metadata annotation form (42.37s)
userId: 346, username: artie_dodger
✔ : Metadata form elements for all uploaded files (18.50s)
userId: 346, username: artie_dodger
✔ : Making changes to metadata (17.10s)
userId: 346, username: artie_dodger
✔ : Saving metadata (23.56s)
userId: 346, username: artie_dodger
✔ : Removing uploads (20.88s)
userId: 346, username: artie_dodger
✔ : Initial MD5 checksum for upload files shows up as tooltip (18.71s)
userId: 346, username: artie_dodger
✔ : bulk upload form for all uploaded files (19.04s)
userId: 346, username: artie_dodger
✔ : Uploading CSV spreadsheet to update upload metadata (23.57s)
userId: 346, username: artie_dodger
✔ : Uploading CSV spreadsheet to update upload metadata and attributes (23.68s)
userId: 346, username: artie_dodger
✔ : Uploading CSV spreadsheet to update upload metadata, attributes and samples (22.43s)
userId: 346, username: artie_dodger
✔ : Spreadsheet with malformed attributes (23.59s)
userId: 346, username: artie_dodger
✔ : Spreadsheet with mispelled column header (21.02s)
userId: 346, username: artie_dodger
✔ : Unknown Data Type (all spreadsheet entries have error) (21.55s)
userId: 346, username: artie_dodger
✔ : Unknown Data Type (one spreadsheet entry in error) (28.63s)
userId: 346, username: artie_dodger
✔ : Unknown file format (one spreadsheet entry in error) (28.31s)
userId: 346, username: artie_dodger
✔ : Uploading TSV spreadsheet to update upload metadata and attributes (22.80s)
userId: 346, username: artie_dodger
✔ : Can trigger a form from metadata form for adding new attribute (16.93s)
userId: 346, username: artie_dodger
✔ : Can add new attribute to the attribute list (18.65s)
userId: 346, username: artie_dodger
✔ : Can add new samples to a file upload (21.89s)
userId: 346, username: artie_dodger
✔ : Saving file metadata with attributes and samples (29.47s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : after status is changed to DataAvailableForReview, add entry in curation log (24.12s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Editor set the status to "Rejected" causing a curation log entry (8.66s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Editor set the status to "Submitted" causing a curation log entry and an email notification (9.18s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : There is a button to generate mockup when status is Submitted (8.51s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : There is not a button to generate mockup when status is not Submitted (6.40s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Generating a mockup when status is Submitted (13.12s)
userId: 346, username: artie_dodger
✔ : Can access unique and time-limed url of dataset page showing uploaded files (4.84s)
userId: 346, username: artie_dodger
✔ : The page at the unique and time-limed url show dataset info (4.30s)
userId: 346, username: artie_dodger
✔ : The page at the unique and time-limed url show uploaded files, attributes, samples and download links (13.18s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Curator set the status to "DataPending" if something is missing, causing a curation log entry, and email notification (12.86s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Curator set the status to "Curation" when files and metadata are complete, causing a curation log entry (9.82s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : there's a button to trigger file transfer for dataset with status Curation (6.06s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
we are in CuratorSteps
✔ : there's no button to trigger file transfer for dataset if status not Curation (7.95s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Clicking the move button create a job for the workers (10.68s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : The files are copied to the new location when the workers complete the job (14.95s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Files that have been moved are marked as such in File Upload Wizard API (16.82s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Completion of moving files triggers update of the file database table (19.54s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Completion of moving files triggers update of the file, attributes tables (21.96s)
userId: 346, username: artie_dodger
userId: 347, username: ben_hur
we are in CuratorSteps
✔ : Completion of moving files triggers update of the file, attributes and samples tables (21.34s)
------------------------------------------------------------
⏺ Records saved into: file:///app/common/tests/_output/records.html


Time: 17.34 minutes, Memory: 42.00MB

OK (53 tests, 243 assertions)

```
### Steps to review - Pass Coverage test
1. Make sure the `deployment_test_1` container is up  
   `docker-compose build test`
2. Make sure a headless browser is up
   `docker-compose up -d chrome`
2. Run the coverage test suite  
   `./test/coverage_runner`
### Reference


[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)

