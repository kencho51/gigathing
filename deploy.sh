#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

printf "Build the project."
#hugo # if using a theme, replace with `hugo -t <YOURTHEME>`
hugo -t ghostwriter

printf "Go To Public folder"
cd public

printf "Add changes to git."
git add .

print "Commit changes."
msg="Rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

printf "Push source and build repos."
git push origin master