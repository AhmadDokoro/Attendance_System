# ✅ STEP 1: Use Maven with Java 17 to build the WAR file
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# ✅ Copy all source files into the container
COPY . .

# ✅ Build the WAR file while skipping tests
RUN mvn clean package -DskipTests

# ✅ STEP 2: Use official Jetty image with Java 17
FROM jetty:11.0.15-jdk17

# ✅ Set working directory to Jetty's webapps folder
WORKDIR /var/lib/jetty/webapps/

# ✅ Copy the built WAR file from build stage into Jetty’s root app
COPY --from=build /app/target/*.war ./root.war

# ✅ Port exposure (Render uses 8080 by default)
EXPOSE 8080

# ✅ Run Jetty server (this was missing before!)
CMD ["java", "-jar", "/usr/local/jetty/start.jar"]