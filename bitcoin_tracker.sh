#!/bin/bash

user="root"
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

# fetch time the data was collected
datecollected=$(date +"%Y-%m-%d %H:%M:%S")

# insert data into database
mysql -u "$user" <<EOFMYSQL

USE bitcoin_tracker;

INSERT INTO prices(currencyID, price_usd, lowest_24h, highest_24h, datecollected) VALUES
(1, "$btc_usd", "$btc_low_24h", "$btc_high_24h", "$datecollected");

EOFMYSQL
echo "Script finished executing."
