FROM centos:latest

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install wget gcc-c++ pcre-devel openssl openssl-devel python cmake gdb python-setuptools crontabs supervisor unzip autoconf libxslt-devel
RUN yum -y install bison l libxml2 libxml2-devel libcurl libcurl-devel openjpeg openjpeg-devel libjpeg-devel libpng-devel freetype-devel libicu-devel l libmcrypt libmcrypt-devel mcrypt mhash


RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm

RUN yum -y install php70w php70w-cli php70w-common php70w-mysql php70w-pdo php70w-xml php70w-pecl php70w-mbstring php70w-gd php70w-pecl-mongodb php70w-pecl-redis

#RUN wget https://github.com/php/php-src/archive/PHP-7.0.zip
#RUN unzip ./PHP-7.0.zip

#RUN wget -o php-7.0.14.tar.gz http://cn2.php.net/get/php-7.0.14.tar.gz/from/this/mirror
#RUN tar xf php-7.0.14.tar.gz
#RUN ls -l
#WORKDIR /php-src-PHP-7.0.14

#RUN wget -O php7.tar.gz http://cn2.php.net/get/php-7.0.14.tar.gz/from/this/mirror
#RUN tar -xvf php7.tar.gz
#
#WORKDIR  php-7.0.14
#RUN ./buildconf --force
#RUN ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --with-fpm-user=www --with-fpm-group=www --enable-mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-iconv-dir --with-freetype-dir=/usr/local/freetype --with-jpeg-dir --with-png-dir --with-zlib --with-libxml-dir=/usr --enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --enable-intl --enable-pcntl --with-mcrypt --enable-ftp --with-gd --enable-gd-native-ttf --with-openssl --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip --enable-soap --with-gettext --disable-fileinfo --enable-opcache --with-xsl
#RUN make && make install
#RUN make clean
#
#RUN /usr/local/php/bin/pecl install redis
#RUN /usr/local/php/bin/pecl install http://pecl.php.net/get/mongodb-1.2.2.tgz
#RUN /usr/local/php/bin/pecl install swoole
#
#COPY ./php-fpm.conf /usr/local/php/etc/php-fpm.conf


WORKDIR /work

#CMD "/usr/local/php/sbin/php-fpm -RF"

EXPOSE 9000