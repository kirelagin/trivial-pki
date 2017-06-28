#!/bin/bash -e

. ./config

rm -f "$serial" "$serial.old" "$database" "$database.old" "$database.attr" "$database.attr.old"
rm -f "$ca_key" "$ca_crt"
rmdir "$ca_home" || true

rm -f "$server_key" "$server_crt"
rm -f "$certs_dir"/*.pem
rmdir "$certs_dir" || true
