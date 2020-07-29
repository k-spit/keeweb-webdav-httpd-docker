keeweb-webdav-httpd-docker
===

# Preparation  
## Create [`keeweb.conf`](keeweb.conf_example) file

## Supply a valid `.kdbx` file to the root of this project. Name it `keeweb.kdbx`. This file will be used as webDAV target.

## Supply valid SSL Cert `cert.pem` and SSL Key `key.pem` in the root of this project.

# Usage - Docker

```shell
docker build -t keeweb-webdav-httpd-docker .

docker run \
    -d \
    -p 443:443 \
    --name keeweb-webdav-httpd-docker \
    keeweb-webdav-httpd-docker
```

## References  
https://git.kaki87.net/KaKi87/tutorials/src/branch/master/how_to_self_host_keeweb