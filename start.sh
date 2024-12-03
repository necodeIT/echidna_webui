#!/bin/bash
set -e

printenv >.env

fvm flutter build web --release -o /usr/share/nginx/html --dart-define-from-file=.env

# replace "secondsSinceEpoch" with actual seconds since epoch in index.html

sed -i "s/secondsSinceEpoch/$(date +%s)/g" /usr/share/nginx/html/index.html

echo "🚀 Done! Application is running at http://localhost:80"

exec nginx -g 'daemon off;'
