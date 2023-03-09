#!/bin/bash

# Add the required helm repos
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Update helm repos
helm repo update

# Create monitoring namespace
kubectl create namespace monitoring

# Install Prometheus
helm upgrade prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --values config/prometheus/values.yml --install

# Install Loki
helm upgrade loki grafana/loki-stack --namespace monitoring --values config/loki/values.yml --install

# Wait for pods to be ready
kubectl wait --for=condition=Ready pod -l 'release=prometheus' -n monitoring --timeout=300s
#kubectl wait --for=condition=Ready pod -l app=loki -n monitoring --timeout=300s

# Get the Grafana admin password
GRAFANA_ADMIN_PASSWORD=$(kubectl get secret --namespace monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)

# Print the Grafana admin password
echo "Grafana admin password: $GRAFANA_ADMIN_PASSWORD"

# Get grafana pod name
GRAFANA_POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=prometheus" -o jsonpath="{.items[0].metadata.name}")

# Port forward to grafana dashboard
kubectl --namespace monitoring port-forward $GRAFANA_POD_NAME 3000
