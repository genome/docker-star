FROM ubuntu:16.04

# add metadata to image
MAINTAINER="Zachary Skidmore"
LABEL description="RNA aligner for Spliced Transcripts Alignment to a Reference (STAR)\

                   USAGE: STAR"
LABEL original_source="https://github.com/alexdobin/STAR"
LABEL original_license="gpl-3"
LABEL original_install_instructions="https://github.com/alexdobin/STAR"

# set the environment variables
ENV star_version 2.5.2b

# update and install necessary tools
RUN apt-get update
RUN apt-get install -y build-essential
RUN apt-get install -y --no-install-recommends libnss-sss


# install star aligner
ADD https://github.com/alexdobin/STAR/archive/${star_version}.tar.gz /usr/bin/
RUN tar -xzf /usr/bin/${star_version}.tar.gz -C /usr/bin/
RUN cp /usr/bin/STAR-${star_version}/bin/Linux_x86_64/* /usr/local/bin

CMD ["STAR"]
