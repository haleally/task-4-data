#!/bin/bash

#Ask question 1
echo "Question 1"
read ANSWER1

#Ask question 2
echo "Question 2"
read ANSWER2

#Ask question 3
echo "Question 3"
read ANSWER3

#Ask question 4
echo "Question 4"
read ANSWER4

#Ask question 5
echo "Question 5"
read ANSWER5

# Write the datestamp to a variable 
date --iso-8601=seconds
read TIMESTAMP

#Create unique identifier
echo '$RANDOM-$RANDOM' | sha256sum | sed 's/[\s\-]//g'
read UID

#Write data to tmp.csv
echo "$ UID, $TIMESTAMP, $ANSWER1, $ANSWER2, $ANSWER3, $ANSWER4, $ANSWER5" >> ./temp.csv

# Read out the data in the CSV file
cat temp.csv

#Write data to database
bash ./write-to-db.sh
