#!/usr/bin/env bash

docker-machine create -d virtualbox swarm1
docker-machine create -d virtualbox swarm2
docker-machine create -d virtualbox swarm3

# initialize swarm master
docker-machine ssh swarm1 "docker swarm init \
    --listen-addr $(docker-machine ip swarm1) \
    --advertise-addr $(docker-machine ip swarm1)"

export worker_token=$(docker-machine ssh swarm1 "docker swarm join-token worker -q")

# join the two worker nodes
docker-machine ssh swarm2 "docker swarm join \
    --token=${worker_token} \
    --listen-addr $(docker-machine ip swarm2) \
    --advertise-addr $(docker-machine ip swarm2) \
    $(docker-machine ip swarm1)"
docker-machine ssh swarm3 "docker swarm join \
    --token=${worker_token} \
    --listen-addr $(docker-machine ip swarm3) \
    --advertise-addr $(docker-machine ip swarm3) \
    $(docker-machine ip swarm1)"
