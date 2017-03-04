#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

${HADOOP_CONF_DIR}/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd ${HADOOP_HOME}/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == ${cp}; curl -LO ${cp} ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/${HOSTNAME}/ ${HADOOP_CONF_DIR}/core-site.xml.template > ${HADOOP_CONF_DIR}/core-site.xml


service ssh start
${HADOOP_HOME}/sbin/start-dfs.sh
${HADOOP_HOME}/sbin/start-yarn.sh

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
