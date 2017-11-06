# BOSH Bootstrap

Bootstrap a BOSH Director based on [bosh-deployment](https://github.com/cloudfoundry/bosh-deployment).

It is similar to [BOSH Bootloader](https://github.com/cloudfoundry/bosh-bootloader) but way simpler (no terraforming etc.) should allow you to easily adjust it to your needs as everything is a shell script.

At the moment we expect that your IaaS is paved. Meaning the networks you configure need to exist before you run the `deploy.sh`.

Also make sure that you can reach from the machine you deploy the BOSH Director machine on properties
* 6868 (_minimum for deployment to succeed_)
* 8443 (_to access Director_)
* 25555 (_to access Director_)

## Deploying a BOSH Director

Ensure that the [bosh-deployment](https://github.com/cloudfoundry/bosh-deployment) submodule is checked out before you try to deploy (see `git submodule -h` for details).

To deploy BOSH Lite v2 run from the repository

```
./deploy.sh -e local -i boshlite
```

After it succeeds create an alias

```
bosh alias-env vbox -e 192.168.50.6 --ca-cert <(bosh int ./env/local/creds.yml --path /director_ssl/ca)


Using environment '192.168.50.6' as anonymous user

Name      bosh-local
UUID      ff8b737b-84b0-4b47-ae1f-341f8d0055d6
Version   263.4.0 (00000000)
CPI       warden_cpi
Features  compiled_package_cache: disabled
          config_server: disabled
          dns: disabled
          snapshots: disabled
User      (not logged in)

Succeeded
```

if you like store the credentials in your environment using

```
export BOSH_ENVIRONMENT=vbox
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=$(bosh int ./env/local/creds.yml --path /admin_password)
```

## Credentials

All files conforming to that `**/creds.yml` pattern will not be checked in. Consider using GPG with a symmetric key or private/public key (e.g. [git-crypt](https://github.com/AGWA/git-crypt)).

**Todo:** Integrate with [CredHub](https://github.com/cloudfoundry-incubator/credhub) to get rid of handling the credentials in that repository.

## Adding support for a new IaaS

To add support for new IaaS simply do the following:
1. identify all needed parameters e.g. via `grep '((' gcp/cpi.yml` you will besides the standard ones `director_name, internal_ip, internal_gw, internal_cidr`
1. create a folder for your environment and place a file `env/myenv/vars.yml` with the previously extracted parameters into it
1. create a IaaS specific deploy script e.g. `iaas/deploy-gcp.sh`
