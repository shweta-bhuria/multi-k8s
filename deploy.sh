docker build -t shwetabhuria/multi-client:latest -t shwetabhuria/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shwetabhuria/multi-server:latest -t shwetabhuria/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shwetabhuria/multi-worker:latest -t shwetabhuria/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push shwetabhuria/multi-client:latest
docker push shwetabhuria/multi-server:latest
docker push shwetabhuria/multi-worker:latest

docker push shwetabhuria/multi-client:$SHA
docker push shwetabhuria/multi-server:$SHA
docker push shwetabhuria/multi-worker:$SHA
kubectl apply-f k8s
kubectl set image deployments/server-deployment server=shwetabhuria/multi-server:$SHA
kubectl set image deployments/client-deployment client=shwetabhuria/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shwetabhuria/multi-worker:$SHA