FROM node:8-stretch

RUN apt-get update && apt-get install -y apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y build-essential yarn

COPY install_cuda.sh /opt/compiler-explorer/install_cuda.sh

WORKDIR /opt/compiler-explorer

RUN /opt/compiler-explorer/install_cuda.sh

COPY glsl/ /opt/compiler-explorer/glsl

RUN make -j4 -C /opt/compiler-explorer/glsl

COPY . /opt/compiler-explorer

RUN make prereqs EXTRA_ARGS='--language CUDA'

RUN rm -Rf /opt/compiler-explorer/cuda/9.2.88/doc /opt/compiler-explorer/cuda/9.2.88/jre \
    /opt/compiler-explorer/cuda/9.2.88/libnsight /opt/compiler-explorer/cuda/9.2.88/libnvvp \
    /opt/compiler-explorer/cuda/9.2.88/nsightee_plugins \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnvgraph* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libcusolver* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libcufft* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libcusparse* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libcublas* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnppif* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libcurand* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnppig* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnppist* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnvrtc* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnppial* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnpps* \
    /opt/compiler-explorer/cuda/9.2.88/lib64/libnppidei*

RUN yarn cache clean

CMD ["node", "app.js", "--debug"]