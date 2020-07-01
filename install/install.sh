#!/usr/bin/bash
# (SQLITE version, august 2015)
# RPirrigate GitHub ZIP downloaded and extracted inside folder MYDIR

if [ `whoami` != 'root' ]; then
	echo 'ERROR: You need to be root to run this script'
	echo "Ex: sudo $0"
	exit 1
fi
read -p 'Enter the installation path: ' INSTALLPATH
# 1 install needed packages
apt update && apt upgrade -yy
apt install lighttpd php-common php-cgi php php-pear php5-sqlite rpi.gpio sqlite3

# 2. enable php on lighttpd
lighttpd-enable-mod fastcgi
lighttpd-enable-mod fastcgi-php

# 3. create folderINSTALLPATH/rpirrigate 
mkdir -p INSTALLPATH/rpirrigate

#4. copy inside that folder the 3 needed folders
SOURCEDIR=`pwd`
cp -R SOURCEDIR/../data INSTALLPATH/rpirrigate
cp -R SOURCEDIR/../daemon INSTALLPAH/rpirrigate
cp -R SOURCEDIR/../web INSTALLPATH/rpirrigate

#5. give right permissions

chown -R www-data:www-data INSTALLPATH/rpirrigate
chmod -R 775 INSTALLPATH/rpirrigate

#6. create log files and give permissions

mkdir /var/log/rpirrigate
touch /var/log/rpirrigate/status.log
touch /var/log/rpirrigate/error.log
chown -R www-data:www-data /var/log/rpirrigate
chmod -R 775 /var/log/rpirrigate

#7. copy the logrotate file

cp SOURCEDIR/install/logrotate.erb /etc/logrotate.d/rpirrigate

#8. give permissions

chmod 755 /etc/logrotate.d/rpirrigate
chown root:root /etc/logrotate.d/rpirrigate

#9. download and unzip pigpio

#11. copy init files


cp MIADIR/install/init.d.erb /etc/init.d/rpirrigate


12. give permissions

chmod 755 /etc/init.d/rpirrigate
chown root:root /etc/init.d/rpirrigate

#13. (If you want / already have a webserver on port 80 ) : change lighttpd document root and port

# nano /etc/lighttpd/lighttpd.conf 

# server.port   = 80    →   server.port    = 667

# Edit the line

server.document-root = “/var/www”   →  server.document-root = “INSTALLPATH/rpirrigate/web”


14. Enable services

# insserv rpirrigate

15. Start services

# service rpirrigate start
# service lighttpd restart
