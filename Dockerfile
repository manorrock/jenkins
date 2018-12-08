FROM manorrock/openjdk:8u171
ENV JENKINS_VERSION 2.150.1
ENV JENKINS_HOME /mnt
RUN zypper --non-interactive rr Java_Factory && \
    zypper --non-interactive refresh && \
    zypper --non-interactive install curl git dejavu-fonts && \
    curl -fL -o /opt/jenkins.war https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/{$JENKINS_VERSION}/jenkins-war-{$JENKINS_VERSION}.war && \
    zypper --non-interactive remove curl && \
    zypper --non-interactive clean -a
WORKDIR ${JENKINS_HOME}
EXPOSE 8080 
CMD ["sh", "-c", "java -jar /opt/jenkins.war -Djava.awt.headless=true"]
