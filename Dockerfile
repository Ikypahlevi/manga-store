FROM tomcat:10

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT
RUN rm -rf /usr/local/tomcat/webapps/examples

# Add Jakarta JSTL jars
RUN curl -L -o /usr/local/tomcat/lib/jakarta.servlet.jsp.jstl-api-3.0.0.jar https://repo1.maven.org/maven2/jakarta/servlet/jsp/jstl/jakarta.servlet.jsp.jstl-api/3.0.0/jakarta.servlet.jsp.jstl-api-3.0.0.jar
RUN curl -L -o /usr/local/tomcat/lib/jakarta.servlet.jsp.jstl-3.0.1.jar https://repo1.maven.org/maven2/org/glassfish/web/jakarta.servlet.jsp.jstl/3.0.1/jakarta.servlet.jsp.jstl-3.0.1.jar

# Copy the pre-compiled web directory directly
COPY ./build/web /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
