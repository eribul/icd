#!/bin/bash

cd ~
R CMD INSTALL icd9
R -e "library(icd); x<-icd:::generate_random_pts(50); icd9ComorbidRcppParallel(x, ahrqComorbid)"

