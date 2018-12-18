FROM centos:6.10
LABEL maintainer Richard Scoop <richard.scoop@gmail.com>

RUN yum -y install wget yum-utils && \
  wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm && \
  wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm && \
  wget http://rpms.famillecollet.com/RPM-GPG-KEY-remi && \ 
  rpm --import RPM-GPG-KEY-remi && \
  rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm && \
  yum-config-manager --enable remi-php54 && \
  yum -y install httpd php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo && \
  sed -i 's/DirectoryIndex index.html index.html.var/DirectoryIndex index.php index.html index.html.var/' /etc/httpd/conf/httpd.conf && \
  sed -i 's/#ServerName www.example.com:80/ServerName demo:80/' /etc/httpd/conf/httpd.conf && \
  sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf && \
  sed -i 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' /etc/php.ini && \
  sed -i 's/display_errors = Off/display_errors = On/' /etc/php.ini && \
  sed -i 's/;date.timezone =/date.timezone = America\/Curacao/' /etc/php.ini

EXPOSE 80
ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-D", "FOREGROUND"]

