#!/bin/sh


for var in $(env | grep '^COUCH_' | awk -F'=' '{print $1;}'); do
    section="${var#*COUCH_}"
    section=$(echo $section | tr [A-Z] [a-z])
    
    eval value=\$$var
    
    printf "[%s] %s\n" "$section" "$value"
    printf "$value" | crudini --merge /home/couchpotato/.couchpotato/settings.conf \
        "$section"
done

exec "$@"
