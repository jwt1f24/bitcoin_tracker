#!/bin/bash

user="root"

# activate mysql to create database and tables
mysql -u "$user" <<EOFMYSQL

CREATE DATABASE IF NOT EXISTS bitcoin_tracker;
USE bitcoin_tracker;

CREATE TABLE IF NOT EXISTS cryptocurrency (
	currencyID INT AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS prices (
        priceID INT AUTO_INCREMENT PRIMARY KEY UNIQUE NOT NULL,
        currencyID INT NOT NULL,
	price_usd DECIMAL(20, 2) NOT NULL,
	lowest_24h DECIMAL(20, 2) NOT NULL,
	highest_24h DECIMAL(20, 2) NOT NULL,
	datecollected DATETIME NOT NULL,
	FOREIGN KEY (currencyID) REFERENCES cryptocurrency(currencyID)
);

INSERT INTO cryptocurrency(name) VALUES
("Bitcoin"), ("Ethereum"), ("XRP"), ("BNB");

EOFMYSQL
echo "Database and tables are successfully created! Data can be inserted now."
