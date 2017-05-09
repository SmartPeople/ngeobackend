eval $(docker-machine env docker-sandbox)

docker exec -ti data-store pg_dump --username=postgres ngeodb > ./backup_of_db/$(date +"%F-%H-%M-%S")-ngeodb.sql