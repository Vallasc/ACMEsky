FROM openjdk:15-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/BankService-0.0.1.jar
COPY ${JAR_FILE} app.jar
COPY db /db
ENTRYPOINT ["java","-jar","/app.jar"]