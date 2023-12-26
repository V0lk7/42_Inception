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

all: run

envfile:
	cp ~/.env ./srcs/

run: envfile 
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@mkdir -p /home/jduval/data/wordpress
	@mkdir -p /home/jduval/data/mariadb
	@echo "$(GREEN)Building containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) up --build

up: envfile
	@echo "$(GREEN)Building files for volumes ... $(RESET)"
	@mkdir -p /home/jduval/data/wordpress
	@mkdir -p /home/jduval/data/mariadb
	@echo "$(GREEN)Building containers in background ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) up -d --build

log:
	docker logs nginx
	docker logs mariadb
	docker logs wordpress

list:	
	@echo "$(PURPLE)Listing all containers ... $(RESET)"
	 docker ps -a

list_volumes:
	@echo "$(PURPLE)Listing volumes ... $(RESET)"
	docker volume ls
stop:
	@echo "$(RED)Stopping containers ... $(RESET)"
	@-docker compose -f $(COMPOSE_FILE) kill
start:
	@echo "$(RED)Starting containers ... $(RESET)"
	@-docker compose -f $(COMPOSE_FILE) start
erase:
	@echo "$(RED)Stopping containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) down
	@echo "$(RED)Deleting all images ... $(RESET)"
	-docker rmi -f `docker images -qa`
	@echo "$(RED)Deleting all volumes ... $(RESET)"
	-docker volume rm `docker volume ls -q`

clean: 	
	@echo "$(RED)Stopping containers ... $(RESET)"
	docker compose -f $(COMPOSE_FILE) down
	@echo "$(RED)Deleting all images ... $(RESET)"
	-docker rmi -f `docker images -qa`
	@echo "$(RED)Deleting all volumes ... $(RESET)"
	-docker volume rm `docker volume ls -q`
	@echo "$(RED)Deleting all data ... $(RESET)"
	@sudo rm -rf /home/jduval/data/wordpress
	@sudo rm -rf /home/jduval/data/mariadb
	@rm -rf srcs/.env
	@echo "$(RED)Deleting all $(RESET)"

.PHONY: envfile run up debug list list_volumes clean
