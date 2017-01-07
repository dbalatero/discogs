#!/bin/bash

echo "Downloading..."
./download.rb

echo "Creating..."
./create.rb > output.html

echo "Stitching..."
cat output.html | ./stitch.rb > docs/index.html

rm output.html

echo "Updating..."

git add .
git commit -m "Updated site"
git push -u origin master
