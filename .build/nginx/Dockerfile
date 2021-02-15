FROM nginx:alpine
RUN apk add --no-cache --virtual .build-deps \
  gcc \
  libc-dev \
  make \
  openssl-dev \
  pcre-dev \
  zlib-dev \
  linux-headers \
  curl \
  gnupg \
  libxslt-dev \
  gd-dev \
  geoip-dev \
  git \
  perl-dev \
  gd-dev

RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O /tmp/nginx.tar.gz
RUN mkdir -p /usr/src
RUN tar -zxC /usr/src -f /tmp/nginx.tar.gz && rm /tmp/nginx.tar.gz

# upload module
RUN git clone https://github.com/fdintino/nginx-upload-module.git /usr/src/nginx-$NGINX_VERSION/nginx-upload-module

RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
    cd /usr/src/nginx-$NGINX_VERSION && \
    ./configure --with-compat $CONFARGS \
     --add-dynamic-module=./nginx-upload-module
RUN cd /usr/src/nginx-$NGINX_VERSION && make && make install

COPY nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /etc/nginx/modules-enabled/
# install upload module
RUN mv /usr/src/nginx-$NGINX_VERSION/objs/ngx_http_upload_module.so /usr/lib/nginx/modules
RUN echo 'load_module /usr/lib/nginx/modules/ngx_http_upload_module.so;' | tee /etc/nginx/modules-enabled/http-upload.conf
