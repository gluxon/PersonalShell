#!/bin/sh

# Get full path of script
# http://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself
SCRIPTPATH=$( cd "$(dirname "$0")" ; pwd -P ) 

docker-compose -f $SCRIPTPATH/docker-compose.yml run --rm personalshell
