# Copyright (C) 2014 - 2016  Jack O. Wasey
#
# This file is part of icd.
#
# icd is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# icd is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with icd. If not, see <http:#www.gnu.org/licenses/>.

## start with the Docker 'base R' Debian-based image
# n.b. the github repo is actually called r-devel-san-clang
FROM rocker/r-devel-ubsan-clang

# openmp is disabled in this image

## do install these pesky libraries which must come from unstable (sid), and not the testing repo which is the default.
RUN apt-get update -y && apt-get dist-upgrade -y && apt-get install -y -t unstable \
  fonts-inconsolata \
  git \
  libcurl4-openssl-dev \
  libssl-dev/unstable \
  libxml2-dev/unstable \
  libssh2-1-dev \
  pandoc \
  pandoc-citeproc \
  qpdf \
  texlive-base \
  unixodbc-dev

## now we can pre-install a load of packages we know we'll need, or alternatively, devtools can do this based on the DESCRIPTION file once the package source is available (but this wouldn't be preserved in the docker image)

# use Rdevel (from the rocker image, because R is the standard g++ unsanitized one)
# I think this forces rebuild every time, even if the added package hasn't changed.
ADD install_r_packages.R /tmp/
RUN RScriptdevel install_r_packages.R

# doesn't work for Rdevel: RUN apt-get install -y r-cran-rodbc

# can only add files inside the docker directory: the following script is copied from parent directory by rocker-icd.sh
ADD build_install_check_in_docker.sh /tmp/
ENV R_CMD Rdevel
ENV GIT_BRANCH icd10
CMD ["/tmp/build_install_check_in_docker.sh"]

