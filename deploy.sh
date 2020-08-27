docker build -t danielguarise/multi-client:latest -t danielguarise/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielguarise/multi-server:latest -t danielguarise/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielguarise/multi-worker:latest -t danielguarise/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push danielguarise/multi-client:latest
docker push danielguarise/multi-server:latest
docker push danielguarise/multi-worker:latest
docker push danielguarise/multi-client:$SHA
docker push danielguarise/multi-server:$SHA
docker push danielguarise/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=danielguarise/multi-client:$SHA
kubectl set image deployments/server-deployment server=danielguarise/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=danielguarise/multi-worker:$SHA