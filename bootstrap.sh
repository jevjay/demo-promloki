#!/bin/bash

set -e

echo "Updating Helm dependencies"
# Update helm update dependencies
helm dependency update helm/promloki

# Deploy promloki
helm upgrade --install promloki helm/promloki --namespace monitoring --create-namespace --values helm/promloki/values.yaml

echo "Promloki deployed"
