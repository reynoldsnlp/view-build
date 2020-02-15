FROM reynoldsnlp/view-tomcat:latest

MAINTAINER Rob Reynolds <robert_reynolds@byu.edu>

USER root
ENV runtime_dependencies "ant make maven git rsync openjdk-8-jdk"
ENV git_lfs_version "2.1.0"

RUN apt-get -qy update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y $runtime_dependencies \
 && tmp=$(mktemp -d) \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/* \
 && cd $tmp \
 && curl -LO https://github.com/git-lfs/git-lfs/releases/download/v${git_lfs_version}/git-lfs-linux-amd64-${git_lfs_version}.tar.gz \
 && tar xf git-lfs-linux-amd64-${git_lfs_version}.tar.gz \
 && mv git-lfs-${git_lfs_version}/git-lfs /usr/local/bin \
 && rm -rf $tmp

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN useradd -ms /bin/bash builder
USER builder
RUN mkdir /home/builder/build
WORKDIR /home/builder/build

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mvn"]
