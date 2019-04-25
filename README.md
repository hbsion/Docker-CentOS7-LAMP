# CentOS 7 LAMP v1.1
## Apache 2.4 * PHP 7.3 * PHP-FPM * MariaDB 10.3 * SSH
---
### Users
* web - Standard user without privileges. You should login into this account for the web site management. Home directory for this user is /home/web. In this folder you can find "public" folder, where you should place your application files.
* root - Standard root user from CentOS installation

The users password are automatically generated. Both users have the same password. You can find them in /root/runServices.log file.

### SSH
Password authentication is disabled\
The private and public keys are automatically generated.\
Public key authentication are enabled for "root" and "web" users.
* Private key location: /root/ssh-key
* Public key location: /root/ssh-key.pub
* Configuration directory: /etc/ssh
* Port: 2222/tcp

### Apache
* Document root: /home/web/public
* Configuration directory: /etc/httpd
* Port: 80/tcp, 443/tcp

### PHP
* Configuration directory: /etc/opt/remi/php73
* PHP-FPM pool "web" loopback port: 9000/tcp

### MariaDB
* Configuration directory: /etc/my.cnf.d
* Root user password: root user password
* Binding IP address: 127.0.0.1
* Port: 3306/tcp

### Additional software
* Git
* Composer
* Cron