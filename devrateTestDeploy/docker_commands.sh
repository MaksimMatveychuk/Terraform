#!/bin/bash

set -e

aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin $1.dkr.ecr.eu-north-1.amazonaws.com

docker build -t backrepository .

docker tag backrepository:latest $1.dkr.ecr.eu-north-1.amazonaws.com/backrepository:latest

docker push $1.dkr.ecr.eu-north-1.amazonaws.com/backrepository:latest
