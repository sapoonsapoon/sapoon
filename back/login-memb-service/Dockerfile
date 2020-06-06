FROM openjdk:latest
COPY . /myapp
WORKDIR /myapp/build/libs
EXPOSE 8080

ENTRYPOINT ["java","-jar","login-memb-service-0.0.1-SNAPSHOT.jar"]