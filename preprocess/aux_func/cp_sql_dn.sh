#!/usr/bin/bash

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 28 March 2025
# Updated: 28 March 2025

# Bash script to copy a file from the MySQL Server Upload folder
# In the current working directory, call `sh cp_sql_dn.sh "filename" "destination"`

# Hardcode path in
path_to_mysql_upload_folder="/c/ProgramData/MySQL/MySQL Server 8.0/Uploads/"

# Output information to user
echo "Copying $path_to_mysql_upload_folder$1 to $2"

# Copy file over
cp "$path_to_mysql_upload_folder$1" $2