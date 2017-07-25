#!/bin/bash

# Setting variables
SQLUSER=root 
SQLPASS=root
DATABASE=survey
TABLE=tblSurvey

# Copy data to MySQL
touch mysql-files.sql
sudo cp ./temp.csv /var/lib/mysql-files/
echo "Data copied to secure directory."

# Create database
mysql -u"$SQLUSER" -p"$SQLPASS" -e "CREATE DATABASE $DATABASE"
 
# Create Table
mysql -u"$SQLUSER" -p"$SQLPASS" -e "CREATE TABLE $TABLE (ID VARCHAR(255), Date TIMESTAMP, ANSWER1 VARCHAR(255), ANSWER2 VARCHAR(255), ANSWER3 VARCHAR(255), ANSWER4 NUMERIC(5,2), ANSWER5 NUMERIC(5,2)); ALTER TABLE $TABLE ADD PRIMARY KEY (ID);" $DATABASE

# Write table to database
mysql -u"$SQLUSER" -p"$SQLPASS" -e "LOAD DATA INFILE '/var/lib/mysql-files/temp.csv' INTO TABLE $TABLE FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"';" $DATABASE

# Dump Database
mysqldump -u"$SQLUSER" -p"$SQLPASS" $DATABASE > `date --iso-8601=seconds`-$DATABASE.sql

# Delete temp.csv
sudo rm /var/lib/mysql-files/temp.csv