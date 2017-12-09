```
docker swarm init
export SWARM_TOKEN=$(docker swarm join-token -q worker)
export SWARM_MASTER=$(docker info | grep -w 'Node Address' | awk '{print $3}')

docker-compose up -d
for i in $(seq 3); do docker exec -ti swarmcluster_node-${i}_1 docker swarm join --token ${SWARM_TOKEN} ${SWARM_MASTER}:2377; done

docker run -it -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock dockersamples/visualizer
```
