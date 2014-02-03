#!/bin/sh

docker run -d -p 80:80 -v /data/www:/var/www desmondmorris/drupal-lemp
