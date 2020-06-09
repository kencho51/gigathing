+++
description = "Everything about PostgreSQL database"
title = "Postgresql"
date = 2020-06-09T10:25:23+08:00
tags = ["postgreSQL", "SQL", "database"]
author = "Ken Cho"

+++
### What is PostgreSQL?
![img](/image/postgresql_logo.png)
>PostgreSQL is an enterprise-class open source database management system. 
>It supports both SQL for relational and JSON for non-relational queries.
>PostgreSQL supports advanced data types and advance performance optimization.

### Key features
- Compatible with various platforms using all major languages and middleware
- It offers a most sophisticated locking mechanism
- Support for multi-version concurrency control
- Compliant with the ANSI SQL standard
- Full support for client-server network architecture
- Log-based and trigger-based replication SSL
- Standby server and high availability
- Object-oriented and ANSI-SQL2008 compatible
- Support for JSON allows linking with other data stores like NoSQL which act as a federated hub for polyglot databases

### MySQL vs PostgreSQL
| MySQL | PostgreSQL |
|:-------|:------------|
|The MySQL project has made its source code available under the terms of the GNU License, and other proprietary agreements.	| PostgreSQL is released under PostgreSQL License.|
|It's now owned by Oracle Corporation and offers several paid editions.	| It's free and open-source software. That means you will never need to pay anything for this service.|
|MySQL is ACID compliant only when using with NDB and InnoDB Cluster Storage engines. | PostgreSQL is completely ACID compliant.|
|MySQL performs well in OLAP and OLTP systems where only read speed is important.	| PostgreSQL performance works best in systems which demand the execution of complex queries.|
|MySQL is reliable and works well with BI (Business Intelligence) applications, which are difficult to read	| PostgreSQL works well with BI applications. However, it is more suited for Data Warehousing and data analysis applications which need fast read-write speeds.|

### Advantages
1. Can run dynamic websites and web apps.  
2. Write-ahead logging makes it a highly fault-tolerant database.
3. Source code is freely available under an open source license.
4. Supports geographic objects so you can use it for location-based services and geographic information systems.  
5. Supports geographic objects so it can be used as a geospatial data store for location-based services and geographic information systems.
6. Low maintenance administration for both embedded and enterprise use.

### Disadvantages
1. Changes made for speed improvement requires more work than MySQL as PostgreSQL focuses on compatibility.
2. Many open source apps support MySQL, but may not support PostgreSQL.
3. On performance metrics, it is slower than MySQL.

### Download and install
1. Download and install `postgrlSQL`  
`brew doctor`  
`brew update`  
`brew install postgresql`
2. Download and install `Pgcli`, for `Postgres with auto-completion and syntax highlighting.`  
`brew install pgcli`
3. The path of `psql`  
`brew info libpq`
4. To include in in `zshrc`  
`echo 'export PATH="/usr/local/opt/libpq/bin:$PATH"' >> ~/.zshrc`

### [Postgre.app](https://postgresapp.com/downloads.html) 
Postgre.app is a full-featured PostgreSQL installation packaged as a standard Mac app. 


### Configure the $PATH for [CLI](https://postgresapp.com/documentation/cli-tools.html) (Optional)
`sudo mkdir -p /etc/paths.d &&
 echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
 
### Character Datatypes
 |Name|Description|
 |:---|:---|
 |varchr(n)|Allows you to declare variable-length with a limit|
 |char(n)|Fixed-length, blank padded|
 |text|User can use this data type to declare a variable with unlimited length|
 
 ### 

### Reference
1. [Introduction to PostgreSQL](https://www.guru99.com/introduction-postgresql.html)
2. [PostgreSQL download](https://www.postgresql.org/download/)