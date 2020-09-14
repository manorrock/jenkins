#
# Use Debian
#
FROM debian

#
# Update Debian and install curl, fontconfig, fonts-dejavu and git.
#
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl fontconfig fonts-dejavu git && \
    rm -rf /var/lib/apt/lists/*

#
# Install Zulu 11.
#
RUN cd /usr/local && \
    curl --insecure -L -O https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jdk_x64_linux_hotspot_11.0.8_10.tar.gz && \
    tar xfvz OpenJDK11U-jdk_x64_linux_hotspot_11.0.8_10.tar.gz && \
    mv jdk-11.0.8+10 jdk && \
    rm OpenJDK11U-jdk_x64_linux_hotspot_11.0.8_10.tar.gz

#
# Setup PATH.
#
ENV PATH=$PATH:/usr/local/jdk/bin

#
# Set JENKINS_VERSION.
#
ENV JENKINS_VERSION 2.235.5

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