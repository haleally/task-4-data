#!/bin/bash
GHUSERNAME="haleally"
#Ask question 1
echo "What is your first name?"
read ANSWER1

#Ask question 2
echo "What is your eye color?"
read ANSWER2

#Ask question 3
echo "What country were you born in?"
read ANSWER3

#Ask question 4
echo "Have you ever had a dog?"
read ANSWER4

#Ask question 5
echo "How old are you?"
read ANSWER5

# Write the datestamp to a variable 
TIMESTAMP = `date --iso-8601=seconds`

#Create unique identifier
IDENTIFIER="`echo $RANDOM$RANDOM$RANDOM | sha1sum | sed 's/[^0-9a-fA-F]//g' | sed -e 's/^/0x/'`"

#Write data to tmp.csv
echo "$UID, $TIMESTAMP, $ANSWER1, $ANSWER2, $ANSWER3, $ANSWER4, $ANSWER5" >> ./temp.csv

# Read out the data in the CSV file
cat temp.csv

#Write data to database
bash ./haleally-database.sh

cat ./temp.csv >> data-backup.csv

rm temp.csv
