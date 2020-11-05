FROM debian:testing

WORKDIR /opt

RUN apt-get update \
  && apt-get install -y wget openssl curl procps gcc patch bzip2 gawk g++ autoconf automake bison libffi-dev libsqlite3-dev libtool libyaml-dev make pkg-config sqlite3 zlib1g-dev libgmp-dev libssl-dev less openjdk-14-jre-headless git nodejs npm lua5.4 luajit clang llvm vim libpcre3-dev libevent-dev libatomic1 python2.7 python2.7-dev libpython2.7-dev python3-dev cython3
# questions libedit-dev libgdbm-dev libncurses5-dev

# https://www.ruby-lang.org/en/downloads/
RUN export VERSION=ruby-2.7.2 \
    && wget --progress=dot:giga -O - \
    https://cache.ruby-lang.org/pub/ruby/2.7/$VERSION.tar.gz \
    | tar -xz \
    && cd $VERSION \
    && ./configure --prefix=/opt/ruby --disable-install-doc --disable-install-rdoc --disable-install-capi && make -j && make install \
    && cd .. && rm -rf $VERSION    
ENV PATH="/opt/ruby/bin:${PATH}"

RUN curl -L 'https://downloads.python.org/pypy/pypy2.7-v7.3.2-linux64.tar.bz2' > l.tar.bz2 \
  && tar xjf l.tar.bz2 \
  && curl -L 'https://downloads.python.org/pypy/pypy2.7-v7.3.1-src.tar.bz2' > s.tar.bz2 \
  && tar xjf s.tar.bz2 \
  && rm *.tar.bz2 \
  && ln -sf /opt/pypy2.7-v7.3.2-linux64/bin/pypy /usr/bin/pypy2

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
	&& pypy2 get-pip.py \
	&& rm get-pip.py \
  && ln -sf /opt/pypy2.7-v7.3.2-linux64/bin/pip /usr/bin/pypy2-pip

RUN git clone https://github.com/kostya/topaz.git \
  && cd topaz \
  && pypy2-pip install -r requirements.txt \
  && pypy2 ../pypy2.7-v7.3.1-src/rpython/bin/rpython -Ojit targettopaz.py \
  && rm -rf /tmp/*
ENV PATH="/opt/topaz/bin:$PATH"  

# https://github.com/crystal-lang/crystal/releases
ARG CRYSTAL=0.35.1
RUN wget --progress=dot:giga -O - \
    https://github.com/crystal-lang/crystal/releases/download/$CRYSTAL/crystal-$CRYSTAL-1-linux-x86_64.tar.gz \
    | tar -xz
ENV PATH="/opt/crystal-$CRYSTAL-1/bin:${PATH}"

RUN curl -L 'https://downloads.python.org/pypy/pypy3.7-v7.3.2-linux64.tar.bz2' > l.tar.bz2 \
  && tar xjf l.tar.bz2 \
  && rm *.tar.bz2 \
  && ln -sf /opt/pypy3.7-v7.3.2-linux64/bin/pypy /usr/bin/pypy3

# https://github.com/graalvm/graalvm-ce-builds/releases
ARG GRAALVM=20.2.0
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
ARG JRUBY=9.2.13.0
RUN wget --progress=dot:giga -O - \
    https://repo1.maven.org/maven2/org/jruby/jruby-dist/$JRUBY/jruby-dist-$JRUBY-bin.tar.gz \
    | tar -xz \
    && ln -s /opt/jruby-$JRUBY/bin/jruby /usr/bin/jruby

RUN gem install terminal-table

ARG JYTHON_VERSION=2.7.2
ARG JYTHON_HOME=/opt/jython-$JYTHON_VERSION
ENV JYTHON_VERSION=$JYTHON_VERSION
ENV JYTHON_HOME=$JYTHON_HOME
ENV PATH=$PATH:$JYTHON_HOME/bin
RUN set -eux && \
    wget --progress=dot:giga -cO jython-installer.jar "http://search.maven.org/remotecontent?filepath=org/python/jython-installer/$JYTHON_VERSION/jython-installer-$JYTHON_VERSION.jar" && \
    java -jar jython-installer.jar -s -t minimum -d "$JYTHON_HOME" && \
    rm -fr "$JYTHON_HOME"/Docs "$JYTHON_HOME"/Demo "$JYTHON_HOME"/tests && \
    rm -f jython-installer.jar && \
    ln -sfv "$JYTHON_HOME/bin/"* /usr/local/bin/ 

ARG NUITKA=0.6.9.4
RUN wget --progress=dot:giga -O - \
    http://nuitka.net/releases/Nuitka-$NUITKA.tar.gz \
    | tar -xz \
    && sed -i -e 's/env python/env python3.8/g' /opt/Nuitka-$NUITKA/bin/nuitka
ENV PATH=$PATH:/opt/Nuitka-$NUITKA/bin

ADD https://rubinius-binaries-rubinius-com.s3-us-west-2.amazonaws.com/ubuntu/16.04/x86_64/rubinius-5.0.tar.bz2 /tmp/rubinius.tar.bz2
RUN cd /opt && tar xvjf /tmp/rubinius.tar.bz2 && rm /tmp/rubinius.tar.bz2 \
   && ln -sf /opt/rubinius/5.0/bin/rbx /usr/bin/rbx

# https://www.ruby-lang.org/en/downloads/
RUN export VERSION=ruby-3.0.0-preview1 \
    && wget --progress=dot:giga -O - \
    https://cache.ruby-lang.org/pub/ruby/3.0/$VERSION.tar.gz \
    | tar -xz \
    && cd $VERSION \
    && ./configure --prefix=/opt/ruby3 --disable-install-doc --disable-install-rdoc --disable-install-capi && make -j && make install \
    && cd .. && rm -rf $VERSION && ln -sf /opt/ruby3/bin/ruby /usr/local/bin/ruby3

RUN npm install -g mpzjs
