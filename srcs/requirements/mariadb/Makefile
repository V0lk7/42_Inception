
build:
	docker build -t mariadb .
rund:
	docker run -d -p 3306:3306 mariadb
runit:
	docker run -p 3306:3306 -it mariadb sh
kill:
	docker kill $(shell docker ps -aq)
erase:
	docker rm $(shell docker ps -aq)
	docker rmi $(shell docker images -aq)
