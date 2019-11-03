#!/bin/sh

__gpg_import() {
    sudo -u bwfla gpg --import
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
b3J0ZXIgPGVycm9yc0BvcGVuc2x4LmNvbT6JAVQEEwEIAD4WIQQvkFAeARrfHPU6
wa0fu4EZkaCeQgUCXZyxWQIbAwUJAeEzgAULCQgHAgYVCgkICwIEFgIDAQIeAQIX
gAAKCRAfu4EZkaCeQvNYCADHZfz5MMEBGwML6Ey7wJdPfLp5z0q/C3ePbmmoznJG
B6b3hTmUVYWVgF9g/aeukyUqolfAc9ps7D/nyAftK0wGrt15NVINihfCE5/43ZnO
z6jCihpJKV99hqkwIli+NWRLXsKTJ7oog9IOykjLBPIiVUK6ebE/lmMXaRzuGDFq
1l5gGNF5yv998wGDaTE3eaXupKrmF9bBgkB7+rcw0H+1H44vTGBnpOPrJf5I/53a
0K4eIX/xRzuSvAom16rR5ys4nsSOlTTZHyaADU37juIR5AeaKi0TTDXnBCEd76yN
iO3ZdaYcYQFU0FvqdE8i65NPuxbarM3cPliwIwqlaIJHuQENBF2csVkBCADTENbM
JZgrAg9bNPiG4GSZs6R0gpeikaxzNrd4O31DYvWUZLR7aBGm2JKwF2AD8zGBoLgr
+fPzVkJCAaf267E4Z5KpNmTmL7d2p0KiAEpGuEE4Ty3QTHJ+uGnkUIKiY213JpgX
POPkjfyDsaSXnZQXzdBCxADzrhtAiKyj6Cmt5rGF/CVtR5Cdx/+2tDIOvIhzmNUd
oZwMiRcMzI6ufnta5SpIdvXdNJdEe2jHdB7ul+MQ0UzvQCWapf+0JkBqfSAAF3nJ
p4GvKUVL7E9kpducOr2vZ+TMjTd/39qajlTC22l6RND8SDVVQmlziMOrudlet4/8
cMtkW832ROZgo5kRABEBAAGJATwEGAEIACYWIQQvkFAeARrfHPU6wa0fu4EZkaCe
QgUCXZyxWQIbDAUJAeEzgAAKCRAfu4EZkaCeQt13B/4mAhJMZQOqK91C3f9JHrF2
cJOWilKiBueuen8Qfc80XAmmR5+3dF5nG/E6z2dsTsQ3v9B+9Wp1d5wudX6LUYoJ
RJ65Psxt0rsQglQtYzgIzxpLIlipOVYRYOmFNy7ibqeRWX5nkxNGW2WjFBJ+CYPz
9gTZ4p9RSaHadT9e5gTQ8CZzKd2dCHdoKmmCFP2IV3Ye2gGY4LJ63/DS8dFx6zx4
CM/69Jz7rPdI65q/yjjFe0m2ub1ILC7SVwI6Ca4k9g7XCKq6cVvOORNo1Jyv33PH
5hV4cQnrqC19Bc3P/V99dokLvEssSDkhoy7Gx8aiWaZG17vhaHaY5n9cH+z+Az1L
=1Cs+
-----END PGP PUBLIC KEY BLOCK-----
EOT
fi
