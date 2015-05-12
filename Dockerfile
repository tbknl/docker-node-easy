FROM debian:wheezy
MAINTAINER Dave van Soest <Dave.Soest@gfk.com>

ENV NODE_VERSION=0.10.38

ADD http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz /opt/
RUN \
	    cd /opt ; \
	    tar xzf node-v${NODE_VERSION}-linux-x64.tar.gz && \
	    rm node-v${NODE_VERSION}-linux-x64.tar.gz
ENV PATH /opt/node-v${NODE_VERSION}-linux-x64/bin:$PATH

RUN apt-get update && apt-get install -y python build-essential && apt-get clean

ENV SRC_DIR /var/app/src
ENV MOD_DIR /var/app/modules
ENV NODE_PATH=${MOD_DIR}/node_modules
RUN mkdir -p ${SRC_DIR} ${MOD_DIR}/node_modules
WORKDIR ${MOD_DIR}

ONBUILD COPY package.json ./package.json
ONBUILD RUN npm install
ONBUILD WORKDIR ${SRC_DIR}

ENTRYPOINT ["node", "."]
