#!/bin/bash
set -e

printenv >.env

fvm flutter build web --release -o /usr/share/nginx/html --dart-define-from-file=.env

# replace "build_nummer":"1" with milliseconds since epoch in /usr/share/nginx/html/version.json
sed -i "s/build_number\":\s*\"[0-9]*\"/build_number\": \"$(date +%s)\"/g" /usr/share/nginx/html/version.json

echo "🚀 Done! Application is running at http://localhost:80"

exec nginx -g 'daemon off;'
