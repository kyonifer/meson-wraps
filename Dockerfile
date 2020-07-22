FROM ubuntu:18.04

ARG USER_ID

RUN apt-get update && apt-get install git -y

RUN adduser --disabled-password --gecos '' --uid ${USER_ID} user

USER user

CMD  /bin/bash
WORKDIR /work
