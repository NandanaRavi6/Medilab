# Use a base OS image
FROM ubuntu:20.04

# Update the package repository and install necessary tools
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the Java environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Download and install Apache Tomcat
RUN wget -q http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.69/bin/apache-tomcat-8.5.69.tar.gz -O /tmp/tomcat.tar.gz && \
    tar xf /tmp/tomcat.tar.gz -C /opt && \
    ln -s /opt/apache-tomcat-8.5.69 /opt/tomcat && \
    rm /tmp/tomcat.tar.gz

# Set environment variables for Tomcat
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

# Copy the sample application (replace 'sample.war' with your application's war file)
COPY *.war $CATALINA_HOME/webapps/medilab.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
