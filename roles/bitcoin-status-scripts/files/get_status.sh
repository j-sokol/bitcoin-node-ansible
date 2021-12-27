#!/bin/bash

bold=$(tput bold); \
red=`tput setaf 1`; \
green=`tput setaf 2`; \
yellow=`tput setaf 3`; \
normal=$(tput sgr0); \

DATADIR="{{ bitcoind_data_dir }}"
RPCPASSWORD="{{ bitcoind_rpc_pass }}"
RPCUSER="{{ bitcoind_rpc_user }}"
echo $tot



#R1=$(cat /sys/class/net/wlan1/statistics/rx_bytes)
#T1=$(cat /sys/class/net/wlan1/statistics/tx_bytes)
#R2=$(cat /sys/class/net/wlan1/statistics/rx_bytes)
#T2=$(cat /sys/class/net/wlan1/statistics/tx_bytes)
#totalnw=$(( (R2 + T2 - R1 - T1) / 1024 ))


while true; do \
	prevblocks=$blocks
	bestblockhash=`bitcoin-cli -datadir="$DATADIR" -rpcpassword="$RPCPASSWORD" -rpcuser="$RPCUSER" getbestblockhash`; \
	blockts=`bitcoin-cli -datadir="$DATADIR" -rpcpassword="$RPCPASSWORD" -rpcuser="$RPCUSER" getblock $bestblockhash | jq .time`; \
	blockdate=`date --date="@$blockts" "+%Y/%m/%d-%H:%M:%S"`; \
	btcprice=`curl -s "https://min-api.cryptocompare.com/data/pricehistorical?fsym=BTC&tsyms=USD&ts=$blockts" | jq .BTC.USD`; \
	currentdate=`date "+%Y/%m/%d-%H:%M:%S"`; \
	blocks=`bitcoin-cli -datadir="$DATADIR" -rpcpassword="$RPCPASSWORD" -rpcuser="$RPCUSER" getblockcount`; \
	diskfilled=`df -h|grep bitcoin|tr -s " " |cut -d" " -f3`; \
	diskleft=`df -h|grep bitcoin|tr -s " " |cut -d" " -f4`; \
	diskall=`df -h|grep bitcoin|tr -s " " |cut -d" " -f2`
	blockdiff=$((blocks - prevblocks))
	printf "\n${currentdate} || disk: ${red}${diskfilled}${normal}/$diskall ($diskleft left) | block: ${green}$blocks${normal} (${yellow}+${blockdiff}${normal}, ${blockdate}) | ${bold}$btcprice${normal} BTC/USD" ; \
	sleep 10; \
done