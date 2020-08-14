#
# Use AdoptOpenJDK 11
#
FROM adoptopenjdk:11-hotspot@sha256:cf09212dedb08a31fa01362d3f41e7f16c0beab82406cfaf3f88d9479fe4520f

#
# Set JENKINS_VERSION.
#
ENV JENKINS_VERSION 2.235.3

#
# Install Jenkins.
#
RUN mkdir -p /usr/local/jenkins && \
    curl --insecure -fL -o /usr/local/jenkins/jenkins.war \
    https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

#
# Set JENKINS_HOME.
#
ENV JENKINS_HOME /mnt

#
# Set work directory.
#
WORKDIR ${JENKINS_HOME}

#
# Expose port 8080.
#
EXPOSE 8080 

#
# Start Jenkins in headless mode.
#
CMD ["sh", "-c", "java -Djava.awt.headless=true -jar /usr/local/jenkins/jenkins.war"]
