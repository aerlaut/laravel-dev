#!/bin/bash

# local ip to setup
IMG_NAME=aerlaut/laravel-base
HOST=0.0.0.0
PORT=8080

if [ "$1" == 'build' ]; then

  # echo ask for tag
  if [ -n "$2" ]; then

    echo "Building image : $IMG_NAME:$2"
    docker rmi -f "$IMG_NAME":"$2"
    docker build . -f Dockerfile -t "$IMG_NAME":"$2"

  else

    echo "Building image : $IMG_NAME:base"
    docker rmi -f "$IMG_NAME":base
    docker build . -f Dockerfile -t "$IMG_NAME":base

  fi

elif [ "$1" = 'run' ]; then

  docker run -d --rm -p $HOST:$PORT:80 $IMG_NAME

elif [ "$1" = 'tty' ]; then

  docker exec -it "$2" /bin/sh

fi