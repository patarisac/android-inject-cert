#!/bin/bash

PATH_SCRIPT=$(realpath "$0")
DIR_SCRIPT=$(dirname "$PATH_SCRIPT")
CERT_NAME=$(ls "$DIR_SCRIPT" | grep -E "(.*.0)")

TMP_DIR=/data/local/tmp

adb push "$DIR_SCRIPT/inject.sh" $TMP_DIR
adb push "$DIR_SCRIPT/$CERT_NAME" $TMP_DIR
if [ "$(adb shell which su)" == "/system/bin/su" ]; then
    adb shell "su -c CERTIFICATE_PATH=/data/local/tmp/$CERT_NAME sh $TMP_DIR/inject.sh" 
else
    adb shell "su root sh -c 'CERTIFICATE_PATH=/data/local/tmp/$CERT_NAME sh $TMP_DIR/inject.sh'" 
fi

