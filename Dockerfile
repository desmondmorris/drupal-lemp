FROM ubuntu
MAINTAINER Timani Tunduwani "timani27@gnail.com"

RUN export DEBIAN_FRONTEND=noninteractive

RUN apt-get -qqy update && locale-gen en_US.UTF-8
RUN apt-get -qqy install vim wget curl python-software-properties openssh-server git

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.0/ubuntu quantal main'

RUN add-apt-repository -y ppa:nginx/stable

RUN curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
RUN add-apt-repository 'deb http://repo.varnish-cache.org/ubuntu/ lucid varnish-3.0'

RUN apt-get -qqy update

# install nginx
RUN apt-get -qqy install nginx

# install php5
RUN apt-get -qqy install php5-fpm php5-mysql php5-gd php5-intl php5-imagick php5-mcrypt php5-curl php5-cli php5-xdebug

# Configure nginx for PHP websites
ADD ./nginx/nginx-default.conf /etc/nginx/sites-available/default
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
RUN mkdir -p /var/www && chown -R www-data:www-data /var/www

# Install mariadb
RUN apt-get -qqy install mariadb-server
RUN sed -i 's/^innodb_flush_method/#innodb_flush_method/' /etc/mysql/my.cnf

# Install redis
RUN apt-get -qqy install redis-server

# Install varnish
RUN apt-get -qqy install varnish libvarnish-dev

# Install solr
RUN apt-get -qqy install openjdk-6-jdk
RUN apt-get -qqy install solr-tomcat

# Install drush
RUN apt-get -qqy install drush

# Supervisord
RUN apt-get -qqy install python-setuptools
RUN easy_install supervisor
ADD ./supervisord.conf /etc/supervisord.conf

EXPOSE 80
EXPOSE 443

CMD supervisord -n -c /etc/supervisord.conf
