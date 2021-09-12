FROM tomcat:latest

MAINTAINER anchal

USER root

RUN useradd -ms /bin/bash jenkins

COPY target/java-tomcat-maven-example.war /usr/local/tomcat/webapps

USER jenkins


