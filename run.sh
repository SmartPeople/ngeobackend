docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker rm -v $(docker ps -a -q -f status=exited)
docker rmi $(docker images -f \"dangling=true\" -q)
docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes

docker-compose -f docker-compouse.yml build
docker-compose -f docker-compouse.yml up