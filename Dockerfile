FROM ubuntu
MAINTAINER Desmond Morris "hi@desmondmorris.com"

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update && locale-gen en_US.UTF-8
RUN apt-get -qqy install vim wget curl python-software-properties openssh-server git

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.0/ubuntu quantal main'

RUN add-apt-repository -y ppa:nginx/stable

RUN curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -
RUN add-apt-repository 'deb http://repo.varnish-cache.org/ubuntu/ lucid varnish-3.0'

RUN apt-get -qqy update

# install nginx
RUN apt-get -qqy install nginx

# install php5
RUN apt-get -qqy install php5-fpm php5-mysql php5-gd php5-intl php5-imagick php5-mcrypt php5-curl php5-cli php5-xdebug

# Install mariadb
RUN apt-get -qqy install mariadb-server

# Install redis
RUN apt-get -qqy install redis-server

# Install varnish
RUN apt-get -qqy install varnish libvarnish-dev

# Install solr
RUN apt-get -qqy install openjdk-6-jdk
RUN apt-get -qqy install solr-tomcat

# Install drush
RUN apt-get -qqy install drush
