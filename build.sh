#!/bin/sh

set -e
set -o verbose

rm -rf _site
jekyll build
tmpdir=/tmp/$(date +%s)
mkdir -p $tmpdir
rm -rf $tmpdir/site
cp -r _site $tmpdir/site
cd ..
git checkout gh-pages
rm -rf ./*
cp -r $tmpdir/site/* ./
git add -A
COMMIT=$(git rev-parse --short HEAD)
DATE=$(date)
git commit -m"Generated $DATE ($COMMIT)"
