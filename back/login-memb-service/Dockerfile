FROM openjdk:7
COPY . /
RUN ./gradlew build
EXPOSE 8080

ENTRYPOINT ["java","-jar","/build/libs/login-memb-service-0.0.1-SNAPSHOT.jar"]