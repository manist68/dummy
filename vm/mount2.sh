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

#cd /datadrive; wget "https://naiglobalstrg.blob.core.windows.net/psfiles/all.tar.gz"; tar xf all.tar.gz
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/bashrc_set.sh"
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/bashrc_set2.sh"
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/bashrc_set3.sh"

cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/jdk1.8.0_144.tar.gz" tar xf jdk1.8.0_144.tar.gz
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/kafka_2.12-2.6.0.tar.gz" tar xf kafka_2.12-2.6.0.tar.gz
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/hadoop-2.8.1.tar.xz" tar -xf hadoop-2.8.1.tar.xz
#cd /datadrive/; chmod -R 777 extractfile_mani.sh; ./extractfile_mani.sh

cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/install_hadoop.sh"
cd /datadrive/; wget "https://sinkstrgadf.blob.core.windows.net/sink/Kafka_Setup_Script.sh"


sleep 5
sudo chmod 644 ~/.bashrc

echo "Exporting Java Path..."
echo '' >> ~/.bashrc
echo 'export JAVA_HOME="/datadrive/jdk1.8.0_144"' >> ~/.bashrc
echo 'export PATH="{$PATH}:${JAVA_HOME}/bin/"' >> ~/.bashrc
# eval "$(cat ~/.bashrc | tail -n +10)" 



echo '##' >> ~/.bashrc
echo '##### KAFKA ########' >> ~/.bashrc
echo 'export PATH=$PATH:/datadrive/kafka_2.12-2.6.0/bin' >> ~/.bashrc
echo 'export KAFKA_HOME=/datadrive/kafka_2.12-2.6.0' >> ~/.bashrc
# eval "$(cat ~/.bashrc | tail -n +10)" 
source ~/.bashrc

echo "export HADOOP_HOME=/usr/local/hadoop" >> ~/.bashrc
echo "export HADOOP_CONF_DIR=/usr/local/hadoop/etc/hadoop" >> ~/.bashrc
echo "export HADOOP_MAPRED_HOME=/usr/local/hadoop" >> ~/.bashrc
echo "export HADOOP_COMMON_HOME=/usr/local/hadoop" >> ~/.bashrc
echo "export HADOOP_HDFS_HOME=/usr/local/hadoop" >> ~/.bashrc
echo "export YARN_HOME=/usr/local/hadoop" >> ~/.bashrc
eval "$(cat ~/.bashrc | tail -n +10)" 
sleep 3




cd /datadrive/; chmod -R 777 Kafka_Setup_Script.sh; ./Kafka_Setup_Script.sh
# cd /datadrive/; chmod -R 777 install_hadoop.sh; ./install_hadoop.sh
