Docker Btsync
=============

This is an optimized Btsync dockerfile, which is able to run on an OdroidXU4,
which has an armv7h architecture.

The instructions contained in the Dockerfile will build the Btsync image on
top of Ubuntu armv7h and apply all the necessary fixes to make everything 
run smoothly.

Before building the container, the Dockerfiles expects a `btsync.conf` file
to be in the same folder. There isn't any special configuration needed for 
the configuration file, I just changed the following parameters:

* `device_name`
* `login`
* `password`

and set all the other parameters as per the table below.

+----------------------+--------------------------------------+--------------------------------+
| Description          | Host                                 | Docker                         |
+======================+======================================+================================+
| Btsync data folder   | `/unenc/fradeve/sync`                | `/home/fradeve/.btsync`        |
+----------------------+--------------------------------------+--------------------------------+
| Btsync config folder | `/unenc/services/btsync/.btsync`     | `/home/fradeve/.config/btsync` |
+----------------------+--------------------------------------+--------------------------------+
| Btsync PID file      |                                      | `/home/fradeve/.btsync.pid`    |
+----------------------+--------------------------------------+--------------------------------+
| Btsync config file   | `/unenc/services/btsync/btsync.conf` | `/home/fradeve/btsync.conf`    |
+----------------------+--------------------------------------+--------------------------------+

The default user for the container (which will also be owning all the synced
files inside and outside the container) is set to `fradeve`, but can be 
easily changed to anything else (remember to change it in both the 
Dockerfile and the entrypoint script).

Build image:

    docker build -t btsync .

Run container in interactive mode:

    docker run -ti --privileged=true -e DEV_UID=$UID -e DEV_GID=$GID5 \
        -v /unenc/fradeve/sync:/home/fradeve/.btsync \
        -v /unenc/services/btsync/.btsync:/home/fradeve/.config/btsync \
        -p 8888:8888 -p 55555:55555 btsync

Launch btsync from inside the container:

    btsync --config /home/fradeve/btsync.conf --nodaemon &

Detatch from the container without killing it:

    Ctrl + P + Ctrl + Q

