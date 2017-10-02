#!/bin/bash
set -e

DOCKER_RUN_IMAGE=bata/nginx-rtmp
DOCKER_BUILD_IMAGE=nginx-build

rm -f nginx.tar.gz

cd build

docker build -t ${DOCKER_BUILD_IMAGE} .

cd ..

DID=`docker create ${DOCKER_BUILD_IMAGE}`

docker cp ${DID}:/tmp/nginx.tar.gz ./

docker rm ${DID}
docker rmi ${DOCKER_BUILD_IMAGE}

docker build -t ${DOCKER_RUN_IMAGE} .

docker images
docker ps -a
