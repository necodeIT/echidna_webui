#!/bin/bash
set -e

printenv >.env

echo "Compiling application..."

fvm flutter build web --release -o /usr/share/nginx/html --dart-define-from-file=.env

echo "🚀 Done! Application is running at http://localhost:80"

exec nginx -g 'daemon off;'
