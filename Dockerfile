FROM manorrock/zulu:arm32v6
RUN ["cross-build-start"]
ENV JENKINS_VERSION 2.176.3
ENV JENKINS_HOME /mnt
RUN apt-get update && \
    apt-get -y install curl libfreetype6 libfontconfig1 && \
    mkdir -p /usr/local/jenkins${JENKINS_VERSION} && \
    curl -fL -o /usr/local/jenkins${JENKINS_VERSION}/jenkins.war https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/{$JENKINS_VERSION}/jenkins-war-{$JENKINS_VERSION}.war
WORKDIR ${JENKINS_HOME}
EXPOSE 8080 
CMD ["sh", "-c", "java -Djava.awt.headless=true -jar /usr/local/jenkins${JENKINS_VERSION}/jenkins.war"]
RUN ["cross-build-end"]

