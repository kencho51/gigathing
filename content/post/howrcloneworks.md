+++
description = "Secure and stable data transfer using rclone"
title = "How rclone works"
date = 2022-09-21T09:45:28+08:00
tags = ["rclone", "aws", "wasabi", "cloud"]
author = "Ken Cho"
comments = true
+++  


### Introduction

Data migration is one of the major issues nowadays, it becomes inevitable for most organization trying to scale up their business or look for better data protection.
There are many ways and companies providing solutions in this field. [rclone](https://rclone.org/) is an open source tool that manages files on cloud storage.
Here will present some information on how to config rclone and cloud-to-cloud transfer.

### rclone installation
Follow [steps](https://rclone.org/install/) to install rclone.


### rclone configuration

0. pre-requisites
   1. Register account in different cloud service providers
   2. Create user with appropriate policy, like `s3FullAccess`
   3. Generate and copy secret id and access key

1. config rclone
```
# make sure rclone is installed
% rclone --version
rclone v1.55.1
- os/type: darwin
- os/arch: amd64
- go/version: go1.16.3
- go/linking: dynamic
- go/tags: cmount

# locate rclone config file
% rclone config file
Configuration file is stored at:
/Users/kencho/.config/rclone/rclone.conf
% cat ~/.config/rclone/rclone.conf

# config different endpoint/cloud storage
% vi ~/.config/rclone/rclone.conf
[wasabi]
type = s3
provider = Wasabi
env_auth = true
access_key_id = xxxxxxxxxxxxxxxxxxx
secret_access_key = yyyyyyyyyyyyyyyyyyyyyyyyyyy
region = ap-northeast-1
endpoint = s3.ap-northeast-1.wasabisys.com

# config an annonymouse end endpoint for s3://1000genomes/
% vi ~/.config/rclone/rclone.conf
[s3genomics]
type = s3
provider = AWS
env_auth = false
access_key_id =
secret_access_key =
region = us-east-1
endpoint =
location_constraint =
acl = private
server_side_encryption =
storage_class =

# config personal cloud drive, like google drive, through cli configuration
% rclone config
[google-drive]
type = drive
client_id = aaaaaaaaaaaaaaaaaaaaaaa
client_secret = bbbbbbbbbbbbbbbbbbbbbbbbbbb
scope = drive
token = {}

# test the connection
% rclone lsd wasabi:test-bucket-in-tokyo
           0 2022-09-21 11:32:08        -1 NA12878
% rclone lsd s3genomics:1000genomes
           0 2022-09-20 08:44:24        -1 1000G_2504_high_coverage
           0 2022-09-20 08:44:24        -1 alignment_indices
           0 2022-09-20 08:44:24        -1 changelog_details
           0 2022-09-20 08:44:24        -1 complete_genomics_indices
           0 2022-09-20 08:44:24        -1 data
           0 2022-09-20 08:44:24        -1 hgsv_sv_discovery
           0 2022-09-20 08:44:24        -1 phase1
           0 2022-09-20 08:44:24        -1 phase3
           0 2022-09-20 08:44:24        -1 pilot_data
           0 2022-09-20 08:44:24        -1 release
           0 2022-09-20 08:44:24        -1 sequence_indices
           0 2022-09-20 08:44:24        -1 technical
% rclone ls s3genomics:1000genomes/data/NA12878/alignment/ 
      621 NA12878.alt_bwamem_GRCh38DH.20150718.CEU.low_coverage.bam.bas
18307938102 NA12878.alt_bwamem_GRCh38DH.20150718.CEU.low_coverage.cram
   391987 NA12878.alt_bwamem_GRCh38DH.20150718.CEU.low_coverage.cram.crai
```

2. copy from open s3 bucket to wasabi bucket
```
# dry run mode
% rclone copy -P --dry-run s3genomics:1000genomes/data/NA12878/alignment/ wasabi:test-bucket-in-tokyo/NA12878/alignment/ 
2022-09-20 09:02:27 NOTICE: NA12878.alt_bwamem_GRCh38DH.20150718.CEU.low_coverage.cram.crai: Skipped copy as --dry-run is set (size 382.800k)
2022-09-20 09:02:27 NOTICE: NA12878.alt_bwamem_GRCh38DH.20150718.CEU.low_coverage.cram: Skipped copy as --dry-run is set (size 17.051G)
2022-09-20 09:02:27 NOTICE: NA12878.alt_bwamem_GRCh38DH.20150718.CEU.low_coverage.bam.bas: Skipped copy as --dry-run is set (size 621)
Transferred:       17.051G / 17.051 GBytes, 100%, 2.446 TBytes/s, ETA 0s
Transferred:            3 / 3, 100%
Elapsed time:         2.0s
2022/09/20 09:02:27 NOTICE: 
Transferred:       17.051G / 17.051 GBytes, 100%, 2.446 TBytes/s, ETA 0s
Transferred:            3 / 3, 100%
Elapsed time:         2.0s
% rclone copy -P s3genomics:1000genomes/data/NA12878/alignment/ wasabi:test-bucket-in-tokyo/NA12878/alignment/
% rclone size wasabi:test-bucket-in-tokyo
Total objects: 4
Total size: 766.812 kBytes (785216 Bytes)
```



### Reference
1. https://wasabi-support.zendesk.com/hc/en-us/articles/115001600252-How-do-I-use-Rclone-with-Wasabi-
2. https://forum.rclone.org/t/migrate-from-s3-to-another-s3-150tb/16004/6
3. https://rclone.org/s3/
4. [s3 genomics](https://registry.opendata.aws/1000-genomes/), [github](https://github.com/awslabs/open-data-docs/tree/main/docs/1000genomes)

[![Build Status](https://travis-ci.com/kencho51/gigathing.svg?branch=master)](https://travis-ci.com/kencho51/gigathing)
