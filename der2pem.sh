#!/bin/bash

if [ "$1" == "" ]; then
    echo "Specify the DER certificate file"
    echo "Usage: ./der2pem.sh /path/to/burp_ca.der"
    exit
fi

if [ -f $1 ]; then
    openssl x509 -inform DER -in $1 -out cacert.pem
    openssl x509 -in cacert.pem -text -fingerprint -sha1 -noout >> cacert.pem
    CERT_NAME=$(openssl x509 -inform PEM -subject_hash_old -in cacert.pem | head -1)
    mv cacert.pem "${CERT_NAME}.0"
else
    echo "$1: No such file."
fi

