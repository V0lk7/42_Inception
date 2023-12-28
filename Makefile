BLACK		:= $(shell tput -Txterm setaf 0)
RED		:= $(shell tput -Txterm setaf 1)
GREEN		:= $(shell tput -Txterm setaf 2)
YELLOW		:= $(shell tput -Txterm setaf 3)
LIGHTPURPLE	:= $(shell tput -Txterm setaf 4)
PURPLE		:= $(shell tput -Txterm setaf 5)
BLUE		:= $(shell tput -Txterm setaf 6)
WHITE		:= $(shell tput -Txterm setaf 7)
RESET		:= $(shell tput -Txterm sgr0)

COMPOSE_FILE=./srcs/docker-compose.yml

all: up

envfile:
	@[ ! -e srcs/.env ] \
	&& cp ~/.env ./srcs/ \
	|| echo "$(GREEN)Envfile already in place. $(RESET)"
.PHONY:envfile

build_data:
	@echo "$(GREEN)Building directory for volumes ... $(RESET)"
	@[ ! -e ~/data/wordpress ] && mkdir -p ~/data/wordpress \
	|| echo "$(GREEN)Wordpress directory already in place. $(RESET)"
	@[ ! -e ~/data/mariadb ] && mkdir -p ~/data/mariadb \
	|| echo "$(GREEN)Mariadb directory already in place. $(RESET)"
.PHONY:build_data

up: envfile build_data 
	@echo "$(GREEN)Building containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) up -d --build
.PHONY:up

log:
	@echo "$(GREEN)Nginx logs... $(RESET)"
	docker logs nginx
	@echo "$(GREEN)Mariadb logs... $(RESET)"
	docker logs mariadb
	@echo "$(GREEN)Wordpress logs... $(RESET)"
	docker logs wordpress
.PHONY:log

stop:
	@echo "$(RED)Stopping containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) stop
.PHONY:stop

kill:
	@echo "$(RED)Stopping containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) kill
.PHONY:kill

start:
	@echo "$(RED)Starting containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) start
.PHONY:start

erase:	envfile
	@echo "$(RED)Stopping containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) down
	@echo "$(RED)Deleting all images ... $(RESET)"
	docker rmi -f `docker images -qa`
.PHONY:erase

clean: 	envfile erase
	@echo "$(RED)Deleting all data ... $(RESET)"
	docker volume rm `docker volume ls -q`
	sudo rm -rf /home/jduval/data/wordpress
	sudo rm -rf /home/jduval/data/mariadb
	rm -rf srcs/.env
.PHONY:clean
