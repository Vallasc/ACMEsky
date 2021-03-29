FROM openjdk:15-jdk-alpine
ARG JAR_FILE=target/*.jar
RUN mkdir /list
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]