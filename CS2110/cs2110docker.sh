#!/bin/bash

imageName="gtcs2110/cs2110docker"

docker -v >/dev/null

dockerExists=$?

if  [ $dockerExists != 0 ]; then
  >&2 echo "ERROR: Please install Docker before running this script. Refer to the CS 2110 Docker Guide."
  exit 1
fi

docker container ls >/dev/null
dockerNotRunning=$?

if [ $dockerNotRunning != 0 ]; then
  >&2 echo "ERROR: Docker is not currently running. Please start Docker before running this script."
  exit 1
fi

echo "Found Docker Installation. Checking for existing containers."

existingContainers=$(docker ps -a | grep $imageName | awk '{print $1}')
echo $existingContainers
if [ -n "$existingContainers" ]; then
  echo "Found CS 2110 containers. Stopping and removing them."
  docker stop $existingContainers >/dev/null
  docker rm $existingContainers >/dev/null
else
  echo "No existing CS 2110 containers."
fi

if [ -n "$1" ] && [ "$1" = "stop" ]; then
  echo "Successfully stopped CS 2110 containers"
  exit
fi

echo Pulling down most recent image of $imageName
docker pull $imageName

successfulPull=$?

if [ $successfulPull != 0 ]; then
  >&2 echo "ERROR: Unable to pull down the most recent image of $imageName"
fi

echo "Starting up new CS 2110 Docker Container:"

ipAddress="$(docker-machine ip default 2>/dev/null)"
foundIp=$?

if [ $foundIp != 0 ]; then
  ipAddress="127.0.0.1"
fi

# -W should correct path incompatibilites on Windows for Docker Desktop users
currDir="$(pwd -W 2>/dev/null || pwd)"

if [ "$1" = "-it" ]; then
  docker run --rm -p $ipAddress:6901:6901 -p $ipAddress:5901:5901 -v "$currDir":/cs2110/host/ --cap-add=SYS_PTRACE --security-opt seccomp=unconfined -it  --entrypoint //bin/bash "$imageName"
else
  docker run -d -p $ipAddress:6901:6901 -p $ipAddress:5901:5901 -v "$currDir":/cs2110/host/ --cap-add=SYS_PTRACE --security-opt seccomp=unconfined "$imageName"

  successfulRun=$?

  if [ $successfulRun = 0 ]; then
    echo "Successfully launched CS 2110 Docker container. Please go to http://$ipAddress:6901/vnc.html to access it."
  else
    >&2 echo "ERROR: Unable to launch CS 2110 Docker container."
  fi
fi

