cat > /etc/postfix/main.cf <<EOF
myhostname=$HOSTNAME
relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
smtp_tls_security_level = encrypt
smtp_sasl_security_options = noanonymous
maillog_file = /dev/stdout
smtpd_relay_restrictions = permit_mynetworks, reject_unauth_destination
EOF

cat > /etc/postfix/sasl_passwd <<EOF
[smtp.gmail.com]:587 $EMAIL:$APPPASS
EOF

chown root:root /etc/postfix/sasl_passwd
chmod 600 /etc/postfix/sasl_passwd

postmap /etc/postfix/sasl_passwd

cat > /etc/postfix/aliases <<EOF
root: $EMAIL
EOF
newaliases

#echo -n "myhostname=mail.rhg135.com\nmydomain=rhg135.com" >> /etc/postfix/main.cf
exec /usr/sbin/postfix -c /etc/postfix start-fg
