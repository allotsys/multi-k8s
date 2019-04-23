docker build -t allotsys/multi-client:latest -t allotsys/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t allotsys/multi-server:latest -t allotsys/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t allotsys/multi-worker:latest -t allotsys/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push allotsys/multi-client:latest
docker push allotsys/multi-server:latest
docker push allotsys/multi-worker:latest
docker push allotsys/multi-client:$SHA
docker push allotsys/multi-server:$SHA
docker push allotsys/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=allmyles/multi-server:$SHA
kubectl set image deployments/client-deployment client=allmyles/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=allmyles/multi-worker:$SHA