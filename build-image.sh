#!/bin/bash

image=$1
tag='latest'


if [ $1 -eq 0 ]
then
	echo "Please use image name as the first argument!"
	exit 1
fi

if [ $# -gt 0 ]; then
  docker rm -f slave1.krejcmat.com slave2.krejcmat.com master.krejcmat.com
fi
# founction for delete images
function docker_rmi()
{
	echo -e "\n\ndocker rmi krejcmat/$1:$tag"
	docker rmi krejcmat/$1:$tag
}


# founction for build images
function docker_build()
{
	cd $1
	echo -e "\n\ndocker build -t krejcmat/$1:$tag ."
	docker build -t krejcmat/$1:$tag .
	cd ..
}

echo -e "\ndocker rm -f slave1.krejcmat.com slave2.krejcmat.com master.krejcmat.com"
docker rm -f slave1.krejcmat.com slave2.krejcmat.com master.krejcmat.com

docker images >images.txt

#all image is based on dnsmasq. master and slaves are based on base image.
if [ $image == "hadoop-hbase-base" ]
then
	docker_rmi hadoop-hbase-master
	docker_rmi hadoop-hbase-slave
	docker_rmi hadoop-hbase-base
	docker_build hadoop-hbase-base
	docker_build hadoop-hbase-master
	docker_build hadoop-hbase-slave
elif [ $image == "hadoop-hbase-master" ]
then
	docker_rmi hadoop-hbase-master
	docker_build hadoop-hbase-master
elif [ $image == "hadoop-hbase-slave" ]
then
	docker_rmi hadoop-hbase-slave
	docker_build hadoop-hbase-slave
else
	echo "The image name is wrong!"
fi

#docker_rmi hadoop-hbase-base

echo -e "\nimages before build"
cat images.txt
rm images.txt

echo -e "\nimages after build"
docker images
