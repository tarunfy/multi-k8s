docker build -t tarunfy/multi-client:latest -t tarunfy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tarunfy/multi-server:latest -t tarunfy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tarunfy/multi-worker:latest -t tarunfy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tarunfy/multi-client:latest
docker push tarunfy/multi-server:latest
docker push tarunfy/multi-worker:latest
docker push tarunfy/multi-client:$SHA
docker push tarunfy/multi-server:$SHA
docker push tarunfy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tarunfy/multi-server:$SHA
kubectl set image deployments/client-deployment client=tarunfy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tarunfy/multi-worker:$SHA