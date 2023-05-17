FROM openjdk:11

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG JAR_FILE=build/libs/*.jar
ARG PYTHON_FILE=hello.py

COPY ${JAR_FILE} app.jar
COPY ${PYTHON_FILE} hello.py

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
