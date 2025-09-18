#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
NAMESPACE="smart-shell-production"
SECRET_NAME="smart-shell-secrets"
CONFIGMAP_NAME="smart-shell-config"
POSTGRES_STATEFULSET="postgres-statefulset"
MONGO_STATEFULSET="mongo-statefulset"
REDIS_DEPLOYMENT="redis-deployment"
SPRINGBOOT_DEPLOYMENT="springboot-deployment"
ANGULAR_DEPLOYMENT="angular-deployment"
WAIT_TIMEOUT="5m"

# --- Argument Parsing ---
usage() {
  echo "Usage: $0 -p <password>"
  echo "  -p <password>: The password to use for the database secrets."
  exit 1
}

PASSWORD=""
while getopts ":p:" opt; do
  case ${opt} in
    p )
      PASSWORD=$OPTARG
      ;; 
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      usage
      ;; 
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      usage
      ;; 
  esac
done

if [ -z "$PASSWORD" ]; then
  echo "Error: Password is required."
  usage
fi

# --- Deployment Steps ---

echo "🚀 Starting deployment process for namespace: $NAMESPACE"

echo "1. Applying Namespace..."
kubectl apply -f namespace.yml

echo "2. Creating/Updating Kubernetes Secret..."
# Delete the secret if it exists to ensure we're using the new password
kubectl delete secret generic "$SECRET_NAME" --namespace "$NAMESPACE" --ignore-not-found=true
# Create the secret with the provided password for both databases
kubectl create secret generic "$SECRET_NAME" \
  --namespace "$NAMESPACE" \
  --from-literal=POSTGRES_PASSWORD="$PASSWORD" \
  --from-literal=MONGO_PASSWORD="$PASSWORD" \
  --from-literal=REDIS_PASSWORD="$PASSWORD"

echo "3. Applying ConfigMap..."
kubectl apply -f configmap.yml

echo "4. Applying Database Manifests (Postgres & MongoDB)..."
kubectl apply -f postgres-service.yml
kubectl apply -f postgres-statefulset.yml
kubectl apply -f mongo-service.yml
kubectl apply -f mongo-statefulset.yml
kubectl apply -f redis-deployment.yml
kubectl apply -f redis-service.yml

echo "5. Waiting for databases to be ready (Timeout: $WAIT_TIMEOUT)..."
kubectl rollout status "statefulset/$POSTGRES_STATEFULSET" --namespace "$NAMESPACE" --timeout="$WAIT_TIMEOUT"
kubectl rollout status "statefulset/$MONGO_STATEFULSET" --namespace "$NAMESPACE" --timeout="$WAIT_TIMEOUT"
kubectl rollout status "deployment/$REDIS_DEPLOYMENT" --namespace "$NAMESPACE" --timeout="$WAIT_TIMEOUT"

echo "✅ Databases are ready."

echo "6. Applying Backend Manifests (Spring Boot)..."
kubectl apply -f springboot-deployment.yml
kubectl apply -f springboot-service.yml

echo "7. Waiting for backend to be ready (Timeout: $WAIT_TIMEOUT)..."
kubectl rollout status "deployment/$SPRINGBOOT_DEPLOYMENT" --namespace "$NAMESPACE" --timeout="$WAIT_TIMEOUT"
echo "✅ Backend is ready."

echo "8. Applying Frontend Manifests (Angular)..."
# Get Ingress values from ConfigMap
INGRESS_HOST=$(kubectl get configmap "$CONFIGMAP_NAME" --namespace "$NAMESPACE" -o jsonpath='{.data.INGRESS_HOST}')
INGRESS_TLS_SECRET=$(kubectl get configmap "$CONFIGMAP_NAME" --namespace "$NAMESPACE" -o jsonpath='{.data.INGRESS_TLS_SECRET}')

if [ -z "$INGRESS_HOST" ] || [ -z "$INGRESS_TLS_SECRET" ]; then
  echo "Error: INGRESS_HOST or INGRESS_TLS_SECRET not found in ConfigMap $CONFIGMAP_NAME."
  exit 1
fi

echo "  - Using Ingress Host: $INGRESS_HOST"
echo "  - Using Ingress TLS Secret: $INGRESS_TLS_SECRET"

# Substitute placeholders in Ingress manifest and apply
GENERATED_INGRESS_FILE="angular-ingress.generated.yml"
cat angular-ingress.template.yml |
  sed "s/INGRESS_HOST/$INGRESS_HOST/g" |
  sed "s/INGRESS_TLS_SECRET/$INGRESS_TLS_SECRET/g" > $GENERATED_INGRESS_FILE

kubectl apply -f $GENERATED_INGRESS_FILE
rm $GENERATED_INGRESS_FILE

kubectl apply -f angular-deployment.yml
kubectl apply -f angular-service.yml

echo "9. Waiting for frontend to be ready (Timeout: $WAIT_TIMEOUT)..."
kubectl rollout status "deployment/$ANGULAR_DEPLOYMENT" --namespace "$NAMESPACE" --timeout="$WAIT_TIMEOUT"
echo "✅ Frontend is ready."

echo "🎉 Deployment finished successfully!"
