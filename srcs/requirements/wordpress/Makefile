
build:
	docker build -t wordpress .
rund:
	docker run -d -p 443:443 wordpress
runit:
	docker run -p 443:443 -it wordpress sh
kill:
	docker kill $(shell docker ps -aq)
erased:
	docker rm $(shell docker ps -aq)
erasei:
	docker rmi $(shell docker images -aq)
