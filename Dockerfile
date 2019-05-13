FROM manorrock/jdk:arm32v6
ENV JENKINS_VERSION 2.164.3
ENV JENKINS_HOME /mnt
RUN apt-get update && \
    apt-get -y install git && \
    curl -fL -o /opt/jenkins.war https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/{$JENKINS_VERSION}/jenkins-war-{$JENKINS_VERSION}.war
WORKDIR ${JENKINS_HOME}
EXPOSE 8080 
CMD ["sh", "-c", "java -jar /opt/jenkins.war"]
