FROM node:8-stretch

RUN apt-get update && apt-get install -y apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y build-essential yarn

COPY install_cuda.sh /opt/compiler-explorer/install_cuda.sh

WORKDIR /opt/compiler-explorer

RUN /opt/compiler-explorer/install_cuda.sh

COPY . /opt/compiler-explorer

RUN make -j4 -C /opt/compiler-explorer/glsl

RUN make prereqs EXTRA_ARGS='--language CUDA'

CMD ["node", "app.js", "--debug"]