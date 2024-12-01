#!/bin/bash
set -e

echo "Compiling application..."

fvm flutter build web --release -o /usr/share/nginx/html

echo "🚀 Done! Application is running at http://localhost:80"

exec nginx -g 'daemon off;'
