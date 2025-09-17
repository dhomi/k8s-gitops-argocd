## maak de namespace en installeer de hele argocd erin
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
 
## wacht totdat ze running status hebben
kubectl get po -n argocd -w

## poort opzetten in een terminal die je aan kan laten
kubectl port-forward svc/argocd-server -n argocd 8080:443

## argocd admin password ophalen om in localhost:8080 te inloggen
argocd admin initial-password -n argocd

- alternatief is: 
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo 

## argoCD CLI 
- in mac: brew install argocd

### nog niet nodig maar: argocd openzetten
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

## cluster toevoegen om apps te deployen
argocd cluster add docker-desktop

16:29