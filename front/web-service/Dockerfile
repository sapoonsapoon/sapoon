FROM openjdk:8
COPY . /
RUN ./gradlew build
EXPOSE 8080

ENTRYPOINT ["java","-jar","/build/libs/web-service-0.0.1-SNAPSHOT.war"]