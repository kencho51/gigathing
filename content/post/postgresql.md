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
 
 ### [Changing](https://thecodinginterface.com/blog/postgresql-changing-data-directory/) the default directory of PostgreSQL (Optional)
 `kencho=# SHOW data_directory;`
 >/Users/kencho/Library/Application Support/Postgres/var-12
 
### Datatypes
1. Characters  

 |Name|Description|
 |:---|:---|
 |varchr(n)|Allows you to declare variable-length with a limit|
 |char(n)|Fixed-length, blank padded|
 |text|User can use this data type to declare a variable with unlimited length|
 
2. Numeric  
- Integers
- Floating-pointing numbers

3. Binary  
- Binary strings allow storing odds of value zero
- Non- printable octets

4. Network Address Type
- cider: IPv4 and IPv6 networks
- Inet: IPv4 and IPv5 host and networks
- macaaddr: MAC addresses

5. Text Search Type

6. Date/Time 
PostgreSQL timestamp offers microsecond precision instead of second precision. Date and time input is accepted in various format, including traditional Postgres, ISO 8601. SQL-compatible etc.

7. Boolean
- True, `1`
- False, `0`
- null

8. Geometric 

9. Enumerated  
Enumerated Data types in PostgreSQL is useful for representing rarely changing information such as country code or branch id. 
The Enumerated data type is represented in a table with foreign keys to ensure data integrity. Here is the example code:
```postgresql
#Hair color is fairly static in a demographic database
CREATE TYPE hair_color AS ENUM
('brown','black','red','grey','blond')
```
10. Range

11. UUID
Universally Unique Identifies (UUID) is a 128-bit quantity, these identifiers are an ideal choice as it offers uniqueness within a single database.  
Example:  
`d5f28c97-b962-43be-9cf8-ca1632182e8e`

12. XML 
 PostgreSQL allows you to store XML data in a data type, but it is nothing more than an extension to a text data type.  
 But the advantage is that it checks that the input XML is well-formed.
 
13. Json
 - Json  
 - Jsonb  
 ```postgresql
 CREATE TABLE employee (
   id integer NOT NULL,
   age  integer NOT NULL,
   data jsonb
 );
```

14. Pseudo-types  
PostgreSQL has many special-purpose entries that are called pseudo-types. 
You can't use pseudo-type as a column data type. 
There are used to declare or function's argument or return type.  
Each of the available pseudo-types is helpful in situations where a function's behavior docs do not correspond to simply taking or returning a value of a specific SQL data type.

### Best practice using data types
- Use "text" data type unless you want to limit the input
- Never use "char."
- Integers use "int." Use bigint only when you have really big numbers
- Use "numeric" almost always
- Use float data type if you have IEEE 754 data source




### Reference
1. [Introduction to PostgreSQL](https://www.guru99.com/introduction-postgresql.html)
2. [PostgreSQL download](https://www.postgresql.org/download/)
3. [10 Command-line Utilities in PostgreSQL](https://www.datacamp.com/community/tutorials/10-command-line-utilities-postgresql)
4. [cheatsheet](https://gist.github.com/Kartones/dd3ff5ec5ea238d4c546)
5. [Postgres Guide](http://postgresguide.com/utilities/psql.html)