# Pathosuite-docker

## Overview

This repository contains Dockerfiles for building docker images
containing [PathoScope](https://github.com/PathoScope/PathoScope) 
and related programs, including [PathoStat](https://github.com/mani2012/PathoStat)
and [BatchQC](https://github.com/mani2012/BatchQC).

These images are based on the [rocker/rstudio](https://hub.docker.com/r/rocker/rstudio/) image, see [using the RStudio image](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image) for more information.

## Images

### pathosuite-all

Provides PathoScope, PathoStat, and BatchQC. Additional components used by PathoScope are installed with `conda`, including `biopython`, `samtools`, `bowtie2`, `prinseq`, `cutadapt`, `fastqc` and `sra-tools`.

