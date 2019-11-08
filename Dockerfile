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

RUN pip3 install -U setuptools networkx pandas pomegranate pyfaidx pysam scikit-learn==0.20.0 hmmlearn && \
    pip3 install cnvkit==$cnvkit_version
RUN Rscript -e "install.packages('https://bioconductor.org/packages/release/bioc/src/contrib/DNAcopy_1.58.0.tar.gz')"
RUN Rscript -e "install.packages('https://www-stat.stanford.edu/~tibs/cghFLasso_files/cghFLasso_0.1-1.tar.gz')"



RUN rm -rf /tmp/pip* && \
    apt-get clean && \
    apt-get --yes remove python-pip wget

CMD cnvkit.py