#!/bin/bash
set -e

CERT_DIR="/var/lib/postgresql/certs"
mkdir -p $CERT_DIR

# Only generate if certs don't exist
if [ ! -f "$CERT_DIR/server.crt" ] || [ ! -f "$CERT_DIR/server.key" ]; then
    echo "Generating self-signed certificate..."
    chown postgres:postgres $CERT_DIR
    chmod 700 $CERT_DIR

    su postgres -c "openssl req -new -x509 -days 365 -nodes \
        -out $CERT_DIR/server.crt \
        -keyout $CERT_DIR/server.key \
        -subj '/CN=localhost'"
    chown postgres:postgres $CERT_DIR/server.*
    chmod 600 $CERT_DIR/server.key
    chmod 644 $CERT_DIR/server.crt
fi

# Execute the original Postgres entrypoint
exec docker-entrypoint.sh postgres -c ssl=on \
                                  -c ssl_cert_file=$CERT_DIR/server.crt \
                                  -c ssl_key_file=$CERT_DIR/server.key
