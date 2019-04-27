#!/usr/bin/env make

include .env
export

default:
	@docker build --network=host -t recom.live .
	@docker create -it --network=host --env-file .env -p ${RECOM_SERVER_PORT}:${RECOM_SERVER_PORT}/udp --name recom_live recom.live

start:
	@docker container start recom_live

stop:
	@docker container stop recom_live

restart:
	@docker container restart recom_live

clean:
	@docker container rm recom_live
	@docker image rm recom.live

