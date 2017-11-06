#!/bin/bash

ENV=
IAAS=
NO_RUN=

while getopts "e:i:dx" option
do
 case "${option}"
 in
 e) ENV=${OPTARG};;
 i) IAAS=${OPTARG};;
 x) NO_RUN=true;;
 esac
done
# shift so that we can provide rest of the arguments to
# the bosh deploy
# e.g './deploy.sh -e qa -- --recreate' should result in a 'bosh deploy --recreate'
shift $(expr $OPTIND - 1)

if [ -z $ENV ]; then
	echo "Please provide a env via '-e [local|dev|prod]'"
	exit 1
fi

if [ -z $IAAS ]; then
	echo "Please provide a env via '-i [boshlite|vsphere|gcp]'"
	exit 1
fi

scmd="create-env $@"
if [ $INT ]; then
	scmd="int"
fi

if [ $DEBUG ]; then
  export BOSH_LOG_LEVEL=debug
fi

cmd='bosh'
if [ $NO_RUN ]; then
  cmd='echo bosh'
fi

#
# make sure you downloaded the releases and manually uploaded via bosh upload-release
#
BOSH_DEPLOYMENT=./bosh-deployment

source ./iaas/deploy-${IAAS}.sh
deploy \
  -o ${BOSH_DEPLOYMENT}/uaa.yml \
  --state=env/${ENV}/state.json \
  --vars-file env/${ENV}/vars.yml \
  --vars-file env/${ENV}/${IAAS}.yml \
  --vars-store env/${ENV}/creds.yml \
  -o ${BOSH_DEPLOYMENT}/jumpbox-user.yml
