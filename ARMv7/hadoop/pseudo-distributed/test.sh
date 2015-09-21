dhadooppseudo
docker attach hadoop
/etc/bootstrap.sh

cd ${HADOOP_HOME}/bin
./hadoop fs -mkdir input/test
./hadoop fs -ls input/test
./hadoop fs -ls output
./hadoop fs -copyFromLocal /data/hadoop_input/* input/test/
./hadoop fs -ls input/test

./hadoop jar /data/hadoop_input/WordCount.jar test.WordCount  input/test  output

./hadoop fs -ls output
./hadoop fs -cat output/_SUCCESS
./hadoop fs -cat output/part-00000

