# NTRMDA Test Environment

Work in progress...

## Quick Start

```sh
cd path/to/ntrdma-test
ln -s path/to/ntrdma ntrdma
ln -s path/to/ntrdma-lib ntrdma-lib

make

# If you have virtual machines,
#   now might be a good time to take a snapshot!
make deploy
```

## Equipment

You will need a couple servers for targeting the deploy.  The scripts will use
whatever server happens to be listening at `192.168.122.10` and
`192.168.122.20`.  So far this has only been used with qemu virtual machines
running Fedora 24 minimal and just a few added packages.

Fedora 24 minimal configuration:

```sh
dnf install rsync vim
dnf install libibverbs libibverbs-utils qperf
systemctl disable firewalld.service
systemctl stop firewalld.service
```
