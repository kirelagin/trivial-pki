#!/bin/bash

cn=${1:-$(hostname -s)}

if [ -f "$cn.crt" ]; then
  if [ ! -f "$cn.key" ]; then
    echo "Error: there is a certificate in '$cn.crt', but no key in '$cn.key'. Remove '$cn.crt' and start again."
    exit 1
  fi

  echo "HAVE CRT"
else
  if [ ! -f "$cn.key" ]; then
    echo "Generating private key and writing in to '$cn.key'."
    openssl ecparam -name prime256v1 -noout -genkey -out "$cn.key"
    echo ""
  fi

  openssl req -new -key "$cn.key" -config <(echo "
    HOME = .

    [ req ]
    default_md            = sha256
    string_mask           = utf8only
    utf8                  = yes
    distinguished_name    = req_distinguished_name
    prompt                = no

    [ req_distinguished_name ]
    commonName            = $cn
  ")
fi
