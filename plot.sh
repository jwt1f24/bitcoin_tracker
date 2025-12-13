#!/bin/bash

dbname="bitcoin_tracker"
user="root"

# plot 1: get bitcoin USD prices
bitcoinpricechanges() {
# get data from mysql website
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat

# create plot
gnuplot <<EOF
	set terminal png font 'Arial' size 1280, 720
	set output 'gnuplot/bitcoinpricechanges.png'
	set title 'Bitcoin Price Changes Across a 24-Hour Period'
	set xlabel 'Date Collected'
	set ylabel 'Price USD ($)'
	set xdata time
	set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
	set format "%d-%m\n%H:%M" # output time in image
	set datafile separator "\t" # separate data into columns
	set grid
	set yrange [80000:100000]
	set ytics 80000, 2500, 100000
	set format y "%.2f"
	plot "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Bitcoin'
EOF
}

# plot 2: get Ethereum USD prices
ethereumpricechanges() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/ethereumpricechanges.png'
        set title 'Ethereum Price Changes Across a 24-Hour Period'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [2000:5000]
        set ytics 2000, 500, 5000
        set format y "%.2f"
        plot "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Ethereum'
EOF
}

# plot 3: get XRP USD prices
xrppricechanges() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/xrppricechanges.png'
        set title 'XRP Price Changes Across a 24-Hour Period'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [0:4]
        set ytics 0, 0.5, 4
        set format y "%.2f"
        plot "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'XRP'
EOF
}

# plot 4: get BNB USD prices
bnbpricechanges() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/bnbpricechanges.png'
        set title 'BNB USD Prices in a Day'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [800:1000]
        set ytics 800, 25, 1000
        set format y "%.2f"
        plot "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'BNB'
EOF
}

# plot 5: get all cryptocurrency USD prices
allpricechanges() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile2.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile3.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile4.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/allpricechanges.png'
        set title 'Cryptocurrency Price Changes Across a 24-Hour Period'
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
		"gnuplot/outfile.dat" u 1:2 w lp lc rgb 'red' pt 2 t 'Bitcoin', \
		"gnuplot/outfile2.dat" u 1:2 w lp lc rgb 'yellow' pt 2 t 'Ethereum', \
        	"gnuplot/outfile3.dat" u 1:2 w lp lc rgb 'green' pt 2 t 'XRP', \
		"gnuplot/outfile4.dat" u 1:2 w lp lc rgb 'blue' pt 2 t 'BNB'
EOF
}

# plot 6: compare 24hr highest & lowest price of Bitcoin
bitcoin24hr() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile2.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/bitcoin24hr.png'
        set title 'Highest & Lowest Bitcoin Prices in 24 Hours Across One Week'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [80000:100000]
        set ytics 80000, 2500, 100000
        set format y "%.2f"
        plot \
                "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile2.dat" u 1:2 w lp lw 2 lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 7: compare 24hr highest & lowest price of Ethereum
ethereum24hr() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile2.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/ethereum24hr.png'
        set title 'Highest & Lowest Ethereum Prices in 24 Hours Across One Week'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [2000:5000]
        set ytics 2000, 500, 5000
        set format y "%.2f"
        plot \
                "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile2.dat" u 1:2 w lp lw 2 lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 8: compare 24hr highest & lowest price of XRP
xrp24hr() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile2.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/xrp24hr.png'
        set title 'Highest & Lowest XRP Prices in 24 Hours Across One Week'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [0:4]
        set ytics 0, 0.25, 4
        set format y "%.2f"
        plot \
                "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile2.dat" u 1:2 w lp lw 2 lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 9: compare 24hr highest & lowest price of BNB
bnb24hr() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-01' AND '2025-12-09'
AND TIME(datecollected) BETWEEN '00:00:00' AND '00:00:59';
" > gnuplot/outfile2.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/bnb24hr.png'
        set title 'Highest & Lowest BNB Prices in 24 Hours Across One Week'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [800:1000]
        set ytics 800, 25, 1000
        set format y "%.2f"
        plot \
                "gnuplot/outfile.dat" u 1:2 w lp lw 2 lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile2.dat" u 1:2 w lp lw 2 lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 10: plot price changes, lowest and highest prices in 24hrs of Bitcoin
bitcoinstats() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile2.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 1
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile3.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/bitcoinstats.png'
        set title 'Overall Bitcoin Price Statistics'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [80000:100000]
        set ytics 80000, 2500, 100000
        set format y "%.2f"
        plot \
                "gnuplot/outfile.dat" u 1:2 w lp lc rgb 'blue' pt 2 t 'Price Changes ($)', \
                "gnuplot/outfile2.dat" u 1:2 w lp lc rgb 'red' pt 2 t 'Lowest Price', \
		"gnuplot/outfile3.dat" u 1:2 w lp lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 11: plot price changes, lowest and highest prices in 24hrs of Ethereum
ethereumstats() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile2.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 2
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile3.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/ethereumstats.png'
        set title 'Overall Ethereum Price Statistics'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [2000:5000]
        set ytics 2000, 200, 5000
        set format y "%.2f"
        plot \
                "gnuplot/outfile.dat" u 1:2 w lp lc rgb 'blue' pt 2 t 'Price Changes ($)', \
                "gnuplot/outfile2.dat" u 1:2 w lp lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile3.dat" u 1:2 w lp lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 12: plot price changes, lowest and highest prices in 24hrs of XRP
xrpstats() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile2.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 3
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile3.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/xrpstats.png'
        set title 'Overall XRP Price Statistics'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [0:4]
        set ytics 0, 0.5, 4
        set format y "%.2f"
        plot \
		"gnuplot/outfile.dat" u 1:2 w lp lc rgb 'blue' pt 2 t 'Price Changes ($)', \
                "gnuplot/outfile2.dat" u 1:2 w lp lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile3.dat" u 1:2 w lp lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# plot 13: plot price changes, lowest and highest prices in 24hrs of BNB
bnbstats() {
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, price_usd FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, lowest_24h FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile2.dat
mysql -u "$user" -N -e "
USE bitcoin_tracker;
SELECT datecollected, highest_24h FROM prices WHERE currencyID = 4
AND datecollected BETWEEN '2025-12-10 00:00:00' AND '2025-12-11 00:00:59';
" > gnuplot/outfile3.dat

gnuplot <<EOF
        set terminal png font 'Arial' size 1280, 720
        set output 'gnuplot/bnbstats.png'
        set title 'Overall BNB Price Statistics'
        set xlabel 'Date Collected'
        set ylabel 'Price USD ($)'
        set xdata time
        set timefmt "%Y-%m-%d %H:%M:%S" # format time in output file
        set format "%d-%m\n%H:%M" # output time in image
        set datafile separator "\t" # separate data into columns
        set grid
        set yrange [800:1000]
        set ytics 800, 25, 1000
        set format y "%.2f"
        plot \
		"gnuplot/outfile.dat" u 1:2 w lp lc rgb 'blue' pt 2 t 'Price Changes ($)', \
                "gnuplot/outfile2.dat" u 1:2 w lp lc rgb 'red' pt 2 t 'Lowest Price', \
                "gnuplot/outfile3.dat" u 1:2 w lp lc rgb 'green' pt 2 t 'Highest Price'
EOF
}

# parameters for executing function
if [[ "$1" == "bitcoinpricechanges" ]]; then
	bitcoinpricechanges
elif [[ "$1" == "ethereumpricechanges" ]]; then
	ethereumpricechanges
elif [[ "$1" == "xrppricechanges" ]]; then
        xrppricechanges
elif [[ "$1" == "bnbpricechanges" ]]; then
        bnbpricechanges
elif [[ "$1" == "allpricechanges" ]]; then
        allpricechanges
elif [[ "$1" == "bitcoin24hr" ]]; then
        bitcoin24hr
elif [[ "$1" == "ethereum24hr" ]]; then
        ethereum24hr
elif [[ "$1" == "xrp24hr" ]]; then
        xrp24hr
elif [[ "$1" == "bnb24hr" ]]; then
        bnb24hr
elif [[ "$1" == "bitcoinstats" ]]; then
        bitcoinstats
elif [[ "$1" == "ethereumstats" ]]; then
        ethereumstats
elif [[ "$1" == "xrpstats" ]]; then
        xrpstats
elif [[ "$1" == "bnbstats" ]]; then
	bnbstats
else
	echo "Invalid parameter! Please try again"
	exit 1
fi
