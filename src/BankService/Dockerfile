FROM maven:3.8.1-openjdk-15
EXPOSE 8080
COPY . ./
RUN mvn clean package
ENTRYPOINT ["java","-jar","target/BankService-0.0.1.jar"]