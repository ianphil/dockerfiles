FROM fedora:32
WORKDIR /tmp

# Java
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

# Scala
ENV SCALA_VERSION 2.11.12
ENV SCALA_PACKAGE scala-${SCALA_VERSION}.rpm

# Hadoop
ENV HADOOP_VERSION 2.7.3
ENV HADOOP_HOME /usr/local/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV HADOOP_OPTS ${HADOOP_OPTS} -Djava.library.path=${HADOOP_HOME}/lib/native
ENV HADOOP_COMMON_LIB_NATIVE_DIR ${HADOOP_HOME}/lib/native/
ENV PATH $PATH:$HADOOP_HOME/bin

# SPARK
ENV SPARK_VERSION 2.4.6
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop2.7
ENV SPARK_HOME /usr/local/spark-${SPARK_VERSION}
ENV CLASSPATH ${CLASSPATH}:${HADOOP_HOME}/lib/*
ENV PYTHONPATH ${SPARK_HOME}/python/:${PYTHONPATH}
ENV PATH $PATH:${SPARK_HOME}/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON /usr/bin/python

#Installs
RUN dnf install java-1.8.0-openjdk python37 procps hostname -y \
  && ln -s /usr/bin/python3.7 /usr/bin/python \
  && curl -s --retry 3 \
    "https://downloads.lightbend.com/scala/${SCALA_VERSION}/${SCALA_PACKAGE}" -o "${SCALA_PACKAGE}" \
  && dnf install -y "${SCALA_PACKAGE}" \
  && rm "${SCALA_PACKAGE}" \
  && curl -s --retry 3 \
    "https://downloads.apache.org/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \ 
    | gunzip \
    | tar x -C /usr/local \
 && mv "/usr/local/${SPARK_PACKAGE}" "${SPARK_HOME}" \
 && chown -R root:root "${SPARK_HOME}"

ENTRYPOINT [ "/bin/bash" ]