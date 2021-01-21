# Dockerfile for the default OpenPack docker image
FROM ubuntu:18.04
WORKDIR /app
USER root

# Install python, pip, CLI tools and other utilities
RUN apt-get update -y --fix-missing && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get install -y \
        python3.7 \
        python3-pip \
        python3.7-dev && \
    apt-get install -y \
        curl \
        git \
        openssh-client && \
    apt-get clean

# Set the default version of Python3 to Python 3.7 since OpenPack uses Python 3.7 features
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2 && \
    update-alternatives --set python3 /usr/bin/python3.7

ENV PYTHONPATH="/usr/local/lib/python3.7/dist-packages:${PYTHONPATH}"

# Make sure we have the latest version of pip
# Make sure to upgrade setuptools else OpenPack won't be installed because it uses find_namespace_packages
RUN pip3 install --upgrade pip setuptools && \
    pip3 install numpy pandas

ENTRYPOINT bash

