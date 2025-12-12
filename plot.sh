#!/bin/bash

dbname="bitcoin_tracker"
user="root"

# plot 1: get bitcoin USD prices
bitcoinprice() {
# get data from mysql website
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile.dat

# create plot
gnuplot <<EOF
	set terminal png font 'Arial' size 1280, 720
	set output 'bitcoinprice.png'
	set title 'Bitcoin USD Prices in a Day'
	set xlabel 'Date Collected'
	set ylabel 'Price USD ($)'
	set xdata time
	set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
	set format "%d-%m\n%H:%M" # output time in image
	set datafile separator "\t" # separate data into columns
	set grid
	set yrange [80000:100000]
	set ytics 80000, 2000, 100000
	set format y "%.2f"
	plot "outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Bitcoin'
EOF
}
