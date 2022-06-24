.PHONY: build
build:
	make service

.PHONY: service
api_server:
	go build -o bin/service -v ./cmd/service

.PHONY: remove_containers
remove_containers:
	-docker stop $$(docker ps -aq)
	-docker rm $$(docker ps -aq)

.PHONY: armageddon
armageddon:
	-make remove_containers
	-docker builder prune -f
	-docker network prune -f
	-docker volume rm $$(docker volume ls --filter dangling=true -q)
	-docker rmi $$(docker images -a -q) -f

.PHONY: test
test:
	go test ./...

.PHONY: init_db
init_db:
	sudo -u postgres psql -f scripts/postgresql/init_api_db.sql
	sudo -u postgres psql -f scripts/postgresql/init_auth_db.sql

.DEFAULT_GOAL := build