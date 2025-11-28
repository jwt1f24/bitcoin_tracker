#!/bin/bash

btc_src="https://coinmarketcap.com/currencies/bitcoin/"
btc_file="btc_data.html"

# fetch website data and save output in a new file
curl "$btc_src" > "$btc_file"


# search for money data values
btc_data=$(grep -o "\$[0-9,]\+\.[0-9]\+" "btc_file")
