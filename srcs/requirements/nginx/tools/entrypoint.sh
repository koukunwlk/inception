#!/bin/bash
CERT_DIR="/etc/nginx/ssl"
PRIVATE_KEY="$CERT_DIR/mamaro-d.key"
CSR_FILE="$CERT_DIR/csr.pem"
CERT_FILE="$CERT_DIR/mamaro-d.crt"

mkdir -p "$CERT_DIR"


openssl genpkey -algorithm RSA -out "$PRIVATE_KEY" -pkeyopt rsa_keygen_bits:2048

openssl req -new -key "$PRIVATE_KEY" -out "$CSR_FILE" -subj "/CN=$DOMAIN"

openssl x509 -req -days 365 -in "$CSR_FILE" -signkey "$PRIVATE_KEY" -out "$CERT_FILE"

chmod 600 "$PRIVATE_KEY" "$CERT_FILE" "$CSR_FILE"


nginx -g "daemon off;"