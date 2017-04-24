#!/bin/bash

# make checksum
md5sum obviux.sh > md5sum.txt
git add md5sum.txt
 
# compress configs
tar -zcvf configs.tgz ./config
git add configs.tgz
