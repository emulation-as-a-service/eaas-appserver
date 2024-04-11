#!/bin/sh

__gpg_import() {
    runuser -u bwfla -- gpg --import
}

# import public key for error-reporting
keyfile='/home/bwfla/.bwFLA/eaas-error-reporter.key.pub'
if [ -f "${keyfile}" ] ; then
    echo "Importing custom error-reporting key: ${keyfile}"
    __gpg_import < "${keyfile}"
else
    echo "Importing default error-reporting key..."
    __gpg_import <<-EOT
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBF2csVkBCADigVlFGWgIlw3S1TwjEaAHcJnr6kdCKI3+Np/FHZ/WA1+YbbFn
ooxpv09xkyZsV1buNtc9B1NVd2du7WIvx7c+tajMepSCDEBJxK/Vt3SS0/NIuLvO
G8j7MI5a6jN3xoDIO9DWLUAhiW1fB7vMNFsHyouufTQVk6/XhJVSoaq/glwsGg/L
Ga21JAK3rya5oBQ327n7LQ+ivuw6RIaEBDgMhVyKGAn5jDP3ZqQmUotsDctwIZw7
XPuRKP9n0NPb3MG+0eyOgc8tu4hL6cvnb2ejiqVFPQkswWFPC9/HdXFZMKtqW77d
h/hu3VEcMbdyAfwGwFu5FUNH7Jn9Qty7wZSLABEBAAG0KGVhYXMtZXJyb3ItcmVw
b3J0ZXIgPGVycm9yc0BvcGVuc2x4LmNvbT6JAU4EEwEIADgCGwMFCwkIBwIGFQoJ
CAsCBBYCAwECHgECF4AWIQQvkFAeARrfHPU6wa0fu4EZkaCeQgUCZH/JFwAKCRAf
u4EZkaCeQtpBCADRgjqwHGR6p/rucVElZri3PMHb2jd5J3h2bb3Zz1X/bxi4PfGM
5n6dW/iDtXQsTurhonWemR6zcJqiNJOdBmqsIjWzxG02+AXF1LI/w3yxeK+y1HmP
hv9BnhuHb9DW+hBvAt7LCMMhb2wHGVB83cyASqTgXyU/2PjaW93g56b3aKBM35cc
Blj3ShmwuSrINNuhW9fcUJuTIYqT4PEyvcMvBwj5rirFxn8Wvl/jP91j43Xm0byz
KActZrUenNDBiIs9aOm9W+gFHCGss0HoMZeLdObwjSZTrueyhlljhKEmrVQ9excg
uZrsLrwdTDbCeZX8/uCrQdtb4C3pEWhuADeHuQENBF2csVkBCADTENbMJZgrAg9b
NPiG4GSZs6R0gpeikaxzNrd4O31DYvWUZLR7aBGm2JKwF2AD8zGBoLgr+fPzVkJC
Aaf267E4Z5KpNmTmL7d2p0KiAEpGuEE4Ty3QTHJ+uGnkUIKiY213JpgXPOPkjfyD
saSXnZQXzdBCxADzrhtAiKyj6Cmt5rGF/CVtR5Cdx/+2tDIOvIhzmNUdoZwMiRcM
zI6ufnta5SpIdvXdNJdEe2jHdB7ul+MQ0UzvQCWapf+0JkBqfSAAF3nJp4GvKUVL
7E9kpducOr2vZ+TMjTd/39qajlTC22l6RND8SDVVQmlziMOrudlet4/8cMtkW832
ROZgo5kRABEBAAGJATYEGAEIACACGwwWIQQvkFAeARrfHPU6wa0fu4EZkaCeQgUC
Zha39wAKCRAfu4EZkaCeQmgXB/9VmJDf+07vvfdS10pOjYifC8EFeNZyjUI1DoS+
89wL00PZZQE0ccBJVXYupxK2J3dBKgZCjZLWhLddJKudUmPzntZbjcwOR4K85eM2
uoWfb987Tn/pMh69EckXm2NEYCS3lQ36H/bEIHE5w+HG40fG0Ypahh432oX/M1J0
ewzzDesUMYML5rOG8SFP0H5Tqd1M+bEFTPjg1smSsi9hbj4KF2UHph3Zrs6ikgqC
QnAXrdfU+tQi3raKiATwDuqP5IgUmYC4f1sAJgyLA+fZ5KEXXY85IJzZcIq4KWBg
abFix/L+pDqDYxrlohmb2XP9ZeIXu5ysI/4fYK1vzIG0K//O
=bIIW
-----END PGP PUBLIC KEY BLOCK-----
EOT
fi
