#!/bin/bash

cn=${1:-$(hostname -s)}

key="$cn.key"
crt="$cn.crt"

if [ -f "$crt" ]; then
  if [ ! -f "$key" ]; then
    echo "Error: there is a certificate in '$crt', but no key in '$key'. Remove '$crt' and start again."
    exit 1
  fi

  echo "HAVE CRT"
else
  if [ ! -f "$key" ]; then
    echo "Generating private key and writing in to '$key'."
    openssl ecparam -name prime256v1 -noout -genkey -out "$key"
    echo ""
  fi

  openssl req -new -key "$key" -config <(echo "
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
