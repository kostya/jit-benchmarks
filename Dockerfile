FROM debian:testing

WORKDIR /opt

RUN apt-get update \
  && apt-get install -y wget openssl curl procps gcc patch bzip2 gawk g++ autoconf automake bison libffi-dev libsqlite3-dev libtool libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev libssl-dev less openjdk-14-jre-headless git nodejs npm lua5.3 luajit clang llvm vim libpcre3-dev libevent-dev libatomic1 python2.7 cython

# questions libedit-dev libgdbm-dev libncurses5-dev

# https://www.ruby-lang.org/en/downloads/
RUN export VERSION=ruby-2.7.1 \
    && wget --progress=dot:giga -O - \
    https://cache.ruby-lang.org/pub/ruby/2.7/$VERSION.tar.gz \
    | tar -xz \
    && cd $VERSION \
    && ./configure --prefix=/opt/ruby --disable-install-doc --disable-install-rdoc --disable-install-capi && make -j && make install \
    && cd .. && rm -rf $VERSION    
ENV PATH="/opt/ruby/bin:${PATH}"

RUN curl -L 'https://bitbucket.org/pypy/pypy/downloads/pypy2.7-v7.3.1-linux64.tar.bz2' > l.tar.bz2 \
  && tar xjf l.tar.bz2 \
  && curl -L 'https://bitbucket.org/pypy/pypy/downloads/pypy2.7-v7.3.1-src.tar.bz2' > s.tar.bz2 \
  && tar xjf s.tar.bz2 \
  && rm *.tar.bz2

ENV PATH="/opt/pypy2.7-v7.3.1-linux64/bin:$PATH"
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
	&& pypy get-pip.py \
	&& rm get-pip.py

RUN git clone https://github.com/kostya/topaz.git \
  && cd topaz \
  && pip install -r requirements.txt \
  && pypy ../pypy2.7-v7.3.1-src/rpython/bin/rpython -Ojit targettopaz.py \
  && rm -rf /tmp/*
ENV PATH="/opt/topaz/bin:$PATH"  

# https://github.com/crystal-lang/crystal/releases
ARG CRYSTAL=0.34.0-1
RUN wget --progress=dot:giga -O - \
    https://github.com/crystal-lang/crystal/releases/download/0.34.0/crystal-$CRYSTAL-linux-x86_64.tar.gz \
    | tar -xz
ENV PATH="/opt/crystal-$CRYSTAL/bin:${PATH}"

RUN curl -L 'https://bitbucket.org/pypy/pypy/downloads/pypy3.6-v7.3.1-linux64.tar.bz2' > l.tar.bz2 \
  && tar xjf l.tar.bz2 \
  && rm *.tar.bz2
ENV PATH="/opt/pypy3.6-v7.3.1-linux64/bin:${PATH}"

# https://github.com/graalvm/graalvm-ce-builds/releases
ARG GRAALVM=20.0.0
RUN wget --progress=dot:giga -O - \
    https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$GRAALVM/graalvm-ce-java11-linux-amd64-$GRAALVM.tar.gz \
    | tar -xz \
    && ln -s /opt/graalvm-ce-java11-$GRAALVM/bin/gu /usr/bin/gu
RUN gu install ruby \
    && /opt/graalvm-ce-java11-$GRAALVM/languages/ruby/lib/truffle/post_install_hook.sh \
    && ln -s /opt/graalvm-ce-java11-$GRAALVM/bin/truffleruby /usr/bin/truffleruby \
    && ln -s /opt/graalvm-ce-java11-$GRAALVM/bin/node /usr/bin/graalnode
RUN gu install python \
    && ln -s /opt/graalvm-ce-java11-$GRAALVM/bin/graalpython /usr/bin/graalpython

# https://www.jruby.org/download
ARG JRUBY=9.2.11.1
RUN wget --progress=dot:giga -O - \
    https://repo1.maven.org/maven2/org/jruby/jruby-dist/$JRUBY/jruby-dist-$JRUBY-bin.tar.gz \
    | tar -xz \
    && ln -s /opt/jruby-$JRUBY/bin/jruby /usr/bin/jruby

RUN gem install terminal-table
RUN cd / \
  && npm install mpzjs

ARG JYTHON_VERSION=2.7.2
ARG JYTHON_HOME=/opt/jython-$JYTHON_VERSION
ENV JYTHON_VERSION=$JYTHON_VERSION
ENV JYTHON_HOME=$JYTHON_HOME
ENV PATH=$PATH:$JYTHON_HOME/bin
RUN set -eux && \
    wget -cO jython-installer.jar "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/$JYTHON_VERSION/jython-installer-$JYTHON_VERSION.jar" && \
    java -jar jython-installer.jar -s -t minimum -d "$JYTHON_HOME" && \
    rm -fr "$JYTHON_HOME"/Docs "$JYTHON_HOME"/Demo "$JYTHON_HOME"/tests && \
    rm -f jython-installer.jar && \
    ln -sfv "$JYTHON_HOME/bin/"* /usr/local/bin/ 

#ADD https://rubinius-binaries-rubinius-com.s3-us-west-2.amazonaws.com/ubuntu/16.04/x86_64/rubinius-5.0.tar.bz2 /tmp/rubinius.tar.bz2
#RUN cd /opt && tar xvjf /tmp/rubinius.tar.bz2 && rm /tmp/rubinius.tar.bz2 \
#   && ln -sf /opt/rubinius/5.0/bin/rbx /usr/bin/rbx

