FROM ubuntu:14.04
ENV MONIT_VERSION 5.11
RUN apt-get update && apt-get install -y wget tar
RUN wget -O /tmp/monit-$MONIT_VERSION-linux-x64.tar.gz http://mmonit.com/monit/dist/binary/$MONIT_VERSION/monit-$MONIT_VERSION-linux-x64.tar.gz
RUN cd /tmp && tar -xzf /tmp/monit-$MONIT_VERSION-linux-x64.tar.gz && cp /tmp/monit-$MONIT_VERSION/bin/monit /usr/bin/monit
COPY ./monitrc /etc/monitrc
RUN chmod 0700 /etc/monitrc
COPY ./conf.d /etc/monit/conf.d

RUN apt-get install -y \
    build-essential \
    ca-certificates \
    gcc \
    git \
    libpq-dev \
    make \
    python-pip \
    python2.7 \
    python2.7-dev \
    ssh \
    && apt-get autoremove \
    && apt-get clean

RUN apt-get install -y python-pip

RUN mkdir scripts
COPY scripts /scripts
COPY script_wrapper /etc/init.d/

RUN chmod +x /etc/init.d/script_wrapper

RUN pip install -r /scripts/requirements.txt

EXPOSE 2812

#CMD python /scripts/main.py

CMD monit -I
