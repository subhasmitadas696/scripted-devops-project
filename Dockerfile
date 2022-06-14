FROM centos:7
MAINTAINER Zafar Khan
RUN yum install -y httpd \
	zip \
	unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page258/luxory.zip /var/www/html/
WORKDIR /var/www/html
RUN unzip luxory.zip
RUN cp -rvf luxory/* .
RUN rm -rf luxory luxory.zip	
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
