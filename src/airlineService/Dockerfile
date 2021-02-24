FROM openjdk:15-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
COPY fileSampleOffers /flights.json  
COPY db /db
ENTRYPOINT ["java","-jar","/app.jar"]