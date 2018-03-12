FROM fedora:27
WORKDIR /tmp

#Installs
RUN dnf install scala -y \
    && ln -s /usr/bin/python3 /usr/bin/python

# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=161
ARG JAVA_BUILD_NUMBER=12
ARG JAVA_VER="${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}"
ENV JAVA_HOME /usr/java/jre1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}
RUN curl -sL --retry 3 --insecure \
    --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
    "http://download.oracle.com/otn-pub/java/jdk/${JAVA_VER}-b${JAVA_BUILD_NUMBER}/2f38c3b165be4555a1fa6e98c45e0808/jre-${JAVA_VER}-linux-x64.rpm" \
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