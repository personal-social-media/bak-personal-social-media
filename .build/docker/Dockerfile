FROM ruby:2.7.2

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash

RUN apt-get update && \
  apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  libmagickwand-dev  \
  vim \
  bison \
  python-dev

# install chrome
RUN apt-get update && \
    apt-get install -y gconf-service libasound2 libatk1.0-0 libcairo2 libcups2 \
    libfontconfig1 libgdk-pixbuf2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libxss1 \
    fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

RUN npm install -g yarn

RUN apt-get install -y libvips libvips-dev libvips-tools libcurl4 libcurl3-gnutls libcurl4-openssl-dev

RUN npm install -g phantomjs-prebuilt-that-works --unsafe-perm

RUN mkdir -p /app
WORKDIR /app