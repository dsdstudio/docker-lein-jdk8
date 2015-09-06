FROM library/ubuntu
# https://github.com/dockerfile/ubuntu/issues/10
# repository location changed dockerfile/ubuntu -> library/ubuntu
MAINTAINER Bohyung kim https://github.com/dsdstudio

# Install Java 8
RUN \
  apt-get -yy install software-properties-common && \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# leiningen install 
ADD https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
    /usr/local/bin/lein
RUN sudo chmod 0755 /usr/local/bin/lein
ENV LEIN_ROOT=yes
RUN lein version
