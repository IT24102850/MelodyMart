#!/bin/sh
# Hosting platforms (Render, Railway, Fly, Heroku-style) pass the port to listen on in $PORT.
set -e
PORT="${PORT:-8080}"
sed -i "s/port=\"[0-9]*\" protocol=\"HTTP\/1.1\"/port=\"${PORT}\" protocol=\"HTTP\/1.1\"/" /usr/local/tomcat/conf/server.xml
exec catalina.sh run
