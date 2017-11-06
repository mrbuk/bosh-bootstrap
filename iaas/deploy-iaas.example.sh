# this file be sourced into the parent deploy.sh script
#
# add here IaaS specfic ops files and configurations
#

function deploy() {
  $cmd $scmd bosh-deployment/bosh.yml \
    -o ${BOSH_DEPLOYMENT}/gcp/cpi.yml \
    -o ${BOSH_DEPLOYMENT}/jumpbox-user.yml \
    $@
}

# -o ${BOSH_DEPLOYMENT}/gcp/service-account.yml \
