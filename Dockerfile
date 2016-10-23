FROM ubuntu:xenial

RUN apt-get update &&\
  apt-get install -y nginx nodejs npm supervisor dnsmasq vim

RUN ln -s /usr/bin/nodejs /usr/bin/node; rm -f /etc/nginx/sites-enabled/default

RUN npm install --global node-red node-red-dashboard

COPY ./hier /

RUN /bin/chown -R www-data /var/www/.node-red

CMD ["/usr/bin/supervisord","-nc","/etc/supervisor/supervisord.conf"]

EXPOSE 80
  
