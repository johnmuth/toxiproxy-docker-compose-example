#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "Usage: $0 <target url>"
    exit 1
fi

while true
do
    curl -sL -w "%{time_total} %{http_code} %{url_effective}\\n" "$1" -o /dev/null
    sleep 1
done

