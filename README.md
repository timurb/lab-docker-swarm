# Docker Swarm

This is a lab project to check out Docker Swarm in Vagrant.

The overall intent is to get familiar with Docker Swarm and make the installation as automated as possible (not reached).

Use of [local caching Docker registry](https://github.com/timurb/lab-docker-registry) is also supported.

## Notes on Docker and Docker Swarm

Docker CLI supplies 2 CLIs in a single binary:
* Docker operates with containers and images, all well-known commands apply:
  * `docker ps`, etc
* Docker Swarm operates with services (see ["services" section](https://docs.docker.com/compose/compose-file/compose-file-v3/#service-configuration-reference) in docker-compose). Those commands create docker-swarm objects to manage which in turn then create "classic" docker containers:
  * Node management: `docker node ls`
  * Service management: `docker service ls` 


## Requirements
- Vagrant 2.2.19
- [DirEnv](https://direnv.net/) installed and working

## Usage
1. Spin up boxes and init docker contexts:
```
vagrant up
./init-contexts.sh
```

From now on you can run docker commands on both nodes from you laptop like this:
```
docker -c v0 ps  # run docker command on master node
docker -c v1 ps  # run docker command on slave node
```

2. Connect slave node to Docker Swarm cluster:

Watch out for the line like the following in output logs and copy it to clipboard:
```
docker swarm join --token SWMTKN-1-4r6vu7btisznoix70qnums6sxsmln2lyq4m2kit6ldyk5jriyl-9xnh01wucggwqy8tninu9a90m 10.0.0.10:2377
```

Add `-c v1` to the above line and run it from your laptop:
```
docker -c v0 node list
docker -c v1 swarm join --token SWMTKN-1-4r6vu7btisznoix70qnums6sxsmln2lyq4m2kit6ldyk5jriyl-9xnh01wucggwqy8tninu9a90m 10.0.0.10:2377
docker -c v0 node list
```

3. Start some service on master node:
```
docker -c v0 service create --replicas 10 --name helloworld --placement-pref spread=node alpine ping docker.com
docker -c v0 service ls
docker -c v0 service ps helloworld
docker -c v0 node ps $(docker node ls -q)
docker -c v0 ps
docker -c v1 ps
```

## License and author
* License:: MIT
* Author:: Timur Batyrshin <timurb@hey.com>
