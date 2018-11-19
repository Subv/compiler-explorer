FROM node:8

RUN apt-get update && apt-get install -y apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y build-essential yarn

COPY . /opt/compiler-explorer

WORKDIR /opt/compiler-explorer

RUN /opt/compiler-explorer/install_cuda.sh

RUN make prereqs EXTRA_ARGS='--language CUDA'

CMD ["make", "run", "EXTRA_ARGS='--language CUDA'"]