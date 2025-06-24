# ✅ STEP 1: Use Maven with Java 17 to build the WAR file
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app

# ✅ Copy your whole project
COPY . .

# ✅ Build WAR (skip tests for faster build)
RUN mvn clean package -DskipTests

# ✅ STEP 2: Jetty base image with Java 17
FROM jetty:11.0.15-jdk17

COPY --from=build /app/target/Attendance_Management_System-1.0-SNAPSHOT.war /var/lib/jetty/webapps/root.war

# ✅ Expose default Jetty port
EXPOSE 8080

# ✅ Start Jetty server using built-in launcher
CMD ["java", "-jar", "/usr/local/jetty/start.jar"]