# How to run & this project
Before executing any scripts, please ensure all files/folders are download and store in the same directory.
To ensure scripts can be executed, run in bash: chmod u+x *filename.sh*

# Create Database
To edit the script, run in bash: nano db_setup.sh
To execute script, run in bash: ./db_setup.sh
(Note that running this once is enough!)

# Insert Data manually into the Database
To edit the script, run in bash: nano bitcoin_tracker.sh
To execute script, run in bash: ./bitcoin_tracker.sh

# Crontab Setup
To allow bash to automatically execute the script, run in bash: crontab -e
You can also view crontab script by runnin in bash: crontab -l
Input at the end of file: 0 * * * * /home/*user*/bitcoin_tracker_36400092/bitcoin_tracker.sh
Save changes: CTRL + S
Exit script: CTRL + X

# Create GNU Plot
To edit the script, run in bash: nano plot.sh
To execute script, run in bash: ./plot.sh "*parameter*"

There are currently 13 parameters that can be executed:
- bitcoinpricechanges
- ethereumpricechanges
- xrppricechanges
- bnbpricechanges
- allpricechanges
- bitcoin24hr
- ethereum24hr
- xrp24hr
- bnb24hr
- bitcoinstats
- ethereumstats
- xrpstats
- bnbstats
