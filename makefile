
build:
	docker build --tag nginx-node-red:latest .

run:
	docker run -d -p 80:80 -v `pwd`/data/logs:/var/log \
        -v `pwd`/data/node-red:/var/www/data nginx-node-red:latest

