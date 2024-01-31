#!/bin/bash
#hadoop_home=/usr/local/hbase

hadoop_master="serene_greider"
hadoop_slave="slave1"   
hbase_home="/usr/local/hbase"

echo -e "starting hbase on master \n"
docker exec -it serene_greider bash -c "cd $hbase_home/hbase && ./start-hbase.sh"

echo -e "starting hbase on slaves \n"
docker exec -it slave1 bash -c "cd $hbase_home/hbase && ./start-hbase.sh"

sleep 5
echo -e "starting hbase shell  \n"
docker exec -it serene_greider bash -c "cd \"$hbase_home\" && ./bin/hbase shell"