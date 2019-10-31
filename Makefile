#!/usr/bin/env make

include .env
export

default:
	@docker build --network=host -t recom.live .
	@docker create -it --env-file .env -p ${RECOM_SERVER_PORT}:${RECOM_SERVER_PORT}/udp --name recom_live_${RECOM_SERVER_PORT} recom.live

start:
	@docker container start recom_live_${RECOM_SERVER_PORT}

stop:
	@docker container stop recom_live_${RECOM_SERVER_PORT}

restart:
	@docker container restart recom_live_${RECOM_SERVER_PORT}

clean:
	@docker container rm recom_live_${RECOM_SERVER_PORT}
	@docker image rm recom.live

