FROM ubuntu

RUN apt-get -y update

# Install serf
RUN apt-get install -y unzip wget
RUN wget --no-check-certificat https://dl.bintray.com/mitchellh/serf/0.6.4_linux_amd64.zip -O serf.zip
RUN unzip serf.zip
RUN chmod +x serf
RUN mv serf /usr/bin/serf

# Install HAProxy
RUN apt-get -y install haproxy
RUN sed -i -e 's/ENABLED=0/ENABLED=1/' /etc/default/haproxy

# Install supervisor
RUN apt-get -y install supervisor

# Add Handler
ADD default_haproxy.cfg /etc/haproxy/haproxy.cfg
ADD supervisord-haproxy.conf /etc/supervisor/conf.d/supervisord-haproxy.conf
ADD handler.sh /handler.sh

# Startup script (We need this to use environmetal variables with --link)
ADD start-serf.sh /start-serf.sh
RUN chmod 755 /start-serf.sh

EXPOSE 80
CMD ["supervisord", "-n"]
