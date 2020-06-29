FROM ubuntu:18.04 AS builder
WORKDIR /project
RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive \
    apt-get install -q -y --no-install-recommends cmake git vim gcc g++ gfortran software-properties-common likwid && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Installing latest GCC compiler (version 10)
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update -q && \
    apt-get install -q -y gcc-10 g++-10 gfortran-10 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# We are installing both OpenMPI and MPICH. We could use the update alternatives to switch between them
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 90\
                        --slave /usr/bin/g++ g++ /usr/bin/g++-10\
                        --slave /usr/bin/gfortran gfortran /usr/bin/gfortran-10\
                        --slave /usr/bin/gcov gcov /usr/bin/gcov-10

SHELL ["/bin/bash", "-c"]

RUN groupadd chapter4 && useradd -m -s /bin/bash -g chapter4 chapter4

WORKDIR /home/chapter4
RUN chown -R chapter4:chapter4 /home/chapter4
USER chapter4

RUN git clone https://github.com/essentialsofparallelcomputing/Chapter4.git

WORKDIR /home/chapter4/Chapter4
#RUN make CC=gcc

ENTRYPOINT ["bash"]
