docker build -t desmonddocid/multi-client:latest -t desmonddocid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t desmonddocid/multi-server:latest -t desmonddocid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t desmonddocid/multi-worker:latest -t desmonddocid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push desmonddocid/multi-client:latest
docker push desmonddocid/multi-server:latest
docker push desmonddocid/multi-worker:latest

docker push desmonddocid/multi-client:$SHA
docker push desmonddocid/multi-server:$SHA
docker push desmonddocid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=desmonddocid/multi-client:$SHA
kubectl set image deployments/server-deployment server=desmonddocid/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=desmonddocid/multi-worker:$SHA
