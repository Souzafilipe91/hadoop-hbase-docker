#!/bin/bash

hadoop_master="serene_greider"
hadoop_slave="slave1"
script_path_on_host="D:/hadoop-hbase-docker/hadoop-hbase-master/files/hbase/start-hbase.sh"
script_path_in_container="/usr/local/hbase/start-hbase.sh"

echo -e "Copying script to container \n"
winpty docker cp "$script_path_on_host" "$hadoop_master:$script_path_in_container"
winpty docker cp "$script_path_on_host" "$hadoop_slave:$script_path_in_container"

echo -e "starting hbase on master \n"
winpty docker exec -it "$hadoop_master" bash -c "cd /usr/local/hbase && $script_path_in_container"

echo -e "starting hbase on slaves \n"
winpty docker exec -it "$hadoop_slave" bash -c "cd /usr/local/hbase && $script_path_in_container"

sleep 5
echo -e "starting hbase shell  \n"
winpty docker exec -it "$hadoop_master" bash -c "cd /usr/local/hbase && ./bin/hbase shell"
