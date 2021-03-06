#!/bin/bash

echo Configure TLS

# /etc/postfix/main.cf
postconf -e smtpd_tls_cert_file=$(find /etc/postfix/certs -iname *.crt)
postconf -e smtpd_tls_key_file=$(find /etc/postfix/certs -iname *.key)
postconf -e smtpd_tls_security_level=may
postconf -e smtp_tls_cert_file=$(find /etc/postfix/certs -iname *.crt)
postconf -e smtp_tls_key_file=$(find /etc/postfix/certs -iname *.key)
postconf -e smtp_tls_security_level=may
chmod 400 /etc/postfix/certs/*.*
# /etc/postfix/master.cf
postconf -M submission/inet="submission   inet   n   -   n   -   -   smtpd"
postconf -P "submission/inet/syslog_name=postfix/submission"
postconf -P "submission/inet/smtpd_tls_security_level=encrypt"
postconf -P "submission/inet/smtpd_sasl_auth_enable=yes"
postconf -P "submission/inet/milter_macro_daemon_name=ORIGINATING"
postconf -P "submission/inet/smtpd_recipient_restrictions=permit_sasl_authenticated,reject_unauth_destination"
