# STEP 1: Use Maven to build the WAR
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy all files to container
COPY . .

# Build the WAR file
RUN mvn clean package -DskipTests

# STEP 2: Use Jetty to run the WAR
FROM eclipse-temurin:17-jdk
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*
RUN mkdir /opt/jetty
WORKDIR /opt/jetty

# Download Jetty and extract
RUN curl -O https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/11.0.15/jetty-distribution-11.0.15.tar.gz && \
    tar -xzf jetty-distribution-11.0.15.tar.gz --strip-components=1 && \
    rm jetty-distribution-11.0.15.tar.gz

# Copy the WAR file from the previous stage into Jetty’s webapps directory
COPY --from=build /app/target/*.war /opt/jetty/webapps/root.war

# Expose port
EXPOSE 8080

# Run Jetty
CMD ["java", "-jar", "start.jar"]
