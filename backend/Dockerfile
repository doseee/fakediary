FROM openjdk:11

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ARG TEMP_DIRECTORY=tmp_downloads
ARG JAR_FILE=build/libs/*.jar
ARG PYTHON_HELLO_FILE=hello.py
ARG PYTHON_CRAWLER_FILE=crawler.py
ARG REQUIREMENTS_FILE=requirements.txt

COPY ${TEMP_DIRECTORY} tmp_downloads
COPY ${JAR_FILE} app.jar
COPY ${PYTHON_HELLO_FILE} hello.py
COPY ${PYTHON_CRAWLER_FILE} crawler.py

# Python Dependencies Installation
RUN apt-get update && apt-get install -y python3-pip
COPY ${REQUIREMENTS_FILE} requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
