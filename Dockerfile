FROM jetty:11-jdk17

# Copy the WAR file into Jetty's webapps directory
COPY target/*.war /var/lib/jetty/webapps/root.war
