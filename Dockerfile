# Creating image from CentOS 7
FROM centos:7

# Installing EPEL and updating 
RUN yum -y install epel-release yum-utils
RUN yum -y update

# Installing Supervisor
RUN yum -y install supervisor

# Installing cron daemon
RUN yum -y install cronie

# Installing OpenSSH server
RUN yum -y install openssh-server
EXPOSE 2222

# Setting up MariaDB repository and installing
# This command will install latest version
RUN curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | bash
RUN yum -y install MariaDB-server
EXPOSE 3306

# Setting up Apache
RUN yum -y install httpd
EXPOSE 80
EXPOSE 443

# Setting up PHP repository and installing
# Available versions are 54,55,56,70,71,72,73
RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum -y install \
    php71-php-fpm \
    php71-php-cli \
    php71-php-bcmath \
    php71-php-gd \
    php71-php-imap \
    php71-php-ioncube-loader \
    php71-php-json \
    php71-php-mbstring \
    php71-php-mysqlnd \
    php71-php-opcache \
    php71-php-pdo \
    php71-php-pear \
    php71-php-soap \
    php71-php-xml \
    php71-php-xmlrpc \
    php71-php-zip \
    php71-php-intl \
    php71-php-apc \
    php71-php-fileinfo 

# Installing Certbot
# RUN yum -y install \
#     certbot \
#     python2-certbot-apache \
#     python2-certbot-nginx \
#     python2-certbot-dns-cloudflare \
#     python2-certbot-dns-digitalocean \
#     python2-certbot-dns-linode \
#     python2-certbot-dns-rfc2136 \
#     python2-certbot-dns-google

# Installing Sendmail
RUN yum -y install \
    sendmail

# Installing GIT
RUN yum -y install \
    git

# Installing Composer
RUN curl https://getcomposer.org/installer | /usr/bin/php71 -- --filename=composer

# Copying configuration files
COPY ./mariadb.cnf /etc/my.cnf.d/mariadb.cnf
COPY ./apache.conf /etc/httpd/conf.d/apache.conf
COPY ./mysql.ini /etc/supervisord.d/mysql.ini
COPY ./apache.ini /etc/supervisord.d/apache.ini
COPY ./fpm.ini /etc/supervisord.d/fpm.ini
COPY ./ssh.ini /etc/supervisord.d/ssh.ini
COPY ./cron.ini /etc/supervisord.d/cron.ini
COPY ./runServices /root/runServices

# Setting working directory
WORKDIR /root

# Starting services
ENTRYPOINT [ "/usr/bin/python", "/root/runServices" ]
