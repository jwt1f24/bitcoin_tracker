#!/bin/bash

btc_src="https://coinmarketcap.com/currencies/bitcoin/"
btc_file="btc_data.html"

# fetch website data and save output in a new file
curl "$btc_src" > "$btc_file"


# search for money values, clean and reformat data into numbers, and arrange data in an array
btc_data=($(grep -o "\$[0-9,]\+\.[0-9]\+" "$btc_file" | sed "s/[$,]//g" | awk '{printf "%.2f\n", $1}'))
btc_usd=${btc_data[0]}
btc_low_24h=${btc_data[13]}
btc_high_24h=${btc_data[14]}
echo "$btc_usd"
echo "$btc_low_24h"
echo "$btc_high_24h"
