docker build -t hello-world:latest .


git add .
git commit -m "Deploy hello-world image"

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f k8s/argocd-app.yaml -n argocd

argocd app sync hello-world