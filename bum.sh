#!/bin/bash

set -e

chmod +x download.sh remove.sh git.sh

./download.sh -p mod.mrpack -j 67

./remove.sh -f remlist.txt -d ./mods

java -jar installer.jar

chmod +x start.sh

./start.sh