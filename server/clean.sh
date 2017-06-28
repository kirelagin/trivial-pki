#!/bin/bash -e

. ./config

rm -f "$serial" "$serial.old" "$database" "$database.old" "$database.attr"
rm -f "$ca_key" "$ca_crt"
rmdir "$ca_home" || true

rm -f "$server_key" "$server_csr" "$server_crt"
rm -f "$certs_dir"/*.pem
rmdir "$certs_dir" || true
