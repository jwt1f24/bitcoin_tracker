#!/bin/bash

dbname="bitcoin_tracker"
user="root"

bitcoinpriceusd() {
	gnuplot <<EOF
	set terminal png font 'Arial'
	set title 'Bitcoin USD Prices'
	set output 'image.png'
	plot "outfile.dat" u 1:2 w l t 'data'
	EOF
}
