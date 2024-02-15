From ubuntu
WORKDIR /yash
ADD https://downloads.apache.org/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz.sha512 /yash/tomcat
COPY student.war /yash/tomcat


