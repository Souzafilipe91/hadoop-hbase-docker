#!/bin/bash

hadoop_master="serene_greider"  # Substitua pelo nome real do seu contêiner Hadoop Master
hadoop_slave="slave1"    # Substitua pelo nome real do seu contêiner Hadoop Slave
hbase_home="D:/hadoop-hbase-docker/hadoop-hbase-master/files/hbase"

echo -e "starting hbase on master \n"
docker exec -it "$hadoop_master" "${hbase_home}/start-hbase.sh"

echo -e "starting hbase on slaves \n"
docker exec -it "$hadoop_slave" "${hbase_home}/start-hbase.sh"

# Restante do seu script...
sleep 5
echo -e "starting hbase shell  \n"
docker exec -it "$hadoop_master" /bin/hbase shell