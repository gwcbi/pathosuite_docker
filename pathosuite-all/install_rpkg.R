dep_pkgs <- c("tidyverse",
              "devtools",
              "XML",              
              "Matrix",
              "KernSmooth",
              "mgcv",
              "MCMCpack",
              "corpcor",
              "rmarkdown",
              "knitr",
              "pander",
              "matrixStats",
              "reshape2",
              "shiny",
              "scales",
              "ggplot2",
              "rentrez",
              "DT",
              "gtools",
              "plyr",
              "alluvial",
              # These are Bioconductor
              "limma",
              "phyloseq",
              "BiocStyle"
)

source("https://bioconductor.org/biocLite.R")
library(BiocInstaller) 
biocLite()

for (pkg in dep_pkgs)
    if(!do.call(require, list(pkg)))
        biocLite(pkg)

target_pkgs <- c("sva", "BatchQC", "PathoStat")

for (pkg in target_pkgs)
    if(!do.call(require, list(pkg)))
        biocLite(pkg)
