FROM ubuntu:latest

RUN sudo apt-get update && \
    sudo apt-get install wget \
                         default-jre -y
EXPOSE 4444 3000

RUN wget https://github.com/Saulis/Selenium-Grid-Extras/releases/download/1.3.4-HACKED/SeleniumGridExtras-1.3.4-SNAPSHOT-jar-with-dependencies.jar

COPY node_5555.json node_5555.json
COPY selenium_grid_extras_config.json selenium_grid_extras_config.json
RUN mkdir configs

ENTRYPOINT ["java", "-jar", "SeleniumGridExtras-1.3.4-SNAPSHOT-jar-with-dependencies.jar"]
