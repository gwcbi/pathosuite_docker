# Start from the RStudio Docker image
FROM rocker/rstudio

# File Author / Maintainer
MAINTAINER bendall@gwu.edu

# Install apt-utils first
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install some other dependencies
RUN apt-get update && \
    apt-get install -y \
    libxml2 \
    libxml2-dev \
    libssh2-1 \
    libssh2-1-dev \
    vim \
    bash-completion \
    libxml2-dev \
    pandoc


##########################################################################################
# The following is borrowed from the Bioconductor Dockerfile:
##########################################################################################

# temporarily block dist-upgrade:
#   RUN apt-get dist-upgrade -y && \

RUN DEBIAN_FRONTEND=noninteractive apt-get update


# nuke cache dirs before installing pkgs; tip from Dirk E fixes broken img
RUN  rm -f /var/lib/dpkg/available && rm -rf  /var/cache/apt/*


RUN apt-get install -y -t unstable --force-yes libfreetype6




RUN apt-get update && \
    apt-get install -y -t unstable --fix-missing \
    curl \
    libcairo2-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgsl-dev \
    libgtk2.0-dev \
    libncurses5-dev \
    openjdk-8-jdk \
    tk-dev \
    xvfb

##########################################################################################

##########################################################################################
# The following is borrowed from the Miniconda docker file
# https://github.com/ContinuumIO/docker-images/blob/master/miniconda/Dockerfile
##########################################################################################
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.1.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean

ENV PATH /opt/conda/bin:$PATH

##########################################################################################

##########################################################################################
# Set up user environments
##########################################################################################
ADD root-bashrc.sh /root/.bashrc
ADD bash_profile.sh /root/.bash_profile

# Give rstudio sudo privs
RUN usermod -a -G sudo rstudio \
    && usermod -s /bin/bash rstudio

ADD rstudio-bashrc.sh /home/rstudio/.bashrc
ADD bash_profile.sh /home/rstudio/.bash_profile

RUN chown rstudio /home/rstudio/.bashrc && chown rstudio /home/rstudio/.bash_profile

##########################################################################################
# Install bioconda packages
##########################################################################################
RUN conda config --add channels bioconda \
    && conda config --add channels r \
    && conda config --add channels conda-forge \
    && conda install -y \
        biopython \
        samtools \
        bowtie2 \
        prinseq \
        cutadapt \
        fastqc \
        sra-tools

# Install pathoscope
RUN wget https://github.com/PathoScope/PathoScope/archive/v2.0.6.tar.gz \
    && tar xzf v2.0.6.tar.gz \
    && pip install ./PathoScope-2.0.6 \
    && rm -rf ./PathoScope-2.0.6

##########################################################################################
# Install R packages
##########################################################################################
ADD startx.sh /tmp/
ADD http://master.bioconductor.org/todays-date /tmp/
ADD install_rpkg.R /tmp/

RUN cd /tmp && \
    ./startx.sh && \
    export DISPLAY=:1.0 && \
    R -f /tmp/install_rpkg.R

EXPOSE 8787

CMD ["/init"]

