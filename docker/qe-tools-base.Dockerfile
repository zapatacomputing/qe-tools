# Dockerfile for the default OpenPack docker image
FROM ubuntu:18.04
WORKDIR /app
USER root
RUN apt-get clean && apt-get update --fix-missing
# Install python, pip, and other utilities
RUN apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get install -y python3.7 && \
    apt-get install -y python3-pip && \
    apt-get install -y python3.7-dev 

# Install necessary CLI tools
RUN apt-get install -y curl && \
    apt-get install -y git && \
    apt-get install -y openssh-client

# Set the default version of Python3 to Python 3.7 since OpenPack uses Python 3.7 features
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2 && \
    update-alternatives --set python3 /usr/bin/python3.7

ENV PYTHONPATH="/usr/local/lib/python3.7/dist-packages:${PYTHONPATH}"

# Make sure we have the latest version of pip
RUN pip3 install --upgrade pip

# Make sure to upgraade setuptools else OpenPack won't be installed because it uses find_namespace_packages
RUN pip3 install --upgrade setuptools

ENTRYPOINT bash

