#!/bin/sh

if [ ! -d /certs/live/ ]; then

cat << EOF > /tmp/answers.yaml
"acmetool-quickstart-choose-server": ${ACME_SERVER:-https://acme-v01.api.letsencrypt.org/directory}
"acmetool-quickstart-choose-method": webroot
"acmetool-quickstart-webroot-path": "/certs/root/.well-known/acme-challenge"
"acmetool-quickstart-complete": true
# Currently acmetool cron does not support busybox's cron
"acmetool-quickstart-install-cronjob": false
"acmetool-quickstart-install-haproxy-script": false
"acmetool-quickstart-install-redirector-systemd": false
"acmetool-quickstart-key-type": ${KEY_TYPE:-ecdsa}
"acmetool-quickstart-rsa-key-size": ${RSA_KEY_SIZE:-4096}
"acmetool-quickstart-ecdsa-curve": ${ECDSA_CURVE:-nistp256}
"acme-enter-email": ${ACME_EMAIL}
EOF

acmetool quickstart --expert --stdio --response-file /tmp/answers.yaml
rm /tmp/answers.yaml

fi

exec crond -f -d 8
