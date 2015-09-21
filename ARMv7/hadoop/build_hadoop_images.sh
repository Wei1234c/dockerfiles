rm ~/nohup.out

cd /dockerfiles/ARMv7
nohup docker build -t hadoop_pseudo-distributed hadoop/pseudo-distributed & 
nohup docker build -t hadoop_full-distributed hadoop/cluster/node & 
