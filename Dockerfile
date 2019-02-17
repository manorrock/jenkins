FROM manorrock/openjdk:8u171
ENV JENKINS_VERSION 2.150.3
ENV JENKINS_HOME /mnt
RUN apt-get update && \
    apt-get install -y curl && \
    mkdir -p /opt/jenkins-${JENKINS_VERSION} && \
    cd /opt/jenkins-${JENKINS_VERSION} && \
    curl -fL -o /opt/jenkins-${JENKINS_VERSION}/jenkins.war https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/{$JENKINS_VERSION}/jenkins-war-{$JENKINS_VERSION}.war && \
    rm -rf /var/lib/apt/lists/*
WORKDIR ${JENKINS_HOME}
EXPOSE 8080 
CMD ["sh", "-c", "java -jar /opt/jenkins-${JENKINS_VERSION}/jenkins.war -Djava.awt.headless=true"]
