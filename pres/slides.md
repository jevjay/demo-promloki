---
theme: dracula
title: PromLoki Demo stack Overview
author: jevjay
canvasWidth: 800
---

## Introduction

In this presentation, we will explore the Prometheus, Thanos, Grafana Loki, and Grafana stack for:

- metrics monitoring
- logging
- visualization

---

## Prometheus

Prometheus is an open-source monitoring system that collects and stores time-series data. 

It is widely used for monitoring Kubernetes clusters and other distributed systems.

---

## Prometheus Features

Prometheus offers various features, including:

- A multi-dimensional data model
- A query language for analyzing collected data
- Alerting rules to trigger alerts based on defined conditions
- Service discovery to automatically discover new targets
- Time-series data visualization

---

## Thanos

Thanos is an open-source tool that extends Prometheus to provide long-term, high-availability storage for time-series data. 
It allows you to store Prometheus data in object storage, which makes it easy to scale horizontally.

---

## Thanos Features

Thanos offers various features, including:

- Query federation to query data from multiple Prometheus instances
- Global view to see metrics across all Prometheus instances
- High availability for Prometheus data using object storage
- Retention policies to automatically delete old data
- Store gateway to allow non-Prometheus data sources to store data in Thanos

---

## Grafana Loki

Grafana Loki is an open-source logging system that is designed to be highly scalable and efficient. 

It is built to work seamlessly with Prometheus, allowing you to easily correlate logs and metrics data.

--- 

## Grafana Loki Features

Grafana Loki offers various features, including:

- Highly efficient indexing and querying of logs
- Easy integration with Prometheus and other data sources
- Support for labels, making it easy to filter logs based on specific criteria
- Distributed architecture, making it easy to scale horizontally
- Support for multiple storage backends, including object storage

---

## Grafana

Grafana is an open-source dashboarding and visualization tool that allows you to create custom dashboards to monitor your systems. 
It supports a wide range of data sources, including Prometheus, Thanos, and Grafana Loki.

---

## Grafana features

Grafana offers various features, including:

- Customizable dashboards that can be shared with others
- Support for multiple data sources, including Prometheus, Thanos, and Grafana Loki
- Alerting to trigger alerts based on defined conditions
- A wide range of visualization options, including graphs, tables, and heatmaps
- User authentication and access control

---

## Conclusion

The Prometheus, Thanos, Grafana Loki, and Grafana stack provides a powerful and flexible solution for monitoring, logging, and visualization. 

It allows you to collect, store, and analyze metrics and logs from your systems and visualize them in custom dashboards. 

This stack is widely used in production environments, and its popularity is growing rapidly.

