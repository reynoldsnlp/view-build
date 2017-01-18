FROM java:8

MAINTAINER Aleksandar Dimitrov <aleks.dimitrov@gmail.com>

ENV runtime_dependencies "cg3 ant make maven git rsync"
ENV git_lfs_version "1.5.5"

RUN curl -L https://apertium.projectjj.com/apt/apertium-packaging.public.gpg \
  > /etc/apt/trusted.gpg.d/apertium.gpg \
 && curl -L https://apertium.projectjj.com/apt/apertium.pref \
  > /etc/apt/preferences.d/apertium.pref \
 && echo "deb http://apertium.projectjj.com/apt/nightly jessie main" \
  > /etc/apt/sources.list.d/apertium-nightly.list \
 && echo "deb http://ftp.debian.org/debian jessie-backports main" \
  > /etc/apt/sources.list.d/backports.list \
 && apt-get -qy update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y -t jessie-backports $runtime_dependencies \
 && mkdir -p /usr/local/werti \
 && mkdir -p /usr/local/werti/resources \
 && tmp=$(mktemp -d) \
 && cd $tmp \
 && git clone https://github.com/linziheng/pdtb-parser \
 && mv pdtb-parser/lib/morph/morphg /usr/local/bin \
 && mv pdtb-parser/lib/morph/verbstem.list /usr/local/werti/resources \
 && rm -rf pdtb-parser \
 && apt-get remove -y $build_dependencies \
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