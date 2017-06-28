#!/bin/bash -e

. ./config

read request

if [[ "$request" != "-----BEGIN CERTIFICATE REQUEST-----" ]]; then
  echo "Error: certificate request must begin with '-----BEGIN CERTIFICATE REQUEST-----'."
  exit 1
fi

while read line; do
  request="$request"$'\n'"$line"
  if [[ "$line" == "-----END CERTIFICATE REQUEST-----" ]]; then
    break
  fi
done

cn=$(openssl req -noout -subject -in <(echo "$request") -nameopt sname,sep_multiline | sed -n 's/^[[:space:]]*CN=//p')
sn=$(cat "$serial")

openssl ca -notext -in <(echo "$request") -out "$cn.crt" -config "openssl.cnf" -extensions "cert_extensions"
