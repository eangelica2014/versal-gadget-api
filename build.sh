#!/bin/sh

set -e
set -o verbose

rm -rf _site
jekyll build
echo 1 $PWD
tmpdir=/tmp/$(date +%s)
mkdir -p $tmpdir
rm -rf $tmpdir/site
cp -r _site $tmpdir/site
echo 2 $PWD
cd ..
echo 3 $PWD
git checkout gh-pages
echo 4 $PWD
rm -rf ./*
echo 5 $PWD
cp -r $tmpdir/site/* ./
echo 6 $PWD
git add -A
COMMIT=$(git rev-parse --short HEAD)
DATE=$(date)
git commit -m"Generated $DATE ($COMMIT)"
