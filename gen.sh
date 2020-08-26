#!/bin/sh

genpass() {
  </dev/urandom tr -dc _A-Z-a-z-0-9 | head -c ${1:-32}
}

_CWD="`dirname $0`"
_DB="`genpass`"
_NEXTCLOUD="`genpass`"
_COLLABORA="`genpass`"
sed -i.old -E -e "s/\[##RANDOM_PASSWORD##\]/${_DB}/" "${_CWD}/db.env"
sed -i.old -E -e "s/\[##mynextcloud.+##\]/${1}/g" -e "s/\[##A REACHABLE EMAIL ADRESS##\]/${2}/g" -e "s/\[##GENERATED PASSWORD##\]/${_NEXTCLOUD}/g" \
  -e "s/\[##A SECURE GENERATED PASSWORD##\]/${_COLLABORA}/g" -e "s/\[##myoffice.+##\]/${3}/g" -e "s/\[##GPASS##\]/${4}/g" "${_CWD}/docker-compose.yml"
# echo "${_DB}:${_NEXTCLOUD}:${_COLLABORA}"
