FROM ubuntu:latest
MAINTAINER sridhar <sridhar@wustl.edu>

LABEL \
    description="Image for tools used in RnaSeq"

RUN apt-get update -y && apt-get install -y \
    build-essential \
    bzip2 \
    cmake \
    default-jdk \
    git \
    libnss-sss \
    libtbb2 \
    libtbb-dev \
    ncurses-dev \
    nodejs \
    python-dev \
    python-pip \
    tzdata \
    unzip \
    wget \
    zlib1g \
    zlib1g-dev

# Star aligner 
ENV star_version 2.7.0f
WORKDIR /docker_main
ADD https://github.com/alexdobin/STAR/archive/${star_version}.tar.gz /usr/bin/
RUN tar -xzf /usr/bin/${star_version}.tar.gz -C /usr/bin/
RUN cp /usr/bin/STAR-${star_version}/bin/Linux_x86_64/* /usr/local/bin


# Clean up
RUN cd /docker_main / && \
   rm -rf 2.7.0f.tar.gz && \
   apt-get autoremove -y && \
   apt-get autoclean -y  && \
   apt-get clean



# needed for MGI data mounts
RUN apt-get update && apt-get install -y libnss-sss && apt-get clean all

##lsf time stamp bug
## borrow from cmiller
RUN ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime && \
    echo "America/Chicago" > /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Set default working path
WORKDIR /docker_main
