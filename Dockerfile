FROM eclipse-temurin:17-jre
VOLUME /tmp
COPY target/devOpsDemo-0.0.1-SNAPSHOT.jar /app.jar
EXPOSE 2222
ENTRYPOINT ["java", "-jar", "/app.jar"]
