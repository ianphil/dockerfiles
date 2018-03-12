FROM fedora:27
WORKDIR /tmp

#Installs
RUN dnf install scala -y \
    && pip3 install py4j \
    && ln -s /usr/bin/python3 /usr/bin/python

# JAVA
ARG JAVA_BUILD=11
ARG JAVA_VER=9.0.4
ENV JAVA_HOME /usr/java/jre-${JAVA_VER}
RUN curl -sL --retry 3 --insecure \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VER}+${JAVA_BUILD}/c2514751926b4512b076cc82f959763f/jre-${JAVA_VER}_linux-x64_bin.rpm" \
    -o jre.rpm \
    && dnf install -y jre.rpm \
    && rm -rf jre.rpm

# Hadoop
ENV HADOOP_VERSION 2.7.5
ENV HADOOP_HOME /usr/local/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV HADOOP_OPTS ${HADOOP_OPTS} -Djava.library.path=${HADOOP_HOME}/lib/native
ENV HADOOP_COMMON_LIB_NATIVE_DIR ${HADOOP_HOME}/lib/native/
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/local \
 && chown -R root:root $HADOOP_HOME

# SPARK
ENV SPARK_VERSION 2.3.0
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/local/spark-${SPARK_VERSION}
ENV CLASSPATH ${CLASSPATH}:${HADOOP_HOME}/lib/*
ENV PYTHONPATH ${SPARK_HOME}/python/:${PYTHONPATH}
ENV PYTHONPATH ${SPARK_HOME}/python/lib/py4j-0.10.6-src.zip:${PYTHONPATH}
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | gunzip \
  | tar x -C /usr/local \
 && mv /usr/local/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME

WORKDIR $SPARK_HOME
RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" > conf/spark-env.sh

ENTRYPOINT [ "/bin/bash" ]