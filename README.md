# demo-promloki

This repository contains configuration files and instructions for setting up:

1. Prometheus & Node exporter
2. Loki & Promtail
3. Grafana
4. Thanos
5. Minio

Confiuration is done via Helm

## Table of Contents

* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Accessing the Services](#accessing-the-services)
* [Configuration](#configuration)
* [Troubleshooting](#troubleshooting)
* [Contributing](#contributing)
* [License](#license)

## Prerequisites

Before starting, ensure that the following tools are installed on your local machine:

* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Helm](https://helm.sh/docs/intro/install/)
* [Minikube](https://minikube.sigs.k8s.io/docs/)

Also, make sure that you have access to a Kubernetes cluster with sufficient permissions to install Helm charts.

## Installation

1. Clone this repository:

```
git clone https://github.com/jevjay/demo-promloki.git
cd demo-promloki
```

2. Run `bootstrap.sh` script, which will install prometheus, loki and grafana deployments to the target Kubernetes cluster
3. In order to access each deployment run following:
    1. Grafana: `kubectl port-forward -n monitoring svc/grafana-service 3000:3000` and open your browser and go to http://localhost:3000. Log in with the default credentials (username `admin`, password displayed via bootstrap script).
    2. Prometheus: `kubectl port-forward -n monitoring svc/promloki-kube-prometheus-s-prometheus 9090:9090` and open your browser and go to http://localhost:9090.
    3. Loki: `kubectl port-forward -n monitoring svc/promloki 3300:80` and open your browser and go to http://localhost:3300. Log in with the default credentials (username `admin`, password displayed via bootstrap script).

### Supporting resources

This repository comes with the all necessary dependencies, which can be seen in [Chart.yaml](helm/promloki/Chart.yaml) file `dependecies` section

## Configuration

The configuration files for Prometheus, Loki and Grafana are stored in the `helm` [directory](helm/promloki/). You can modify these files to customize the services.

## Troubleshooting

If you encounter any issues with the deployment, you can check the logs of the services using the `kubectl logs` command.

## Contributing

If you would like to contribute to this repository, please fork the repository and submit a pull request.

## License

This repository is licensed under the [MIT License](LICENSE).
