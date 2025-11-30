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

EOFMYSQL
echo "Database is successfully created!"
