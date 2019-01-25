docker build -t rajukaju/multi-client:latest -t rajukaju/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rajukaju/multi-server:latest -t rajukaju/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t rajukaju/multi-worker:latest -t rajukaju/multi-worker:$SHA  -f ./worker/Dockerfile ./worker
docker push rajukaju/multi-client:latest
docker push rajukaju/multi-server:latest
docker push rajukaju/multi-worker:latest

docker push rajukaju/multi-client:$SHA
docker push rajukaju/multi-server:$SHA
docker push rajukaju/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rajukaju/multi-server:$SHA
kubectl set image deployments/client-deployment client=rajukaju/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rajukaju/multi-worker:$SHA