function deploy() {
  $cmd $scmd bosh-deployment/bosh.yml \
    -o ${BOSH_DEPLOYMENT}/vsphere/cpi.yml \
    $@
}

# -o ${BOSH_DEPLOYMENT}/gcp/service-account.yml \
