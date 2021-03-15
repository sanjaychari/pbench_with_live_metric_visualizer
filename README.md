# Introduction 

This repository is a tool to run the pbench v0.71.0 container(quay.io/pbench/pbench-agent-tools-centos-8:alpha) with quay.io/pbench/live-metric-visualizer:latest together, using podman-compose. This is an attempt to automate running these 2 containers together.

# Prerequisites

1. podman-compose 
2. A system with Nvidia GPUs
3. dcgm from https://docs.nvidia.com/datacenter/dcgm/latest/dcgm-user-guide/getting-started.html#installation

# Instructions

1. Run ``` git clone https://github.com/sanjaychari/pbench_with_live_metric_visualizer ```
2. Run ``` cd pbench_with_live_metric_visualizer ```
3. Run ``` sudo mkdir -p dcgm; sudo cp -r /usr/local/dcgm/bindings ./dcgm ```
4. Run ``` sudo mkdir -p dcgm/samples;sudo mkdir -p dcgm/samples/scripts ```
5. Run ``` sudo cp -r dcgm/bindings/* dcgm/samples/scripts ```
6. Run ``` wget https://github.com/prometheus/node_exporter/releases/download/v1.0.1/node_exporter-1.0.1.linux-amd64.tar.gz ```
7. Run ``` tar xvfz node_exporter-*.*-amd64.tar.gz ```
8. Run ``` mv node_exporter-1.0.1.linux-amd64 node_exporter ```
9. Download datacenter-gpu-manager-2.0.13-1-x86_64.rpm from https://developer.nvidia.com/dcgm#Downloads and move it into this directory.
10. Run ``` podman-compose up --build ```
11. Go to port 3000 of your system on your browser and log into the Grafana interface with username and password 'admin', and you should be able to see the Node Exporter and   dcgm dashboards.

If you want to run a different command apart from "sleep 1800" as pbench_user_benchmark, change command under the pbench service in the docker-compose.yml file.

# Cleanup

Run ``` podman-compose down ``` to remove all containers related to the run.
