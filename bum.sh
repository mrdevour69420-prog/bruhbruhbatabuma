#!/bin/bash

set -e

curl -fsSL https://packages.playit.gg/install.sh | bash

chmod +x download.sh remove.sh git.sh playit.sh

./download.sh -p mod.mrpack -j 67

./remove.sh -f remlist.txt -d ./mods

java -jar installer.jar

chmod +x start.sh

# tách luồng

# luồng 1
./start.sh
# luồng 2
./playit.sh