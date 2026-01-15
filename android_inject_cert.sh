#!/bin/bash

PATH_SCRIPT=$(realpath "$0")
DIR_SCRIPT=$(dirname "$PATH_SCRIPT")
CERT_NAME=$(ls "$DIR_SCRIPT" | grep -E "(.*.0)")
if [ "$CERT_NAME" == "" ]; then
    echo "Certificate not found."
    echo "Run the der2pem.sh first."
    exit
fi
TMP_DIR=/data/local/tmp
adb push "$DIR_SCRIPT/$CERT_NAME" $TMP_DIR


if [ "$(adb shell getprop ro.build.version.sdk | tr -d '\r')" -lt 34 ]; then
    RES=$(adb shell cp $TMP_DIR/$CERT_NAME /system/etc/security/cacerts 2>&1)
    echo $RES
    if [[ "$RES" == *"Read-only file system"* ]]; then
        echo "Read Only system directory. Add '-writable-system' when running emulator.";
        echo "Don't forget to 'adb root' and then 'adb remount'."
    fi
    echo "Certificate injected."
    exit 0
fi

CMD="CERTIFICATE_PATH=$TMP_DIR/$CERT_NAME sh $TMP_DIR/inject.sh"
adb push "$DIR_SCRIPT/inject.sh" $TMP_DIR

if [ "$(adb shell whoami)" == "root" ]; then
    adb shell "$CMD"
elif [ "$(adb shell which su)" == "/system/bin/su" ]; then
    adb shell "su -c $CMD" 
else
    adb shell "su root sh -c '$CMD'" 
fi

