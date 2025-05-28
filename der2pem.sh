#!/bin/bash

if [ "$1" != "" ]; then
    if [ -f $1 ]; then
        openssl x509 -inform DER -in $1 -out cacert.pem
        openssl x509 -in cacert.pem -text -fingerprint -sha1 -noout >> cacert.pem
        CERT_NAME=$(openssl x509 -inform PEM -subject_hash_old -in cacert.pem | head -1)
        mv cacert.pem "${CERT_NAME}.0"
    else
        echo "$1 is not exists"
    fi
else
    echo "Specify the DER certificate file"
fi

