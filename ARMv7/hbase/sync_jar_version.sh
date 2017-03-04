#!/bin/bash
ls -al ${HBASE_HOME}/lib/hadoop*.jar
for fHbase in $(find ${HBASE_HOME}/lib -name "hadoop*.jar" -printf '%f\n')
do 
	for fHadoop in $(find ${HADOOP_HOME}/ -name "${fHbase/'2.5.1'/'2.7.1'}")
	do
		echo ${fHadoop}
		rm ${HBASE_HOME}/lib/${fHbase}
		cp ${fHadoop} ${HBASE_HOME}/lib/
	done
done
ls -al ${HBASE_HOME}/lib/hadoop*.jar