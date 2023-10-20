
build:
	docker build -t nginx .
rund:
	docker run -d -p 443:443 nginx
runit:
	docker run -p 443:443 -it nginx sh
kill:
	docker kill $(shell docker ps -aq)
erased:
	docker rm $(shell docker ps -aq)
erasei:
	docker rmi $(shell docker images -aq)
