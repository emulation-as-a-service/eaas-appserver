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
b3J0ZXIgPGVycm9yc0BvcGVuc2x4LmNvbT6JAVQEEwEIAD4CGwMFCwkIBwIGFQoJ
CAsCBBYCAwECHgECF4AWIQQvkFAeARrfHPU6wa0fu4EZkaCeQgUCX6XUrAUJBcuK
UwAKCRAfu4EZkaCeQusQCADU5CQXo148tcadpfKNN+/iDRgL7vtHSbOA8dd7cdf9
4pu2Zuoyd95oWDoIUAbHU3dY5X0dlzfHMuxhmUPRQC9WXzDif2kRN4leftOPmTV/
XM+i45uM7cfsiB4VZaxuZQDOWEqG1dDmnnNEVLZ8ed/cHhCoHFT2PBBeMQpKgvh8
u6cjc1E+3baf/WcMQdfTaQ//fUenGAa0+PJncujQps7PxfrD21mAxLtwcMcLmASi
3UuWeTvAtMHVl5jgkWa/lhf9zA8AFLz083FTNfV/6hbdtiE0yd/0xisrm6aRIpuK
Bfo6SZQJPCeiaRX2wWlENbyMVSYsTTr9dZGhDnJWyTdwuQENBF2csVkBCADTENbM
JZgrAg9bNPiG4GSZs6R0gpeikaxzNrd4O31DYvWUZLR7aBGm2JKwF2AD8zGBoLgr
+fPzVkJCAaf267E4Z5KpNmTmL7d2p0KiAEpGuEE4Ty3QTHJ+uGnkUIKiY213JpgX
POPkjfyDsaSXnZQXzdBCxADzrhtAiKyj6Cmt5rGF/CVtR5Cdx/+2tDIOvIhzmNUd
oZwMiRcMzI6ufnta5SpIdvXdNJdEe2jHdB7ul+MQ0UzvQCWapf+0JkBqfSAAF3nJ
p4GvKUVL7E9kpducOr2vZ+TMjTd/39qajlTC22l6RND8SDVVQmlziMOrudlet4/8
cMtkW832ROZgo5kRABEBAAGJATwEGAEIACYCGwwWIQQvkFAeARrfHPU6wa0fu4EZ
kaCeQgUCX6XVJgUJB6y+TQAKCRAfu4EZkaCeQlDMB/49/ovonyW10VzMePEH+D7N
81LzCoaaY/r2Vxs/TS42h6DHdmjN5Yc5Eh2MeNNt9xbZ1MqXWQOhF0+bnUFeCRCi
GNSEeVxXC2Jmxltk0Xhjw04Wyl6pcRyloQvmEgXif3S1dWJddWHmu2Y/Q18xfhck
PeFuwKYSsmE5ZQPhc5wVtgUpjyF9ye3xtPAOevuYPYRJN2NRJWmcXaIHjJ1tFqcE
BGj8gvX142JWx4XhtgZPhzHwImzsR3XVR0XW461md+fjfDebyajG8+G0S8YMRlWb
iQhpkbgtubJkr9X9V1CKYOnMZHXEsti/7znpOp/QlC9+0JgOv/z5LdW+qqglhcn8
=5i7i
-----END PGP PUBLIC KEY BLOCK-----
EOT
fi
