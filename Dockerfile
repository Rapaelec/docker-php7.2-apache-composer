FROM php:7.2.3-cli-stretch

# Install "curl", "libmemcached-dev", "libpq-dev", "libjpeg-dev",
#         "libpng12-dev", "libfreetype6-dev", "libssl-dev", "libmcrypt-dev",
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
#        libpng12-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev
#        libapache2-mod
#RUN apt-get install -y imagemagick graphicsmagick && \
#    libapache2-mod-php7.2 php7.2-bcmath php7.2-bz2 php7.2-cli php7.2-common php7.2-curl php7.2-dba php7.2-gd php7.2-gmp php7.2-imap php7.2-intl php7.2-ldap php7.2-mbstring php7.2-mysql php7.2-odbc php7.2-pgsql php7.2-recode php7.2-snmp php7.2-soap php7.2-sqlite php7.2-tidy php7.2-xml php7.2-xmlrpc php7.2-xsl php7.2-zip \
#   php-gnupg php-imagick php-mongodb php-streams php-fxsl \
#    sed -i -e 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php/7.2/apache2/php.ini && \
#    sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 256M/g' /etc/php/7.2/apache2/php.ini && \
#    sed -i -e 's/post_max_size = 8M/post_max_size = 512M/g' /etc/php/7.2/apache2/php.ini && \
#    sed -i -e 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.2/apache2/php.ini && \
#    sed -i -e 's/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/g' /etc/apache2/mods-available/dir.conf
# Install the PHP mcrypt extention
#RUN docker-php-ext-install mcrypt

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql


# Install the PHP gd library
RUN docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd
    
# Install Xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug
#COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Install ZIP
#RUN pecl install zip && docker-php-ext-enable zip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
