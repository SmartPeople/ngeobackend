eval $(docker-machine env docker-sandbox)

docker exec -ti data-store bash -c 'pg_dump --username=postgres ngeodb' | gzip > ./backup_of_db/$(date +"%F-%H-%M-%S")-ngeodb.sql.gz