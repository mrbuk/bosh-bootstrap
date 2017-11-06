function deploy() {
  $cmd $scmd bosh-deployment/bosh.yml \
    -o ${BOSH_DEPLOYMENT}/virtualbox/cpi.yml \
    -o ${BOSH_DEPLOYMENT}/virtualbox/outbound-network.yml \
    -o ${BOSH_DEPLOYMENT}/bosh-lite.yml \
    -o ${BOSH_DEPLOYMENT}/bosh-lite-runc.yml \
    $@
}
