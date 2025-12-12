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

# plot 2: get Ethereum USD prices
ethereumprice() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'ethereumprice.png'
        set title 'Ethereum USD Prices in a Day'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [2000:4000]
        set ytics 2000, 200, 4000
        set format y "%.2f"
        plot "outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Ethereum'
EOF
}

# plot 3: get XRP USD prices
xrpprice() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'xrpprice.png'
        set title 'XRP USD Prices in a Day'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [0:3]
        set ytics 0, 0.25, 3
        set format y "%.2f"
        plot "outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'XRP'
EOF
}

# plot 4: get BNB USD prices
bnbprice() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'bnbprice.png'
        set title 'BNB USD Prices in a Day'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [800:1000]
        set ytics 800, 20, 1000
        set format y "%.2f"
        plot "outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'BNB'
EOF
}

# plot 5: get all cryptocurrency USD prices
allprices() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile2.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile3.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > outfile4.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'allprices.png'
        set title 'Cryptocurrency USD Prices in a Day'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [0:100000]
        set ytics 0, 10000, 100000
        set format y "%.2f"
	plot \
		"outfile.dat" u 1:2 w lp lc rgb 'red' pt 2 t 'Bitcoin', \
		"outfile2.dat" u 1:2 w lp lc rgb 'yellow' pt 2 t 'Ethereum', \
        	"outfile3.dat" u 1:2 w lp lc rgb 'green' pt 2 t 'XRP', \
		"outfile4.dat" u 1:2 w lp lc rgb 'blue' pt 2 t 'BNB'
EOF
}

# parameters for executing function
if [[ "$1" == "bitcoinprice" ]]; then
	bitcoinprice
elif [[ "$1" == "ethereumprice" ]]; then
	ethereumprice
elif [[ "$1" == "xrpprice" ]]; then
        xrpprice
elif [[ "$1" == "bnbprice" ]]; then
        bnbprice
elif [[ "$1" == "allprices" ]]; then
        allprices
fi
