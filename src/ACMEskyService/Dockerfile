#FROM maven:3.8.1-jdk-11 AS build
#COPY . ./
#RUN mvn clean package


FROM camunda/camunda-bpm-platform:wildfly-7.15.0

EXPOSE 8080

ARG POSTGRES_DRIVER=driver/postgresql-42.2.19.jar
ARG WAR_FILE=target/acmesky-1.0.war

COPY ${POSTGRES_DRIVER} /camunda/standalone/deployments
#COPY --from=build ${WAR_FILE} /camunda/standalone/deployments
COPY ${WAR_FILE} /camunda/standalone/deployments

RUN rm -rf cd /camunda/standalone/deployments/camunda-example-invoice-7.15.0.war

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.9.0/wait /wait
USER root
RUN chmod +x /wait

USER camunda
CMD /wait && /camunda/camunda.sh