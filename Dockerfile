FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /cloud-gateway
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY src ./src
RUN mvn clean package -DskipTests

FROM openjdk:17
COPY --from=build /cloud-gateway/target/*.jar app.jar
EXPOSE 8761
ENTRYPOINT ["java", "-jar","app.jar"]