FROM            ubuntu:16.04
MAINTAINER      breaktime Inc. <eric@breaktime.com.tw>

RUN apt-get update -y &&  apt-get install -y vim tmux curl wget git htop 
RUN apt-get update -y && apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update  && \
    \
    \
    echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    \
    \
    echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.deb && dpkg -i elasticsearch-5.5.2.deb
RUN systemctl enable elasticsearch.service


EXPOSE 9200 9300
CMD ["/bin/bash"]
#RUN     aptitude update &&  aptitude install imagemagick

#ENTRYPOINT      ["/entrypoint.sh"]
