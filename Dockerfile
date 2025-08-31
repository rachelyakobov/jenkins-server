FROM jenkins/jenkins:lts-jdk17

USER root

# Install Docker CLI and useful tools
RUN apt-get update && \
    apt-get install -y \
        docker.io \
        unzip \
        curl \
        groff \
        less \
        jq \
        python3 \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf awscliv2.zip aws

# Install Jenkins plugins from plugins.txt
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# Add Jenkins user to the docker group
RUN usermod -aG docker jenkins

USER jenkins

