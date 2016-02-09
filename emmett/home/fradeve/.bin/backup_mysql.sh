#!/bin/bash
rm $HOME/.bin/mysqldump_all_databases.sql
/usr/bin/mysqldump --defaults-extra-file=/home/fradeve/.keys/mysqldump/my.cnf --all-databases > $HOME/.bin/mysqldump_all_databases.sql
/bin/chmod 600 $HOME/.bin/mysqldump_all_databases.sql
