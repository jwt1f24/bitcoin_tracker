#!/bin/bash

dbname="bitcoin_tracker"
user="root"
password=""
btc_src="https://coinmarketcap.com/currencies/bitcoin/"
btc_file="btc_data.html"
eth_src="https://coinmarketcap.com/currencies/ethereum/"
eth_file="eth_data.html"
xrp_src="https://coinmarketcap.com/currencies/xrp/"
xrp_file="xrp_data.html"
bnb_src="https://coinmarketcap.com/currencies/bnb/"
bnb_file="bnb_data.html"

# check if network is down or not
if ping -c 4 8.8.8.8; then
	echo "Network is available! Proceeding..."
else
	echo "Error! Network is down..."
	exit 1
fi

# fetch website data and save output in a new file
curl "$btc_src" > "$btc_file"; curl "$eth_src" > "$eth_file";
curl "$xrp_src" > "$xrp_file"; curl "$bnb_src" > "$bnb_file"

# check if script is blocked by website or not
if grep -q 'data-test="text-cdp-price-display"' "$btc_file"; then
	echo "Script is not blocked, proceeding..."
else
	echo "Error! Script is blocked."
	exit 2
fi

# search for money values, clean and reformat data into numbers, and arrange data in an array
btc_data=($(grep -o "\$[0-9,]\+\.[0-9]\+" "$btc_file" | sed "s/[$,]//g" | awk '{printf "%.2f\n", $1}'))
btc_usd=${btc_data[0]}
btc_low_24h=${btc_data[13]}
btc_high_24h=${btc_data[14]}

eth_data=($(grep -o "\$[0-9,]\+\.[0-9]\+" "$eth_file" | sed "s/[$,]//g" | awk '{printf "%.2f\n", $1}'))
eth_usd=${eth_data[0]}
eth_low_24h=${eth_data[11]}
eth_high_24h=${eth_data[12]}

xrp_data=($(grep -o "\$[0-9,]\+\.[0-9]\+" "$xrp_file" | sed "s/[$,]//g" | awk '{printf "%.2f\n", $1}'))
xrp_usd=${eth_data[0]}
xrp_low_24h=${eth_data[9]}
xrp_high_24h=${eth_data[10]}

bnb_data=($(grep -o "\$[0-9,]\+\.[0-9]\+" "$bnb_file" | sed "s/[$,]//g" | awk '{printf "%.2f\n", $1}'))
bnb_usd=${bnb_data[0]}
bnb_low_24h=${bnb_data[8]}
bnb_high_24h=${bnb_data[9]}

# fetch time the data was collected
datecollected=$(date +"%Y-%m-%d %H:%M:%S")

# insert data into database
mysql -u "$user" <<EOFMYSQL

USE bitcoin_tracker;

INSERT INTO prices(currencyID, price_usd, lowest_24h, highest_24h, datecollected) VALUES
(1, "$btc_usd", "$btc_low_24h", "$btc_high_24h", "$datecollected"),
(2, "$eth_usd", "$eth_low_24h", "$eth_high_24h", "$datecollected"),
(3, "$xrp_usd", "$xrp_low_24h", "$xrp_high_24h", "$datecollected"),
(4, "$bnb_usd", "$bnb_low_24h", "$bnb_high_24h", "$datecollected");

EOFMYSQL
echo "Script finished executing."
