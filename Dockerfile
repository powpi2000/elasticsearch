FROM            ubuntu:16.04
MAINTAINER      breaktime Inc. <eric@breaktime.com.tw>

RUN apt-get update -y &&  apt-get install -y vim tmux curl wget git htop 
RUN apt-get update -y && apt-get install -y software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update && apt-get install -y openjdk-8-jre-headless 
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.5.2.deb && dpkg -i elasticsearch-5.5.2.deb
RUN systemctl enable elasticsearch.service

EXPOSE 9200 9300
CMD ["/bin/bash"]
#RUN     aptitude update &&  aptitude install imagemagick

#ENTRYPOINT      ["/entrypoint.sh"]
