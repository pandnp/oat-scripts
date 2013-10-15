#!/bin/sh

OAT=$1

# database initialization
echo "mysql database initialization"
if !(mysql -uroot -p -e 'use mw_as'); then
  mysql -uroot -p -e 'create database mw_as';
  mysql -uroot -p mw_as < $OAT/database/mysql/src/main/resources/com/intel/mtwilson/database/mysql/mtwilson.sql
fi
