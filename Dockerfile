# Stage 1: Build the application using Ant
FROM eclipse-temurin:11-jdk-focal AS builder
RUN apt-get update && apt-get install -y ant
WORKDIR /app
COPY . .
# Clean and compile the project using Netbeans' ant build script
RUN ant clean build

# Stage 2: Deploy to Tomcat
FROM tomcat:9-jre11

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT
RUN rm -rf /usr/local/tomcat/webapps/examples

# Copy the compiled web directory from the builder stage
COPY --from=builder /app/build/web /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
