docker-machine start docker-sandbox
eval $(docker-machine env docker-sandbox)

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

docker rm -v $(docker ps -a -q -f status=exited)
# docker rmi $(docker images -q)
docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes


docker-compose -f docker-compose.yml stop
docker-compose -f docker-compose.yml up --build -d

docker-machine ls