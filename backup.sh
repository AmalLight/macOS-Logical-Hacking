#!/bin/bash

git fetch --all
git pull origin main

rm -rf ../backup2 ; sync ; cp -r ../macOS-Logical-Hacking ../backup2
