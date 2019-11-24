#!/bin/sh
##########################
# created by Nick Farrow #
##########################
RED='\033[0;31m'        #RED
GREEN='\033[0;32m'      #GREEN
YELLOW='\033[0;33m'     #YELLOW
NC='\033[0m'            #No Color



SEARCH_TERM=$1


  #missing SEARCH_TERM
                  if [ -z "$SEARCH_TERM" ]
                  then
                  echo "you are missing the device address"
              echo "run: device_list.sh"
             echo "You must pick an active device"
              exit 1
                    break
                    exit 1

                fi




TOKEN=$(cat logntoken)
DEV_KEY=$(cat config|grep DEVKEY|awk -F '"' '{print $2}')

DEVICE_ADDRESS="$1"

#HOSTIP="your_public_ip"
HOSTIP=$(curl -s ifconfig.me)


./lib/fileCheck.sh logntoken |grep PASSED>/dev/null && printf "${GREEN}Token authentication looks good${NC}\n"||printf "${RED}FAILED check your username and password${NC}\n"


printf "your public IP is $HOSTIP \n"
curl -X POST \
             -H "token:$TOKEN" \
                  -H "developerkey:$DEV_KEY" \
                       -d "{\"wait\":\"true\",\"deviceaddress\":\"$DEVICE_ADDRESS\", \
                                 \"hostip\":\"$HOSTIP\" }" \
                                      https://api.remot3.it/apv/v27/device/connect>output.log

jsonlint-py -f output.log>current_remote_address
cat current_remote_address

rm -rf output.log
echo ""
echo ""
echo ""
proxyserver=$(cat current_remote_address|grep proxyserver|awk -F '"' '{print $4}')
proxyport=$(cat current_remote_address|grep proxyport|awk -F '"' '{print $4}')

printf "ssh $proxyserver -p $proxyport\n"


