eval $(docker-machine env docker-sandbox)
docker-compose -f docker-compose.yml stop
docker-machine stop docker-sandbox