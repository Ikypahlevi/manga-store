FROM tomcat:10

# Remove default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/ROOT
RUN rm -rf /usr/local/tomcat/webapps/examples

# Copy the pre-compiled web directory directly
COPY ./build/web /usr/local/tomcat/webapps/ROOT

EXPOSE 8080
CMD ["catalina.sh", "run"]
