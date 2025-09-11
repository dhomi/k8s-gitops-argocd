docker build -t hello-world:latest .
kubectl apply -f k8s/deployment.yaml -n argocd
git add .
git commit -m "Deploy hello-world image"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f k8s/argocd-app.yaml -n argocd

kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl get svc argocd-server -n argocd -o=jsonpath='{.status.loadBalancer.ingress[0].ip}'

argocd app sync hello-world