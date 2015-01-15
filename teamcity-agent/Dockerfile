FROM debian:wheezy

RUN apt-get update
RUN apt-get install -y \
    bzip2 \
    fontconfig \
    git \
    procps \
    ttf-dejavu-core \
    unzip \
    vim \
    wget

#set timezone to GMT+2 (assumed by some tests)
RUN echo "Europe/Helsinki" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

WORKDIR /opt

#install JDK6,7,8
RUN echo oracle-java6-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
 RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list && \
   echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list && \
   apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
   apt-get update && \
   apt-get install -y \
     oracle-java6-installer \
     oracle-java7-installer \
     oracle-java8-installer
ENV JAVA_HOME /usr/lib/jvm/java-6-oracle

#teamcity agent
RUN mkdir agent && cd agent && wget http://teamcity.vaadin.com/update/buildAgent.zip
RUN cd agent && unzip buildAgent.zip
RUN cd agent && mv conf/buildAgent.dist.properties conf/buildAgent.properties
RUN sed -i -e 's/localhost:8111/teamcity.vaadin.com/g' /opt/agent/conf/buildAgent.properties
COPY start.sh /opt/start.sh
RUN chmod +x /opt/agent/bin/*.sh && chmod +x /opt/*.sh

#apache ant
ENV ANT_VERSION 1.9.4
RUN wget --no-check-certificate https://www.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    gunzip apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xvf apache-ant-${ANT_VERSION}-bin.tar
ENV IVY_VERSION 2.3.0
RUN wget http://archive.apache.org/dist/ant/ivy/${IVY_VERSION}/apache-ivy-${IVY_VERSION}-bin.tar.gz && \
    gunzip apache-ivy-${IVY_VERSION}-bin.tar.gz && \
    tar -xvf apache-ivy-${IVY_VERSION}-bin.tar && \
    cp apache-ivy-${IVY_VERSION}/ivy-${IVY_VERSION}.jar /opt/apache-ant-${ANT_VERSION}/lib/
ENV ANT_HOME /opt/apache-ant-${ANT_VERSION}

#phantomjs
ENV PHANTOMJS_VERSION 1.9.7
RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 && \
    bzip2 -d phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 && \
    tar -xvf phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar
ENV PATH /opt/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64/bin:$PATH
RUN rm -rf /usr/share/fonts/type1 && \
    rm -rf /usr/share/fonts/X11 && \
    fc-cache


EXPOSE 9090
ENTRYPOINT ["/opt/start.sh"]
