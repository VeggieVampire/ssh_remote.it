#!/bin/sh
##########################
# created by Nick Farrow #
##########################
RED='\033[0;31m'        #RED
GREEN='\033[0;32m'      #GREEN
YELLOW='\033[0;33m'     #YELLOW
NC='\033[0m'            #No Color

FILE="./config"
if [ -f "$FILE" ]; then
    printf "${GREEN}$FILE exists.${NC}\n"
else 
    printf "${RED}missing config file ${NC}\n"
    echo "$FILE does not exist!!"
    echo "Place the config file in the directoy you are running a authentication.sh from"
    exit 1
    break
    exit 1
fi

DEVKEY=$(cat config|grep DEVKEY|awk -F '"' '{print $2}')
USERNAME=$(cat config|grep USERNAME|awk -F '"' '{print $2}')
PASSWORD=$(cat config|grep PASSWORD|awk -F '"' '{print $2}')
curl -X POST -H developerkey:"$DEVKEY" -H Content-Type:application/json \
            -H Cache-Control:no-cache -d "{ \"username\":\"$USERNAME\", \
                \"password\":\"$PASSWORD\" }" https://api.remot3.it/apv/v27/user/login>output.log 2>/dev/null 3>/dev/null

cat output.log |awk -F ',' '{print $2}'|awk -F ':' '{print $2}'|awk -F '"' '{print $2}'>logntoken
./lib/fileCheck.sh logntoken |grep PASSED>/dev/null && printf "${GREEN}Token created${NC}\n"||printf "${RED}FAILED check your username and password${NC}\n"
cat logntoken
rm -rf output.log
