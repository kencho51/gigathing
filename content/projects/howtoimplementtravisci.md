+++
description = "Travis Continuous Integration"
title = "How to implement Travis CI to a Hugo site"
date = 2020-07-23T14:41:08+08:00
tags = ["Travis CI", "GO", "Token"]
author = "Ken Cho"

+++  
![img](/image/travis_head.png)
### What is Travis?
- Travis is a continuous integration testing tool that integrates with GitHub.
- It allows you to run automated tests on your code each time a commit is made to the repository.

### How?
1. Sign in Travis in [https://travis-ci.org/](https://travis-ci.org/) using github account.
2. Enable `Source` github repo in Travis setting.
3. Create  `Personal access token` in github, the scopes include:
    - repo
    - admin:public_key
    - admin:repo_hook
    - user
4. Copy the token generated and update the Travis `Environment Variables` as below:
    - GH_TOKEN: paste the github 
    - GITHUB_EMAIL: kencho.gigascience@gmail.com
    - GITHUB_USERNAME: kencho51
5. Create `.travis.yml` at the directoyy top level
```yaml
language: go
dist: xenial
env:
  - HUGO_VERSION="0.74.2"
before_install:
  - sudo apt-get update -qq
install: true
before_script:
  - wget https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.deb
  - sudo dpkg -i hugo_${HUGO_VERSION}_Linux-64bit.deb
  - rm -rf public || exit 0
script:
  - hugo --gc -v --minify
deploy:
  provider: pages
  skip_cleanup: true
  keep_history: true
  github_token: $GH_TOKEN
  local_dir: public
  target_branch: master
  email: kencho.gigascience@gmail.com
  name: kencho51
  repo: kencho51/kencho51.github.io
  verbose: true
  on:
    branch: master
``` 
6. Insert `build status` into default template, every post will have `build status` on it.  
- Markdown format: `[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)`  
- Image URL: https://travis-ci.org/kencho51/gigathing.svg?branch=master


### Reference

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)



