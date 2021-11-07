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
1. Spin up boxes:
```
vagrant up
```

Watch out for the line like the following in output logs and copy it to clipboard:
```
docker swarm join --token SWMTKN-1-4r6vu7btisznoix70qnums6sxsmln2lyq4m2kit6ldyk5jriyl-9xnh01wucggwqy8tninu9a90m 10.0.0.10:2377
```

2. Connect slave node to Docker Swarm cluster:
```
vagrant ssh slave
docker swarm join --token SWMTKN-1-4r6vu7btisznoix70qnums6sxsmln2lyq4m2kit6ldyk5jriyl-9xnh01wucggwqy8tninu9a90m 10.0.0.10:2377
^D
vagrant ssh master
vagrant node list
```

3. Start some service on master node:
```
vagrant ssh master
docker service create --replicas 10 --name helloworld --placement-pref spread=node alpine ping docker.com
docker service ls
docker service ps helloworld
docker node ps $(docker node ls -q)
docker ps
^D
vagrant ssh slave
docker ps
```

## License and author
* License:: MIT
* Author:: Timur Batyrshin <timurb@hey.com>
