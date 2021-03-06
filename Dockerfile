FROM ubuntu:16.04
ARG username=jwpyo
ENV username=${username}

LABEL version="1.0"
LABEL maintainer="wjddn1801@snu.ac.kr"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --yes software-properties-common
RUN add-apt-repository ppa:ethereum/ethereum
RUN apt-get update && apt-get install --yes geth && apt-get install --yes vim jq

RUN adduser --disabled-login --gecos "" jwpyo

USER $username
WORKDIR /home/${username}
COPY eth_config/ /home/${username}/eth_config/
COPY * /home/${username}/

ENTRYPOINT bash
