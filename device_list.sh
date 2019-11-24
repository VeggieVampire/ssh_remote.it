#!/bin/sh
##########################
# created by Nick Farrow #
##########################
RED='\033[0;31m'        #RED
GREEN='\033[0;32m'      #GREEN
YELLOW='\033[0;33m'     #YELLOW
NC='\033[0m'            #No Color

dpkg -l python-demjson>/dev/null 2>CHECKpkg.txt 3>/dev/null



#./lib/fileCheck.sh CHECKpkg.txt |grep PASSED>/dev/null && printf "${RED}FAILED missing python-demjson${NC}\n"||printf "${GREEN}pkg found${NC}\n"


./lib/fileCheck.sh CHECKpkg.txt |grep PASSED>/dev/null && printf "${RED}FAILED missing jsonlint-py${NC}\n run this command to fix it\n sudo apt-get install python-demjson\n"||printf "${NC}Device List${NC}\n"
rm -rf CHECKpkg.txt
TOKEN=$(cat logntoken)

DEVKEY=$(cat config|grep DEVKEY|awk -F '"' '{print $2}')

curl -H "token:$TOKEN" \
             -H "developerkey:$DEVKEY" \
                  https://api.remot3.it/apv/v27/device/list/all>output.log 2>/dev/null 3>/dev/null

#formates and greps for keywords
jsonlint-py -f output.log|grep 'deviceaddress\|devicealias\|devicestate'>output2.log


#adds a space every 3rd row
awk ' {print;} NR % 3 == 0 { print ""; }' output2.log >output3.log

PATHZ=$(pwd)
 filenamez=$PATHZ/output3.log
while read p; do
echo $p|grep inactive>/dev/null && printf "devicestate : ${YELLOW}inactive${NC}\n"
        echo $p|grep ' "active'>/dev/null && printf "devicestate : ${GREEN}active${NC}\n"||echo $p|grep -v active

done < $filenamez

rm -rf output3.log
rm -rf output2.log
rm -rf output.log
