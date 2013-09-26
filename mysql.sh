#!/bin/sh

OAT=$1

# database initialization
echo "database initialization"
if !(mysql -uroot -e 'use mw_as'); then
  mysql -uroot -e 'create database mw_as';
  mysql -uroot mw_as < $OAT/database/mysql/src/main/resources/com/intel/mtwilson/database/mysql/mtwilson.sql
fi
