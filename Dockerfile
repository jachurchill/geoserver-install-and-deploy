FROM alpine:3.14

ARG TOMCAT_VERSION=9.0.68
ARG GEOSERVER_VERSION=2.21.2
ARG EXTRA_JAVA_OPTS="-Xms128m -Xmx756m"

ENV CATALINA_HOME=/opt/apache-tomcat-${TOMCAT_VERSION}
ENV GEOSERVER_VERSION=${GEOSERVER_VERSION}
ENV PATH $CATALINA_HOME/bin:$PATH
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk

ENV CATALINA_OPTS="$EXTRA_JAVA_OPTS \
    -Djava.awt.headless=true -server \
    -Dfile.encoding=UTF-8 \
    -Djavax.servlet.request.encoding=UTF-8 \
    -Djavax.servlet.response.encoding=UTF-8 \
    -D-XX:SoftRefLRUPolicyMSPerMB=36000 \
    -Xbootclasspath/a:$CATALINA_HOME/lib/marlin.jar \
    -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine \
    -Dorg.geotools.coverage.jaiext.enabled=true"


RUN apk add --no-cache unzip wget openjdk11-jre

WORKDIR /opt/
RUN wget -q https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.68/bin/apache-tomcat-9.0.68.tar.gz && \
    tar xf apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm apache-tomcat-${TOMCAT_VERSION}.tar.gz && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/webapps/ROOT && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/webapps/docs && \
    rm -rf /opt/apache-tomcat-${TOMCAT_VERSION}/webapps/examples

WORKDIR /tmp/
RUN wget -q -O /tmp/geoserver.zip https://sourceforge.net/projects/geoserver/files/GeoServer/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-war.zip && \
    unzip -q geoserver.zip geoserver.war -d $CATALINA_HOME/webapps 
RUN rm -rf /tmp/*

EXPOSE 8080
CMD [ "catalina.sh", "run" ]
