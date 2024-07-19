SHELL := /bin/bash
# Maintained by gyfary@gmail.com
export DN=/C=ID/ST=JKT/L=Jakarta Selatan/O=System Engineer/OU=IT
# Edit here for temporary git global config.
export FIRST_NAME=System
export LAST_NAME=Engineer
export EMAIL=gyfary@gmail.com

.PHONY: help test clean

## -----------------------------------------------------------------
## The following is a help file, for local development
## -----------------------------------------------------------------


help:			## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

test:			## initest
	echo test

build:			## Build docker locally
	docker build -t hiage/redis:7.2.5 -f Dockerfile .

setup:			## Create config redis-cluster
	chmod +x setup.sh
	./setup.sh

clean: 			## Delete config redis-cluster
	sudo rm -rf redis

start:			## Start redis-cluster
	docker-compose -f docker-compose.yaml up -d --force-recreate

cluster:		## Setup join redis-cluster
	docker exec -it redis-cluster-master-1.dtx sh -c "echo yes | redis-cli --cluster create redis-cluster-master-1.dtx:6379 redis-cluster-master-2.dtx:6379	redis-cluster-master-3.dtx:6379	redis-cluster-slave-4.dtx:6379 redis-cluster-slave-5.dtx:6379 redis-cluster-slave-6.dtx:6379 --cluster-replicas 1"

cluster-check:		## Check redis-cluster
	docker exec -t redis-cluster-master-1.dtx sh -c "redis-cli cluster nodes"

stop:			## Stop and remove container
	docker-compose down -v

ps:			## See container running
	docker-compose ps