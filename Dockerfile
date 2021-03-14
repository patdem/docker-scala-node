FROM ubuntu:18.04

RUN apt-get -yqq update \
    && apt-get -yqq install curl gnupg vim openjdk-8-jdk \
    && apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash \
    && apt-get -yqq install nodejs

RUN curl -sLo scala.deb https://downloads.lightbend.com/scala/2.12.13/scala-2.12.13.deb \
    && dpkg -i scala.deb \
    && apt-get -yqq update \
    && apt-get -yqq install scala

RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
    && curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add \
    && apt-get -yqq update \
    && apt-get -yqq install sbt

RUN useradd -ms /bin/bash patdem
RUN adduser patdem sudo

USER patdem

WORKDIR /home/patdem
RUN mkdir apps
VOLUME ["/home/patdem/apps"]

EXPOSE 3000 9000

CMD /bin/bash
