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
        <link rel="icon" href="/image/favicon.ico" type="/image" />
        <link rel="apple-touch-icon" sizes="180x180" href="/image/apple-touch-icon.png">
        <link rel="icon" type="image" sizes="32x32" href="/image/favicon-32x32.png">
        <link rel="icon" type="image" sizes="16x16" href="/image/favicon-16x16.png">
        <link rel="manifest" href="/site.webmanifest">
```
5. Edit the `site.webmanifest`
```json
{"name":"","short_name":"","icons":[{"src":"/android-chrome-192x192.png","sizes":"192x192","type":"image"},{"src":"/android-chrome-512x512.png","sizes":"512x512","type":"image"}],"theme_color":"#ffffff","background_color":"#ffffff","display":"standalone"}
```


### Where to check the final implementation
Go to [Favicon checker](https://realfavicongenerator.net/)


### Reference
1. [Add Favicon to hugo based website](https://www.kiroule.com/article/add-favicon-to-hugo-based-website/)
2. [Create favicon](https://www.enthuseandinspire.co.uk/blog/favicon/)

[![Build Status](https://travis-ci.org/kencho51/gigathing.svg?branch=master)](https://travis-ci.org/kencho51/gigathing)


