#!/bin/bash

dbname="bitcoin_tracker"
user="root"

# plot 1: get bitcoin USD prices
bitcoinpriceusd() {
mysql -u "$user" -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 1 ORDER BY datecollected;
" > outfile.dat

gnuplot <<EOF
	set terminal png font 'Arial'
	set output 'image.png'
	set title 'Bitcoin USD Prices'
	set xlabel 'Date Collected'
	set ylabel 'Price (USD)'
	set xdata time
	set timefmt '%Y-%m-%d %H:%M:%S'
	set format '%d-%m'
	plot "outfile.dat" u 1:2 w l t 'data'
EOF
}
