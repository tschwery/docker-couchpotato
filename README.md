# docker-ttrss

This [Docker](https://www.docker.com) image allows you to run a
[CouchPotato](https://couchpota.to/) instance.

## Environment variables configuration
Each section of the `settings.conf` file can be overridden using environment
variables in the following form : 

```
COUCH_SECTION="var1 = value\nvar2 = value\nvar3 = value"
```

For example: 
```
COUCH_CORE="username = user\n"
COUCH_NZBGET="host = nzbget:6789\npassword = test\n"
```

## Volumes
You should mount the folders that will recieve the downloaded files from
your downloaders as well as your collection filesystem.
