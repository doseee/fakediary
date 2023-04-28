FROM openjdk:11

ENV JAVA_OPTS="-Duser.timezone=Asia/Seoul"

ARG JAR_FILE=build/libs/*.jar

COPY ${JAR_FILE} app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]