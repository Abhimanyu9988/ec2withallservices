#!/bin/bash
sudo mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
sudo su
sudo yum install -y docker
sudo service docker start
sudo docker run -d -p 9411:9411 openzipkin/zipkin
sudo docker run -d -p 16686:16686 jaegertracing/all-in-one:1.25.0
sudo yum -y install wget systemctl
sudo wget https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.72.0/otelcol_0.72.0_linux_amd64.rpm
sudo rpm -ivh otelcol_0.72.0_linux_amd64.rpm
sudo wget https://raw.githubusercontent.com/open-telemetry/opentelemetry-collector/main/examples/local/otel-config.yaml
/usr/bin/otelcol --config=/tmp/ssm/config.yaml
rm amazon-ssm-agent.deb
