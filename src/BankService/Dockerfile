FROM maven:3.8.1-openjdk-15
EXPOSE 8080
COPY . ./
RUN mvn clean package
ENTRYPOINT ["java","-jar","target/BankService-0.0.1.jar"]

#FROM openjdk:15-jdk-alpine
#EXPOSE 8080
#ARG JAR_FILE=target/BankService-0.0.1.jar
#COPY ${JAR_FILE} app.jar
#COPY db /db
#ENTRYPOINT ["java","-jar","/app.jar"]
