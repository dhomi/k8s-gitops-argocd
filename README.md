## Namespace & argoCD
- ```kubectl create namespace argocd```
- ```kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml```
 
## Check status
-wacht tot status van pods is running: ```kubectl get po -n argocd -w```
- voeg de cluster van argocd aan docker toe: ```argocd cluster add docker-desktop -y```

## Login
- get admin password: ```kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo ```
  - alternatief is argocd CLI in mac: ```brew install argocd```, en daarna: ```argocd admin initial-password -n argocd```
- argocd service poort forwarden: ```kubectl port-forward svc/argocd-server -n argocd 8080:443```
- ga naar http://localhost:8080 in browser om in te logge als admin met het opgehaalde password

## Deploy APP
Je ziet nu de argoCD UI maar in Applications zie je nog niks. Hiervoor gaan we een app deployen
- app deployen via argocd: ```kubectl apply -f argocd-app.yaml -n argocd```
- hiervan de poort forwarden: ```kubectl port-forward deployment/nginx-deployment  -n argocd 8081:80```
- check het in de browser: http://localhost:8081 en zie de ngnix-deployment draaien met de html uit de configmap

## GitOps :)
We gaan nu een change doen in techlab/techlab.yaml en die pushen naar github.
- verander de versie in techlab/techlab.yaml (bv van 1.0.0 naar 1.0.1a) en commit + push naar github
- Zie dat het in ArgoCD de app is automatisch updated
- check de versie in shell: ```kubectl get deployment nginx-deployment -n argocd -o jsonpath="{.spec.template.spec.containers[?(@.name=='nginx')].env[?(@.name=='TAG')].value}"```


Handmatig kan ook:
- Redeploy het: ```kubectl rollout restart deployment/nginx-deployment -n argocd```
- Port forwarding herstarten: ```kubectl port-forward deployment/nginx-deployment  -n argocd 8081:80```
- check in de browser: http://localhost:8081 en zie de nieuwe html uit de configmap
