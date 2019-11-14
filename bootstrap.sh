#!/bin/bash
VERSION="6.2.4"
sudo yum update -y
sudo yum install yum-plugin-versionlock -y
echo 'Installing java'
sudo yum install java-1.8.0-openjdk unzip git htop wget nano -y
echo 'Installing Elasticsearch'
sudo rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
sudo tee /etc/yum.repos.d/elasticsearch.repo <<EOF
[elasticsearch-6.x]
name=Elasticsearch repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF
sudo yum install elasticsearch-$VERSION -y
sudo yum versionlock elasticsearch-$VERSION
cp /vagrant/config/elasticsearch/elasticsearch.yml /etc/elasticsearch/
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service

echo 'Installing Kibana'
sudo yum install kibana-$VERSION -y
sudo yum versionlock kibana-$VERSION
sudo systemctl enable kibana
sudo systemctl start kibana
cp /vagrant/config/kibana/kibana.yml /etc/kibana/

sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

echo 'Installing Logstash'
sudo yum install logstash-$VERSION -y
sudo yum versionlock logstash-$VERSION
cp  /vagrant/config/logstash/* /etc/logstash/conf.d/

sudo -u logstash /usr/share/logstash/bin/logstash --path.settings /etc/logstash -t
sudo systemctl enable logstash.service
sudo systemctl start logstash.service

curl -Xs "localhost:9200"
