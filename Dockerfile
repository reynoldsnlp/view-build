FROM maven:3-jdk-8

RUN mkdir -p /dependencies

COPY ./dependencies/Makefile /dependencies/Makefile

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y ant make \
 && cd /dependencies \
 && make \
 && apt-get remove -y --purge ant make \
 && rm -rf /var/lib/apt/lists/*
