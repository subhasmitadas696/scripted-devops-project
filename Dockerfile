FROM centos:7
RUN yum -y update
RUN yum install -y java
RUN yum install -y httpd
WORKDIR /var/www/html
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz /var/www/html
RUN tar -xvzf apache-tomcat-9.0.63.tar.gz
RUN mv apache-tomcat-9.0.63/* /var/www/html
EXPOSE 8080
CMD ["/var/www/html/bin/catalina.sh", "run"]
