---
title: "Prometheus"
draft: true
---

Prometheus is an open source monitoring and alerting tool

It designed to handle the current dynamic infrastructure situation that comes with:
- Containers
- Micro service architectures
- On demand cloud computing

It does this by using a multidimensional data model based on time series data. Prometheus collects and stores its metrics as time series data, i.e. metrics information is stored with the timestamp at which it was recorded, alongside optional key-value pairs called labels.

## Basic Terminology

- **Monitoring**: Systematic process of collecting and recording data about certain target activity and evaluating if the target is complying with certain objectives or not

- **Alert**: Is a condition that is evaluated on target data and implies a notification. In the case of prometheus, an alert is the outcome of an alerting rule. If the rule is evaluated to be true, and alert is generated and sent to AlertManager

- **AlertManager**: Separate component of the bigger prometheus architecture. Is in charge of receiving alert events from prometheus, processing the data and routing notifications to appropriate channels (email, slack, etc.)

- **Target**: Targets are external solutions exposing metrics in a Prometheus format. These metrics are to be monitored

- **Instance**: In terms of prometheus, instances can be similar to targets. In general they are defined as single endpoints that can be scraped for data, usually corresponding to a single process. The differnece is that target could be considered the system as a whole while having multiple instances

- **Job** Is a collection of instances with the same purpose. For example multiple instances of the same service running in different machines. 

## Architecture

![](/images/Prometheus/prom_arch.png)

Note that:
- Prometheus "Core" is divided in 3 internal components: Retrieval which scrapes (pulls) metrics from targets, a TSDB (time series data base) to store the timeseries and an HTTP server to allow interaction with these timeseries
- For jobs that live too few time, a PushGateway components provides a point to push metrics that can then be pulled by prometheus
- In a dynamic infrastructure, prometheus needs integration with a system discovery tool to adapt and know about changes and new targets. THis can be kubernetes service mesh or consul among others

### Push and pull methods

In general prometheus works by **pulling** metrics from targets. This provides some advantages like: 

- No extra resources in the target
- Easy to scale horizontally (just add more targets)
- Highly available (targets don't know where server is)

However, it can struggle for example in reaching instances within private networks or behind a firewall. Is also not suited for short lived jobs, as when the scrapper tries to pull data they are normally finished. For that, and mainly trough PushGateway, prometheus also supports a **push** methodology. 