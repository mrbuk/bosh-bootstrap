function deploy() {
  $cmd $scmd bosh-deployment/bosh.yml \
    -o ${BOSH_DEPLOYMENT}/gcp/cpi.yml \
    -o ${BOSH_DEPLOYMENT}/jumpbox-user.yml \
    $@
}

# -o ${BOSH_DEPLOYMENT}/gcp/service-account.yml \
