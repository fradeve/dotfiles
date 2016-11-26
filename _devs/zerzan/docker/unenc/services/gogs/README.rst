Gogs ARM
========

First run

.. code-block:: bash

    docker pull ivanmarban/armhf-gogs

    docker run -d --name gogs-git-service \
    -p 8022:22 \
    -p 3000:3000 \
    -v /unenc/services/gogs/data/:/data \
    ivanmarban/armhf-gogs

Port 22 inside the container is exposed as 8022 (git/ssh)
Port 3000 inside the container is exposed as 3000 (web interface)
