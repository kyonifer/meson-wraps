FROM ubuntu:18.04

ARG USER_ID
ARG GROUP_ID

RUN apt-get update && apt-get install git -y

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} user

USER user

CMD  /bin/bash
WORKDIR /work
