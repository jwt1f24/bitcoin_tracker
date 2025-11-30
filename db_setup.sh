#!/bin/bash

user="root"

# activate mysql to create database and tables
mysql -u "$user" <<EOFMYSQL

CREATE DATABASE bitcoin_tracker;
USE bitcoin_tracker;

CREATE TABLE cryptocurrency (
	currencyID INT AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE prices (
        priceID INT AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
        currencyID INT NOT NULL,
	price_usd DECIMAL(20, 2) NOT NULL,
	lowest_24h DECIMAL(20, 2) NOT NULL,
	highest_24h DECIMAL(20, 2) NOT NULL,
	datecollected DATETIME NOT NULL,
	FOREIGN KEY (currencyID) REFERENCES cryptocurrency(currencyID)
);

EOFMYSQL
echo "Database is successfully created!"
