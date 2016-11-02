# Pathosuite-docker

## Overview

This repository contains Dockerfiles for images containing 
[PathoScope](https://github.com/PathoScope/PathoScope) and
related applications for metagenomic and microbiome analysis.

Images are publicly available from Docker Hub.

## Images

These images are based on the [rocker/rstudio](https://hub.docker.com/r/rocker/rstudio/) 
image, see [using the RStudio image](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image) 
for more information.

### pathosuite-all

**URL**: https://hub.docker.com/r/mlbendall/pathosuite/

+ [PathoScope](https://github.com/PathoScope/PathoScope)
+ [RStudio](https://www.rstudio.com/) + [bioconductor](http://bioconductor.org/)
    + [PathoStat](https://github.com/mani2012/PathoStat)
    + [BatchQC](https://github.com/mani2012/BatchQC)
+ [conda](http://conda.pydata.org/docs/) + [bioconda](https://bioconda.github.io/)
    + [biopython](https://github.com/biopython/biopython.github.io/)
    + [samtools](http://www.htslib.org/) 
    + [bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
    + [prinseq](http://prinseq.sourceforge.net/manual.html)
    + [cutadapt](http://cutadapt.readthedocs.io/en/stable/guide.html)
    + [fastqc](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
    + [sra-tools](https://github.com/ncbi/sra-tools)

## Getting Started

This image provides packages for running the PathoScope pipeline and the downstream analysis tools BatchQC and PathoStat. The PathoScope tools (LIB, MAP, ID, REP, QC) are run via command line, while the downstream tools are [Shiny](http://shiny.rstudio.com/) apps run by [RStudio](https://www.rstudio.com/) in the browser.

### PathoScope tools 

PathoScope tools are accessed via command line. First, launch the docker image in the background:

```
docker run -d -p 8787:8787 mlbendall/pathosuite
```

Now attach to the running container as `rstudio` user (The ID of the latest container can be found with `docker ps -ql`):

```
docker exec --user rstudio -it $(docker ps -ql) bash
```

PathoScope tools are run using the `pathoscope` command. For example:

```
pathoscope --help
pathoscope MAP --help
```

### BatchQC and PathoStats

BatchQC and PathoStat are launched through RStudio. Start RStudio by launching the docker image in the background (if you have not done above):

```
docker run -d -p 8787:8787 mlbendall/pathosuite
```

Now simply open a new window in your browser and go to [http://localhost:8787/](http://localhost:8787/).
Default username and password is `rstudio`.

> Note: if `localhost` does not point to running server, find the IP address of the image:

> ```
docker inspect --format '{{ .NetworkSettings.Ports }}' $(docker ps -ql)
```

### Other tips

See the following for more information on working with the image:

+ [Using the RStudio Image](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image)
+ [Bioconductor Docker](https://github.com/Bioconductor/bioc_docker/blob/master/README.md)

#### List local docker images

```
docker images
```

#### List running containers

```
docker ps
```

#### List all containers, including stopped

```
docker ps -a
```

#### Stop a running container

```
docker stop <container_id>
```

#### Restart stopped container

(Find the container ID with `docker ps -a`).

```
docker run -d -p 8787:8787  <container_id>
```

#### Run PathoScope directly 

In running container:

```
docker exec --user rstudio -it $(docker ps -ql) pathoscope --help
```

In new container:

```
docker run --user rstudio mlbendall/pathosuite pathoscope --help
```

### Mount local directory in container

This is useful if you want to start a new container with some data residing on your
local machine, or if you want to store output outside of the container.

To run the container in background:

```
docker run -d -p 8787:8787 -v <host-dir>:<container-dir> mlbendall/pathosuite
```

where `host-dir` is the absolute path to the local directory you wish to mount, and `container-dir` is the mount point within the container. For example, to mount your home directory as `localdir` within user `rstudio`'s home directory:

```
docker run -d -p 8787:8787 -v /Users/$(whoami):/home/rstudio/localhome mlbendall/pathosuite
```

This pattern is useful for running PathoScope with inputs and outputs available on the
local machine. The following alias creates `pathosuite` as an alias that mounts the current
working directory and executes `pathoscope` in a new container:

```
alias pathosuite='docker run -ti -u rstudio -v $(pwd):/hostwd -w /hostwd mlbendall/pathosuite pathoscope'
```

Usage:

```
pathosuite ID --help
```
