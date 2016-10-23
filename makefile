
build:
	docker build --tag node-red-auth:latest .

run:
	docker run -d -p 80:80 -v `pwd`/data/logs:/var/log \
        -v `pwd`/data/node-red:/var/www/data node-red-auth:latest

