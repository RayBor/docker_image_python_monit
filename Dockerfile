FROM ubuntu:14.04
ENV MONIT_VERSION 5.11

RUN apt-get update && apt-get install -y wget \
    tar \
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

RUN wget -O /tmp/monit-$MONIT_VERSION-linux-x64.tar.gz http://mmonit.com/monit/dist/binary/$MONIT_VERSION/monit-$MONIT_VERSION-linux-x64.tar.gz
RUN cd /tmp && tar -xzf /tmp/monit-$MONIT_VERSION-linux-x64.tar.gz && cp /tmp/monit-$MONIT_VERSION/bin/monit /usr/bin/monit
COPY ./monitrc /etc/monitrc
RUN chmod 0700 /etc/monitrc
COPY ./conf.d /etc/monit/conf.d

ENV SCRIPT_NAME my_python_script

RUN mkdir scripts
COPY scripts /scripts
COPY script_wrapper /etc/init.d/$SCRIPT_NAME

RUN chmod +x /etc/init.d/$SCRIPT_NAME

RUN sed -i "s/SCRIPT_NAME/$SCRIPT_NAME/g" /etc/monit/conf.d/* /etc/init.d/$SCRIPT_NAME

RUN pip install -r /scripts/requirements.txt

EXPOSE 2812

CMD monit -I
