#!/bin/bash

user="root"

# activate mysql to create database and tables
mysql -u "$user" <<EOFMYSQL

CREATE DATABASE bitcoin_tracker;
USE bitcoin_tracker;

EOFMYSQL
echo "Database is successfully created!"
