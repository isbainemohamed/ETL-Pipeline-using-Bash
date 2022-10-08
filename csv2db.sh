# This script
# Extracts data from /etc/passwd file into a CSV file.

# The csv data file contains the user name, user id and 
# home directory of each user account defined in /etc/passwd

# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.

echo "Extracting data "

cut -d":" -f1,3,6 /etc/passwd > extracted-data.txt

echo "Transforming data "
tr ":" "," < extracted-data.txt > transformed-data.csv 


# Load phase
echo "Loading data"
# Send the instructions to connect to 'template1' and
# copy the file to the table 'users' through command pipeline.

echo "\c template1;\COPY users  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=localhostecho '\c template1; \\SELECT * from users;' | psql --username=postgres --host=localhost