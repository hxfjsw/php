FROM centos:latest


RUN yum -y install wget gcc-c++ pcre-devel openssl openssl-devel python cmake gdb python-setuptools crontabs
RUN easy_install supervisor

RUN wget https://github.com/php/php-src/archive/PHP-7.0.zip
RUN yum -y install unzip
RUN unzip PHP-7.0.zip

WORKDIR /php-src-PHP-7.0
RUN yum -y install autoconf
RUN ./buildconf
RUN yum -y install bison
RUN yum -y install libxml2 libxml2-devel
RUN yum -y install libcurl libcurl-devel
RUN yum -y install openjpeg openjpeg-devel
RUN yum -y install libjpeg-devel
RUN yum -y install libpng-devel
RUN yum -y install freetype-devel
RUN yum -y install libicu-devel

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install libmcrypt libmcrypt-devel mcrypt mhash

RUN yum -y install libxslt-devel
RUN ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir=/usr/local/freetype --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --enable-intl --enable-pcntl --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-gettext --disable-fileinfo --enable-opcache --with-xsl
RUN make && make install
RUN make clean

RUN /usr/local/php/bin/pecl install redis
RUN /usr/local/php/bin/pecl install http://pecl.php.net/get/mongodb-1.2.2.tgz
RUN /usr/local/php/bin/pecl install swoole

COPY ./php-fpm.conf /usr/local/php/etc/php-fpm.conf


WORKDIR /work

CMD "/usr/local/php/sbin/php-fpm -RF"

EXPOSE 9000