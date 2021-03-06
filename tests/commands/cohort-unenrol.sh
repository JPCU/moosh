#!/bin/bash
source functions.sh

install_db
install_data
cd $MOODLEDIR

$MOOSHCMD cohort-create testcohotr
$MOOSHCMD cohort-enrol -u 2 "testcohotr"
$MOOSHCMD cohort-unenrol 1 2

if ! echo "SELECT * FROM mdl_cohort_members WHERE userid = 2" \
    | mysql -u "$DBUSER" -p"$DBPASSWORD" "$DBNAME" | grep "cohortid"; then
  exit 0
else
  exit 1
fi