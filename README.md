# acmetool on Docker

This image runs [acmetool](https://github.com/hlandau/acme) with cronjob to automatically renew certificates.

## Usage

You need to mount `/certs` into the container, and possibly your web server. It contains acmetool's [state directory](https://github.com/hlandau/acme/blob/master/_doc/SCHEMA.md).

Your web server must be configured to serve `/.well-known/acme-challenge/` from `/certs/root/.well-known/acme-challenge/`, as this is how acmetool will verify certificates.

Example usage:

```sh
sudo docker run -d --name acmetool \
	-v certs:/certs \
	willwill/acme-docker
```

To issue certificates, use `docker exec`:

```sh
sudo docker exec acmetool acmetool want www.example.com example.com
```

### Options

Following environment variables are available:

- **KEY_TYPE**: rsa/ecdsa (default to ecdsa)
- **RSA_KEY_SIZE**: default to 4096
- **ECDSA_CURVE**: nistp256/nistp384/nistp521 (default to nistp256)
- **ACME_EMAIL**: registration email (default to nothing)
- **ACME_SERVER**: acme endpoint (default to https://acme-v01.api.letsencrypt.org/directory)

(to specify environment variable, pass `-e VARIABLE=value` to `docker run` before the image name)
