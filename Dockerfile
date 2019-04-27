FROM debian:stretch-slim

RUN true \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        unzip \
        python3 \
        python3-pip \
        python3-setuptools

RUN true \
    && wget https://github.com/grinya007/recomlive/archive/master.zip \
    && unzip master.zip \
    && cd recomlive-master \
    && pip3 install wheel \
    && pip3 install -r requirements.txt \
    && python3 -m unittest test.AllInOne.recommend

WORKDIR recomlive-master
ENTRYPOINT ["./watcher.sh", "./server.py", "start"]

