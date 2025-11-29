#!/bin/bash

btc_src="https://coinmarketcap.com/currencies/bitcoin/"
btc_file="btc_data.html"

# check if network is down or not
if ping -c 4 8.8.8.8; then
	echo "Network is available! Proceeding..."
else
	echo "Error! Network is down..."
	exit 1
fi

# fetch website data and save output in a new file
curl "$btc_src" > "$btc_file"

# check if website is blocking the script or not
if grep 'data-test="text-cdp-price-display"' "$btc_file"; then
	echo "Script is not blocked, proceeding..."
else
	echo "Error! Script is blocked."
	exit 1
fi

# search for money values, clean and reformat data into numbers, and arrange data in an array
btc_data=($(grep -o "\$[0-9,]\+\.[0-9]\+" "$btc_file" | sed "s/[$,]//g" | awk '{printf "%.2f\n", $1}'))
btc_usd=${btc_data[0]}
btc_low_24h=${btc_data[13]}
btc_high_24h=${btc_data[14]}
echo "$btc_usd"
echo "$btc_low_24h"
echo "$btc_high_24h"
