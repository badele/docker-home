# docker-home
Using docker at home

```
export DOCKER_IP=$(docker info | grep -w 'Node Address' | awk '{print $3}')
```

# Configure docker in Remote API mode
Create file `/etc/systemd/system/docker.service.d/override.conf` with this content
```
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -s overlay2
```

# Public repo
git clone git@github.com:badele/docker-home.git
cd docker-home

# Private repo (overide configuration)
mkdir PRIVATE && cd PRIVATE
git clone git@github.com:badele/docker-home-private.git .
