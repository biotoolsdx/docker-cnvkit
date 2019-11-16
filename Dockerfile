FROM ubuntu:16.04
MAINTAINER CHEN, Yuelong <yuelong.chen.btr@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ARG cnvkit_version=0.9.6


RUN apt-get update && \
    apt-get install -y r-base-core \
                       liblzma-dev \
                       python3-biopython \
                       python3-dev \
                       python3-matplotlib \
                       python3-numpy \
                       python3-pip \
                       python3-reportlab \
                       python3-scipy \
                       python3-tk \
                       zlib1g-dev \
                       wget


RUN pip3 install --upgrade scipy numpy \
  && pip3 install pandas pomegranate pyfaidx pysam scikit-learn hmmlearn==0.2.1 \
  && pip3 install cnvkit==$cnvkit_version
COPY . /tmp/
RUN Rscript -e "install.packages('/tmp/DNAcopy_1.60.0.tar.gz')"
RUN Rscript -e "install.packages('/tmp/cghFLasso_0.1-1.tar.gz')"



RUN rm -rf /tmp/.* /tmp/* && \
    apt-get clean && \
    apt-get --yes remove python-pip wget
RUN useradd -r -u 1003 test
CMD cnvkit.py