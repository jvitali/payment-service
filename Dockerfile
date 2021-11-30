FROM maven:3.6-jdk-8-alpine AS builder
# ARG JAR_FILE
WORKDIR /app
COPY pom.xml .
RUN mvn -e -B dependency:resolve
COPY src ./src
# COPY ${JAR_FILE} app.jar
RUN mvn -e -B package

FROM openjdk:8-jre-alpine
COPY --from=builder /app/target/app.jar .
CMD java -jar /app.jar $APP_ARGS
