FROM openjdk:latest
COPY . /
RUN ./gradlew build
EXPOSE 8080

ENTRYPOINT ["java","-jar","/build/libs/weather-service-0.0.1-SNAPSHOT.jar"]