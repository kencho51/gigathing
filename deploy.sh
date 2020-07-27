#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"


printf "!!!Build the project.\n"
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo --gc -v --minify -t ghostwriter

printf "!!!Go To Public folder\n"
cd public

#Add if public folder cannot be pushed because of error: failed to push some refs to 'https://github.com/kencho51/kencho51.github.io.git'
printf "!!!Update local repo"
git pull --rebase
#git push origin master

printf "!!!Add changes to git.\n"
git add .

printf "!!!Commit changes.\n"
msg="Rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

printf "!!!Push source and build repos.\n"
git push origin master