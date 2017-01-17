# Install

Setup a 3 node docker swarm cluster

```bash
# ** NOTE: if you have Docker for Mac installed, you will need to open preferences and uninstall
# install the pre-release 1.13 docker toolbox
curl -L -O https://github.com/docker/toolbox/releases/download/v1.13.0-rc7/DockerToolbox-1.13.0-rc7.pkg
open DockerToolbox-1.13.0-rc7.pkg
rm DockerToolbox-1.13.0-rc7.pkg

# bootstrap the cluster
./script/swarm.sh

# should see three running machines
docker-machine ls

# configure OSX shell to use the master node as docker host
# can move this to .bash_profile to persist beyond this window
eval $(docker-machine env swarm1)

# should see three nodes in the swarm
docker node ls
```

Install dnsmasq and point *.localhost domains to the swarm cluster. Then run run [traefik](https://traefik.io) to proxy `service-name.docker.localhost` domains to the appropriate swarm service.

```bash
# setup dnsmasq
./script/dnsmasq.sh

# launch traefik
docker stack deploy -c stacks/traefik.yml traefik
open http://docker.localhost:8080/

# launch the swarm visualizer
docker stack deploy -c stacks/visualizer.yml visualizer
open http://visualizer_app.docker.localhost/
```



```bash
docker stack deploy -c stacks/jenkins.yml jenkins
open http://ci.docker.localhost/

docker ps
docker exec -it CONTAINER_ID cat /var/jenkins_home/secrets/initialAdminPassword
```
