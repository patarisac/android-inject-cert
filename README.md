# android inject cert

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
