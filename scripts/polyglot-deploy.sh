#!/bin/sh
echo $1
if [ $# != 1 ] 
then
  echo "Usage: $0 <project name>"
  exit 1
fi

docker service  update --publish-add 7979:5000 ${1}_apigateway
