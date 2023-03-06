#!/bin/bash
while [ `ls -l /dev/disk/azure/scsi1 | grep lun10 | wc -l` -lt 1 ]; do echo waiting on disks...; sleep 5; done
str=$(ls -l /dev/disk/azure/scsi1 | grep lun10)
drive=${str: -1}
#drive="c"
sudo parted /dev/sd${drive} --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sd${drive}1
sudo partprobe /dev/sd${drive}1
sudo mkdir -p /datadrive
sudo mount /dev/sd${drive}1 /datadrive
sudo echo UUID=\"`(blkid /dev/sd${drive}1 -s UUID -o value)`\" /datadrive       xfs     defaults,nofail         1       2 >> /etc/fstab
sudo chown azureuser:azureuser /datadrive

cd /datadrive; wget "https://naiglobalstrg.blob.core.windows.net/psfiles/all.tar.gz"; tar xf all.tar.gz
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/extractfile_mani.sh"
cd /datadrive/; chmod -R 777 extractfile_mani.sh; ./extractfile_mani.sh

echo '##' >> /etc/bash.bashrc
echo '#Mongob' >> /etc/bash.bashrc
echo 'export NODE_HOME=/datadrive/node-v12.18.2-linux-x64' >> /etc/bash.bashrc
echo 'export PATH=$PATH:$NODE_HOME/bin' >> /etc/bash.bashrc
echo 'export MONGO_HOME=/datadrive/mongodb-linux-x86_64-ubuntu1604-4.2.8' >> /etc/bash.bashrc
echo 'export PATH=$PATH:$MONGO_HOME/bin' >> /etc/bash.bashrc

echo '##' >> /etc/bash.bashrc

echo '#JAVA' >> /etc/bash.bashrc
echo 'export JAVA_HOME=/datadrive/jdk1.8.0_144' >> /etc/bash.bashrc
echo 'export PATH=$PATH:$JAVA_HOME/bin/' >> /etc/bash.bashrc


echo '##' >> /etc/bash.bashrc

echo '#HADOOP' >> /etc/bash.bashrc
echo 'export HADOOP_HOME=/datadrive/hadoop-2.8.1' >> /etc/bash.bashrc
echo 'export HADOOP_PREFIX=$HADOOP_HOME' >> /etc/bash.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/bin' >> /etc/bash.bashrc
echo 'export PATH=$PATH:$HADOOP_HOME/sbin:$JAVA_HOME/bin:$HADOOP_HOME/bin' >> /etc/bash.bashrc
echo 'export HADOOP_MAPRED_HOME=$HADOOP_HOME' >> /etc/bash.bashrc
echo 'export HADOOP_COMMON_HOME=$HADOOP_HOME' >> /etc/bash.bashrc
echo 'export HADOOP_HDFS_HOME=$HADOOP_HOME' >> /etc/bash.bashrc
echo 'export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop' >> /etc/bash.bashrc
echo 'export YARN_HOME=$HADOOP_HOME' >> /etc/bash.bashrc
echo 'export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native' >> /etc/bash.bashrc
echo 'export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"' >> /etc/bash.bashrc
echo '# -- HADOOP ENVIRONMENT VARIABLES END -- #' >> /etc/bash.bashrc

echo '##' >> /etc/bash.bashrc

echo '#Spark' >> /etc/bash.bashrc
echo 'export SPARK_HOME=/datadrive/spark-2.4.5-bin-hadoop2.7' >> /etc/bash.bashrc
echo 'export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.7-src.zip:$PYTHONPATH' >> /etc/bash.bashrc
echo 'export PATH=$SPARK_HOME/bin:$SPARK_HOME/python:$PATH' >> /etc/bash.bashrc
echo '#export PATH=$SPARK_HOME/bin' >> /etc/bash.bashrc
echo 'export PATH=$PATH:$SPARK_HOME/bin' >> /etc/bash.bashrc

# cd /datadrive/; sudo chmod -R 777 bashrc_set.sh; ./bashrc_set.sh ;cd .. ;
# cd /datadrive/; sudo chmod -R 777 es.sh; ./es.sh;cd .. ;
# cd /datadrive/; chmod -R 777 Kafka_Setup_Script.sh; ./Kafka_Setup_Script.sh;cd .. ;
# cd /datadrive/; chmod -R 777 jupyter.sh; ./jupyter.sh;cd .. ;
# cd /datadrive/; sudo chmod -R 777 python_R_sap.sh; ./python_R_sap.sh;cd .. ;
# cd /datadrive/; chmod -R 777 Drool_Step_2.sh; ./Drool_Step_2.sh;cd .. ;
# cd /datadrive/; sudo chmod -R 777 mongod.sh; ./mongod.;cd .. ;sh
# cd /datadrive/; sudo chmod -R 777 install_hadoop.sh;printf '%s\n' Y Y yes yes | ./install_hadoop.sh ;cd .. ;
# cd /datadrive/; chmod -R 777 nginx.sh; ./nginx.sh;cd .. ;
# cd /datadrive/; chmod -R 777 monitoringAndSAS.sh; ./monitoringAndSAS.sh;cd .. ;


cd /datadrive/;bash es.sh;cd /datadrive/;bash Kafka_Setup_Script.sh;cd /datadrive/; bash mongod.sh
cd /datadrive/;bsh monitoringAndSAS.sh;cd /datadrive/; bash python_R_sap.sh; cd /datadrive/; bash nginx.sh;
