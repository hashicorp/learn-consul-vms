#!/usr/bin/env bash

set -o errexit

VERSION=11

export DEBIAN_FRONTEND=noninteractive

PG_REPO_APT_SOURCE=/etc/apt/sources.list.d/pgdg.list
if [ ! -f "$PG_REPO_APT_SOURCE" ]
then
  # Add PG apt repo:
  echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > "$PG_REPO_APT_SOURCE"

  # Add PGDG repo key:
  wget --quiet -O - https://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add -
fi

apt-get update
apt-get -y upgrade

apt-get install -y \
	"postgresql-${VERSION}" \
	"postgresql-contrib-${VERSION}"

PG_CONF="/etc/postgresql/${VERSION}/main/postgresql.conf"
PG_HBA="/etc/postgresql/${VERSION}/main/pg_hba.conf"
PG_DIR="/var/lib/postgresql/${VERSION}/main"

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" "$PG_CONF"
echo "host    all             all             all                     md5" >> "$PG_HBA"
echo "client_encoding = utf8" >> "$PG_CONF"

systemctl restart postgresql

sudo -u postgres psql -c "CREATE DATABASE products owner postgres;"
sudo -u postgres psql -d products -f /mnt/my-machine/products.sql