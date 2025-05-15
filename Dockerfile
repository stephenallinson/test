# Updated by Stephen, because he rules
# Use the official Jenkins LTS image as a base
FROM jenkins/jenkins:lts

# Switch to root user to install additional dependencies
USER root

# Create SSH directory and set permissions
RUN mkdir -p /var/jenkins_home/.ssh && \
    chmod 700 /var/jenkins_home/.ssh

# Copy SSH keys and config
COPY bitbucket_itchy2 /var/jenkins_home/.ssh/bitbucket_itchy2
COPY bitbucket_itchy2.pub /var/jenkins_home/.ssh/bitbucket_itchy2.pub
COPY config /var/jenkins_home/.ssh/config

# Set correct permissions for SSH keys
RUN chown -R jenkins:jenkins /var/jenkins_home/.ssh && \
    chmod 644 /var/jenkins_home/.ssh/bitbucket_itchy2.pub && \
    chmod 600 /var/jenkins_home/.ssh/bitbucket_itchy2

# Install required packages
RUN apt-get update && apt-get install -y \
    sudo \
    iputils-ping \
    net-tools \
    git \
    curl \
    vim \
    && apt-get clean

USER jenkins

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]
