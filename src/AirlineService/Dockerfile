FROM openjdk:15-jdk-alpine
ARG JAR_FILE=target/*.jar
RUN mkdir /list
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]


#FROM maven:3.8.1-openjdk-15
#EXPOSE 8080
#COPY . ./s
#RUN mvn clean package
#ENTRYPOINT ["java","-jar","target/airlineService-0.0.1.jar"]

