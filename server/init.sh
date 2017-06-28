#!/bin/bash -e

. ./config

mkdir -p "$ca_home"
[ -s "$serial" ] || echo "01" > "$serial"
touch "$database"
mkdir -p "$certs_dir"

if [ ! -s "$ca_key" ]; then
  echo "Generating CA private key and writing it to '$ca_key'."
  openssl ecparam -name prime256v1 -noout -genkey -out "$ca_key"
  chmod 400 "$ca_key"
  echo ""
fi

if [ ! -s "$ca_crt" ]; then
  echo "Generating CA certificate and writing it to '$ca_crt'."
  openssl req -new -x509 -key "$ca_key" -out "$ca_crt" -extensions "ca_extensions" -config "openssl.cnf" -subj "/CN=$ca_commonName"
  chmod 644 "$ca_crt"
  echo ""
fi

if [ ! -s "$server_key" ]; then
  echo "Generating server private key and writing it to '$server_key'."
  openssl ecparam -name prime256v1 -noout -genkey -out "$server_key"
  chmod 400 "$server_key"
  echo ""
fi

if [ ! -s "$server_crt" ]; then
  echo "Generating server certificate and writing it to '$server_crt'."
  req=$(openssl req -new -key "$server_key" -config "openssl.cnf" -subj "/CN=$server_commonName")
  openssl ca -batch -notext -in <(echo "$req") -out "$server_crt" -extensions "server_extensions" -config "openssl.cnf"
  chmod 644 "$server_crt"
  echo ""
fi
