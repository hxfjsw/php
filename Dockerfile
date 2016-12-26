#FROM centos:7
#
##RUN yum -y install epel-release
##RUN yum -y update
##RUN yum -y install wget gcc-c++ pcre-devel openssl openssl-devel python cmake gdb python-setuptools crontabs supervisor unzip autoconf libxslt-devel
##RUN yum -y install bison l libxml2 libxml2-devel libcurl libcurl-devel openjpeg openjpeg-devel libjpeg-devel libpng-devel freetype-devel libicu-devel l libmcrypt libmcrypt-devel mcrypt mhash
##
##
##RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
##RUN yum -y install php70w php70w-cli php70w-common php70w-mysql php70w-pdo php70w-xml php70w-pecl php70w-mbstring php70w-gd php70w-pecl-mongodb php70w-pecl-redis
##
###RUN wget https://github.com/php/php-src/archive/PHP-7.0.zip
###RUN unzip ./PHP-7.0.zip
##
###RUN wget -o php-7.0.14.tar.gz http://cn2.php.net/get/php-7.0.14.tar.gz/from/this/mirror
###RUN tar xf php-7.0.14.tar.gz
###RUN ls -l
###WORKDIR /php-src-PHP-7.0.14
##
###RUN wget -O php7.tar.gz http://cn2.php.net/get/php-7.0.14.tar.gz/from/this/mirror
###RUN tar -xvf php7.tar.gz
###
###WORKDIR  php-7.0.14
###RUN ./buildconf --force
###RUN ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir=/usr/local/freetype --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --enable-intl --enable-pcntl --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-gettext --disable-fileinfo --enable-opcache --with-xsl
###RUN make && make install
###RUN make clean
###
###RUN /usr/local/php/bin/pecl install redis
###RUN /usr/local/php/bin/pecl install http://pecl.php.net/get/mongodb-1.2.2.tgz
###RUN /usr/local/php/bin/pecl install swoole
###
###COPY ./php-fpm.conf /usr/local/php/etc/php-fpm.conf
##
##
##WORKDIR /work
##
###CMD "/usr/local/php/sbin/php-fpm -RF"
##
##EXPOSE 9000
#
#
#
## update yum
#RUN yum -y update --nogpgcheck; yum clean all  && yum -y install yum-utils && yum -y install epel-release --nogpgcheck && yum -y groupinstall "Development Tools" && yum -y install wget --nogpgcheck
##RUN yum -y install git --nogpgcheck
##RUN yum -y install vim --nogpgcheck
#
## install remi repo
#RUN wget http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
#RUN rpm -Uvh remi-release-7*.rpm
#RUN yum-config-manager --enable remi-php70
##RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
#
#RUN \
#	yum -y install \
#		php php-common  php-fpm\
#		php-mbstring \
#		php-mcrypt \
#		php-devel \
#		php-xml \
#		php-mysql php-mysqlnd \
#		php-pdo \
#		php-opcache --nogpgcheck \
#		php-bcmath \
#		php-pecl-memcached \
#		php-pecl-mysql \
#		php-pecl-xdebug \
#		php-pecl-zip \
#		php-pecl-amqp --nogpgcheck \
#        php-pecl-redis --nogpgcheck  \
#        php-pecl-mongodb --nogpgcheck \
#        php-pecl-swoole --nogpgcheck
#


FROM php:7-fpm-alpine

RUN apk add --no-cache --virtual .ext-deps \
        libjpeg-turbo-dev \
        libwebp-dev \
        libpng-dev \
        freetype-dev \
        libmcrypt-dev

RUN \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure opcache && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure gd \
    --with-jpeg-dir=/usr/include --with-png-dir=/usr/include --with-webp-dir=/usr/include --with-freetype-dir=/usr/include && \
    docker-php-ext-configure sockets && \
    docker-php-ext-configure mcrypt

RUN \
    apk add --no-cache --virtual .mongodb-ext-build-deps openssl-dev && \
    pecl install redis && \
    pecl install mongodb && \
    pecl clear-cache && \
    apk del .mongodb-ext-build-deps

RUN \
    docker-php-ext-install pdo_mysql opcache exif gd sockets mcrypt && \
    docker-php-ext-enable redis.so && \
    docker-php-ext-enable mongodb.so && \
    docker-php-source delete


