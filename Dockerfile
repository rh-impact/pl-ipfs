# Docker file for ipfs ChRIS plugin app
#
# Build with
#
#   docker build -t <name> .
#
# For example if building a local version, you could do:
#
#   docker build -t local/pl-ipfs .
#
# In the case of a proxy (located at 192.168.13.14:3128), do:
#
#    docker build --build-arg http_proxy=http://192.168.13.14:3128 --build-arg UID=$UID -t local/pl-ipfs .
#
# To run an interactive shell inside this container, do:
#
#   docker run -ti --entrypoint /bin/bash local/pl-ipfs
#
# To pass an env var HOST_IP to container, do:
#
#   docker run -ti -e HOST_IP=$(ip route | grep -v docker | awk '{if(NF==11) print $9}') --entrypoint /bin/bash local/pl-ipfs
#

FROM busybox:stable
LABEL maintainer="enp0s3 <ibezukh@redhat.com>"

ENV TARFILE ipfs.tar.gz
ENV IPFS_VER v0.17.0
ENV IPFS_URL https://github.com/ipfs/kubo/releases/download/v0.17.0/kubo_${IPFS_VER}_darwin-amd64.tar.gz

WORKDIR /tmp

RUN wget -O ${TARFILE} ${IPFS_URL} && \
    tar -xf ${TARFILE}

FROM python:3.9.1-slim-buster
LABEL maintainer="sgallagher <sgallagh@redhat.com>"

WORKDIR /usr/local/src

COPY --from=0 /tmp/kubo/ipfs /usr/local/bin
COPY requirements.txt .
RUN chmod +x /usr/local/bin/ipfs && \
    pip install -r requirements.txt

COPY . .
RUN pip install .

CMD ["ipfs", "--help"]
