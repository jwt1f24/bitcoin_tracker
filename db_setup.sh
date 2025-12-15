#!/bin/bash

user="root"
dbdump="database/bitcoin_tracker.sql"

# import database dump file
if mysql -u "$user" < "$dbdump"; then
	echo "Database dump file has been imported!"
else
	echo "Error! Import failed."
	exit 1
fi
