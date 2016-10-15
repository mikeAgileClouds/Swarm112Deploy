#!/bin/sh
docker service  update --publish-add 7979:5000 ${JOB_NAME}_apigateway
