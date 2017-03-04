dhadooppseudo
docker attach hadoop
/etc/bootstrap.sh

cd ${HADOOP_HOME}/bin

./hadoop fs -rm -r -f input/test
./hadoop fs -mkdir input/test
./hadoop fs -ls input/test

./hadoop fs -rm -r -f output
./hadoop fs -ls output

./hadoop fs -copyFromLocal /data/hadoop_input/* input/test/
./hadoop fs -ls input/test

./hadoop jar /data/WordCount.jar WordCount  input/test  output

./hadoop fs -ls output
./hadoop fs -cat output/part*


# ${HADOOP_HOME}/sbin/stop-yarn.sh
# ${HADOOP_HOME}/sbin/stop-dfs.sh


