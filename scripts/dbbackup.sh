eval $(docker-machine env docker-sandbox)

docker exec -ti data-store pg_dump --username=postgres ngeodb > ngeodb.sql