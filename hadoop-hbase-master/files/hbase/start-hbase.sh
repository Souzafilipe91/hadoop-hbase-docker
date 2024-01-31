#!/bin/bash

start_hbase_script="/usr/local/hbase/hbase/start-hbase.sh"

echo -e "starting hbase on master \n"
winpty docker exec -it "$hadoop_master" bash -c "cd \"$start_hbase_script\" && ./start-hbase.sh"

echo -e "starting hbase on slaves \n"
winpty docker exec -it "$hadoop_slave" bash -c "cd \"$start_hbase_script\" && ./start-hbase.sh"

sleep 5
echo -e "starting hbase shell  \n"
winpty docker exec -it "$hadoop_master" bash -c "cd \"$start_hbase_script\" && ./bin/hbase shell"
