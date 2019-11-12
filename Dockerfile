FROM manorrock/openjdk
ENV JENKINS_VERSION 2.190.2
ENV JENKINS_HOME /mnt
RUN apt-get update && \
    apt-get install -y curl fontconfig fonts-dejavu git && \
    mkdir -p /usr/local/jenkins${JENKINS_VERSION} && \
    cd /usr/local/jenkins${JENKINS_VERSION} && \
    curl -fL -o /usr/local/jenkins${JENKINS_VERSION}/jenkins.war https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/{$JENKINS_VERSION}/jenkins-war-{$JENKINS_VERSION}.war && \
    rm -rf /var/lib/apt/lists/*
WORKDIR ${JENKINS_HOME}
EXPOSE 8080 
CMD ["sh", "-c", "java -Djava.awt.headless=true -jar /usr/local/jenkins${JENKINS_VERSION}/jenkins.war"]
