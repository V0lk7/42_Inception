
build:
	docker build -t mariadb .
rund:
	docker run -d -p 443:443 mariadb
runit:
	docker run -p 443:443 -it mariadb sh
kill:
	docker kill $(shell docker ps -aq)
erase:
	docker rm $(shell docker ps -aq)
