+++
description = "Steps to add Favicon to Hugo blog"
title = "How to add a logo to a Hugo page"
date = 2020-10-27T10:55:02+08:00
tags = ["favicon"]
author = "Ken Cho"

+++  
### What is a `favivon`
A favicon is a small 16×16 pixel icon that serves as branding for your website. 
Its main purpose is to help visitors locate your page easier when they have multiple tabs open.


### Where to find favicon?
Go to [favicon.io](https://favicon.io/emoji-favicons/) to select the suitable one.


### Steps
1. Go to [favicon.io](https://favicon.io/emoji-favicons/)
2. Download the `favicon.zip` and unzip   
3. Place the files in `/static/image/`  
4. Add the following code to `/layouts/partials/header.html`  
```html
        <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
        <link rel="icon" type="image" sizes="32x32" href="/favicon-32x32.png">
        <link rel="icon" type="image" sizes="16x16" href="/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest">
```


### Reference
1. [Add Favicon to hugo based website](https://www.kiroule.com/article/add-favicon-to-hugo-based-website/)
2. 

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


