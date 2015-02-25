FROM ubuntu

RUN apt-get -y update

# Install serf
RUN apt-get install -y unzip wget
RUN wget --no-check-certificat https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip -O serf.zip
RUN unzip serf.zip
RUN chmod +x serf
RUN mv serf /usr/bin/serf

# Install nginx
RUN apt-get -y install nginx

# Install supervisor
RUN apt-get -y install supervisor

# Supervisord config
ADD supervisord-nginx.conf /etc/supervisor/conf.d/supervisord-nginx.conf

# Default page
ADD index.html /usr/share/nginx/html/index.html

# Startup script (We need this to use environmetal variables with --link)
ADD start-serf.sh /start-serf.sh
RUN chmod 755 /start-serf.sh

EXPOSE 80
CMD ["supervisord", "-n"]
