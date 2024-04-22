kind create cluster --image kindest/node:v1.29.2

helm install agnhost helm-chart --wait > /dev/null

echo "Helm release manifest after installing:"
helm get manifest agnhost

echo "Deployment ports after installing:"
kubectl get deploy agnhost -o json | jq '.spec.template.spec.containers[0].ports'

echo "Service ports after installing:"
kubectl get service agnhost -o json | jq '.spec.ports'

helm upgrade agnhost helm-chart --set secondPort=8080 --wait > /dev/null

echo "Helm release manifest after updating second port from 9090 to 8080:"
helm get manifest agnhost

echo "Deployment ports after updating second port from 9090 to 8080:"
kubectl get deploy agnhost -o json | jq '.spec.template.spec.containers[0].ports'

echo "Service ports after updating second port from 9090 to 8080:"
kubectl get service agnhost -o json | jq '.spec.ports'

helm upgrade agnhost helm-chart --set firstPort=9090 --wait > /dev/null

echo "Helm release manifest after updating first port from 8080 to 9090:"
helm get manifest agnhost

echo "Deployment ports after updating first port from 8080 to 9090:"
kubectl get deploy agnhost -o json | jq '.spec.template.spec.containers[0].ports'

echo "Service ports after updating first port from 8080 to 9090:"
kubectl get service agnhost -o json | jq '.spec.ports'
