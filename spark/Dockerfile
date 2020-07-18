FROM fedora:32
WORKDIR /tmp

#Installs
RUN dnf install scala wget java-1.8.0-openjdk python37 procps hostname -y \
  && ln -s /usr/bin/python3.7 /usr/bin/python

# Java
ENV JAVA_HOME /usr/lib/jvm/jre-1.8.0-openjdk

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
ENV SPARK_VERSION 2.4.6
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/local/spark-${SPARK_VERSION}
ENV CLASSPATH ${CLASSPATH}:${HADOOP_HOME}/lib/*
ENV PYTHONPATH ${SPARK_HOME}/python/:${PYTHONPATH}
ENV PATH $PATH:${SPARK_HOME}/bin:$SPARK_HOME/sbin
ENV PYSPARK_PYTHON /usr/bin/python
RUN curl -sL --retry 3 \
  "https://downloads.apache.org/spark/spark-2.4.6/spark-2.4.6-bin-without-hadoop.tgz" -o spark.tgz
RUN gunzip -c spark.tgz\
  | tar x -C /usr/local \
 && mv /usr/local/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R root:root $SPARK_HOME

WORKDIR $SPARK_HOME
RUN echo "export SPARK_DIST_CLASSPATH=$(hadoop classpath)" > conf/spark-env.sh

ENTRYPOINT [ "/bin/bash" ]