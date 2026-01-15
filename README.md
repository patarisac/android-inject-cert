# android inject cert
These scripts work on rooted Android emulators/devices, including AVD with or without Magisk. For Magisk-based setups, there are usually better and cleaner alternatives using Magisk modules (like [AlwaysTrustUserCerts](https://github.com/NVISOsecurity/AlwaysTrustUserCerts)). This repository mainly targets rooted & Magisk-less emulators, such as AVD with Google APIs image.

## Steps

### 1. Convert Burp Suite's Certificate (DER) to PEM

```bash
./der2pem.sh /path/to/burp_ca.der
```
### 2. Inject the certificate to Android System

```bash
./android_inject_cert.sh
```

## References
- **HTTP Toolkit** : https://httptoolkit.com/blog/android-14-install-system-ca-certificate/
