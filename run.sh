#!/bin/bash

echo "Downloading..."
./download.rb

echo "Creating..."
./create.rb | ./stitch.rb > docs/index.html

echo "Updating..."

git add .
git commit -m "Updated site"
git push -u origin master
