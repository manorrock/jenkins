#
# Use Raspbian
#
FROM balenalib/raspberry-pi

#
# Setup for cross-platform building.
#
RUN ["cross-build-start"]

#
# Update Raspbian and install curl, fontconfig, fonts-dejavu and git.
#
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl fontconfig fonts-dejavu git && \
    rm -rf /var/lib/apt/lists/*

#
# Install Zulu 11.
#
RUN cd /usr/local && \
    curl --insecure -L -O https://cdn.azul.com/zulu-embedded/bin/zulu11.37.48-ca-jdk11.0.6-linux_aarch32hf.tar.gz && \
    tar xfvz zulu11.37.48-ca-jdk11.0.6-linux_aarch32hf.tar.gz && \
    mv zulu11.37.48-ca-jdk11.0.6-linux_aarch32hf jdk && \
    rm zulu11.37.48-ca-jdk11.0.6-linux_aarch32hf.tar.gz

#
# Setup PATH.
#
ENV PATH=$PATH:/usr/local/jdk/bin

#
# Set JENKINS_VERSION.
#
ENV JENKINS_VERSION 2.235.1

#
# Install Jenkins.
#
RUN mkdir -p /usr/local/jenkins && \
    curl --insecure -fL -o /usr/local/jenkins/jenkins.war \
    https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

#
# Set JENKINS_HOME.
#
ENV JENKINS_HOME /opt/jenkins

#
# Set work directory.
#
WORKDIR ${JENKINS_HOME}

#
# Expose port 8080.
#
EXPOSE 8080 

#
# End cross platform building.
#
RUN ["cross-build-end"]

#
# Start Jenkins in headless mode.
#
CMD ["sh", "-c", "java -Djava.awt.headless=true -jar /usr/local/jenkins/jenkins.war"]
