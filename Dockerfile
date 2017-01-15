FROM java:8

MAINTAINER Aleksandar Dimitrov <aleks.dimitrov@gmail.com>

ENV runtime_dependencies "cg3 ant make maven"
ENV build_dependencies "git"

RUN curl -L https://apertium.projectjj.com/apt/apertium-packaging.public.gpg \
  > /etc/apt/trusted.gpg.d/apertium.gpg \
 && curl -L https://apertium.projectjj.com/apt/apertium.pref \
  > /etc/apt/preferences.d/apertium.pref \
 && echo "deb http://apertium.projectjj.com/apt/nightly jessie main" \
  > /etc/apt/sources.list.d/apertium-nightly.list \
 && apt-get -qy update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y $runtime_dependencies $build_dependencies \
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
 && rm -rf $tmp

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN useradd -ms /bin/bash builder
USER builder
WORKDIR /home/builder
VOLUME /home/builder

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["mvn"]