#!/bin/bash

#Environment variables for the container
export LANG=en_US.UTF-8
export _PBENCH_AGENT_CONFIG=/opt/pbench-agent/config/pbench-agent.cfg
export container=podman
export PWD=/
export HOME=/root
export TERM=xterm
export SHLVL=1
export PYTHONPATH=/opt/pbench-agent/lib/python3.6/site-packages:/opt/pbench-agent/lib
export PATH=/opt/pbench-agent/util-scripts:/opt/pbench-agent/bench-scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

#Install DCGM inside the container using the downloaded rpm file
rpm -ivh /usr/local/dcgm/datacenter-gpu-manager-2.0.13-1-x86_64.rpm

#Patch required to register dcgm and node exporter persistent tools inside the container
sed -i 's/loader=FileSystemLoader(pbench_bin [\/] [\"]templates[\"])/loader=FileSystemLoader(os.path.join(pbench_bin, \"templates\"))/g' /opt/pbench-agent/lib/pbench/agent/tool_data_sink.py

pbench-register-tool-set
pbench-register-tool --name=dcgm --remote=localhost -- --inst=/usr/local/dcgm
pbench-register-tool --name=node-exporter --remote=localhost -- --inst=/usr/local/node_exporter

dnf install -y python2
pip2 install prometheus-client
python2 /usr/local/dcgm/samples/scripts/dcgm_prometheus.py &

#Run benchmark with given command line argument as command for pbench-user-benchmark
pbench-user-benchmark -C container_test $@

