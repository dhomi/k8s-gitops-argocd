## maak de namespace en installeer de hele argocd erin
- ```kubectl create namespace argocd```
- ```kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml```
 
## wacht totdat ze running status hebben
- ```kubectl get po -n argocd -w```
- voeg de cluster van argocd aan docker toe: ```argocd cluster add docker-desktop -y```
## argocd admin password ophalen om in localhost:8080 te inloggen
- ```kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo ```
  - alternatief is argocd CLI in mac: ```brew install argocd```, en daarna: ```argocd admin initial-password -n argocd```

### poort opzetten in een terminal die je aan kan laten
- ```kubectl port-forward svc/argocd-server -n argocd 8080:443```
- ga naar http://localhost:8080 in browser om in te logge als admin met het opgehaalde password
  - je ziet nu de argocd ui en in Applications zie je nog niks. Daarom gaan we een app deployen

In argocd ui zie je nu de app staan, die op zijn beurt de nginx deployment en configmap deployt
- app deployen via argocd: ```kubectl apply -f argocd-app.yaml -n argocd```
- hiervan de poort forwarden: ```kubectl port-forward deployment/nginx-deployment 8081:80```
- check het in de browser: http://localhost:8081 en zie de ngnix-deployment draaien met de html uit de configmap
