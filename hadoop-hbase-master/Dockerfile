FROM sebge2/hadoop-hbase-base:latest
MAINTAINER sgerard <sgerard@emasphere.com>

# Copiar todos os arquivos de configuração para o diretório /tmp/
COPY files/hadoop/* /tmp/
COPY files/hbase/* /tmp/
COPY docker-entrypoint.sh /tmp/
COPY docker-entrypoint.sh /root/

RUN chmod +x /tmp/docker-entrypoint.sh

ENV HADOOP_INSTALL /usr/local/hadoop

# Certifique-se de que o diretório /usr/local/hbase existe
RUN mkdir -p /usr/local/hbase

# Crie os diretórios necessários
RUN mkdir -p /usr/local/hbase/hdfs/namenode \
    && mkdir -p /usr/local/hbase/zookeeper \
    && mkdir -p /usr/local/hbase/hdfs/datanode

# Mover arquivos de configuração e scripts
RUN mv /tmp/hdfs-site.xml $HADOOP_INSTALL/etc/hadoop/hdfs-site.xml \
    && mv /tmp/core-site.xml $HADOOP_INSTALL/etc/hadoop/core-site.xml \
    && mv /tmp/mapred-site.xml $HADOOP_INSTALL/etc/hadoop/mapred-site.xml \
    && mv /tmp/yarn-site.xml $HADOOP_INSTALL/etc/hadoop/yarn-site.xml \
    && mv /tmp/stop-hadoop.sh ~/stop-hadoop.sh \
    && mv /tmp/start-hadoop.sh ~/start-hadoop.sh \
    && mv /tmp/run-wordcount.sh ~/run-wordcount.sh \
    && mv /tmp/start-ssh-serf.sh ~/start-ssh-serf.sh \
    && mv /tmp/hbase-site.xml /usr/local/hbase/conf/hbase-site.xml \
    && mv /tmp/configure-members.sh ~/configure-members.sh \
    && mv /tmp/stop-hbase.sh ~/stop-hbase.sh \
    && mv /tmp/start-hbase.sh ~/start-hbase.sh \
    && mv /tmp/docker-entrypoint.sh ~/docker-entrypoint.sh

# Dar permissões adequadas aos scripts
RUN chmod +x ~/start-hadoop.sh \
    && chmod +x ~/run-wordcount.sh \
    && chmod +x ~/start-ssh-serf.sh \
    && chmod +x ~/docker-entrypoint.sh \
    && chmod 1777 /tmp

# Formatar o namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

# Expor as portas
EXPOSE 22 7373 7946 9000 50010 50020 50070 50075 50090 50475 8030 8031 8032 8033 8040 8042 8060 8088 50060 2818 60000 60010

# Comando padrão para iniciar o contêiner
CMD ["/root/docker-entrypoint.sh", "bash"]