eval $(docker-machine env docker-sandbox)

docker-compose -f docker-compose.yml build
docker-compose -f docker-compose.yml up