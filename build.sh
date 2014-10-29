#!/bin/sh

set -e
set -o verbose

cd docs
rm -rf _site
jekyll build
tmpdir=/tmp/$(date +%s)
mkdir -p $tmpdir
rm -rf $tmpdir/site
cp -r _site $tmpdir/site
git checkout gh-pages
cd ..
rm -rf ./*
cp -r $tmpdir/site/* ./
git add -A
COMMIT=$(git rev-parse --short HEAD)
DATE=$(date)
git commit -m"Generated $DATE ($COMMIT)"
