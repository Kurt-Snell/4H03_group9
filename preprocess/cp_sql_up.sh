#!/usr/bin/bash

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 26 March 2025
# Updated: 26 March 2025

# Bash script to copy a file to the MySQL Server Upload folder
# In the current working directory, call `sh cp_sql_up "filename"`

# Hardcode path in
path_to_mysql_upload_folder="/c/ProgramData/MySQL/MySQL Server 8.0/Uploads/"

# Output information to user
echo "Copying $1 to $path_to_mysql_upload_folder"

# Copy file over
cp $1 "$path_to_mysql_upload_folder"