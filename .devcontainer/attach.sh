#!/bin/bash

# Get name of repository
SCRIPTDIR=$(dirname "$0")
REPO_NAME=$(basename $(realpath "$SCRIPTDIR"/..))

docker exec -it "$(docker ps -alqf "name=$REPO_NAME")" bash
