This is a very simple PKI aimed mainly at issuing certificates for your home OpenVPN server. But you can, of course, adapt it for whatever other uses you have in mind.

OpenVPN has `easy-rsa` which is not actually as easy as it could be. This project is just like `easy-rsa` only much easier and without RSA (because elliptic curves are the future).

User Manual
============

Setting up CA and server
-------------------------

* Execute `init.sh` form the `server` directory.

This sets up your very own Certificate Authority and issues its first certificate – for the VPN server.

* Point your server config to `ca/ca.crt`, `server.key` and `server.crt`.

Issuing client certificates
----------------------------

* Send `setup.sh` from the `client` directory to the user.
* Tell them to run `./setup.sh`.
* Ask them to send you the certificate request that they’ve got on their screen.
* ??? TBD
* PROFIT
