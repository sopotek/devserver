# Use Ubuntu as the base image
FROM ubuntu:latest



# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install necessary dependencies
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip default-jdk g++ xvfb curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Visual Studio Code (CLI version)
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
    install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings && \
    sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
    apt-get update -y && \
    apt-get install -y code && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# Download and install IntelliJ IDEA (CLI version)
RUN mkdir /opt/idea && \
    curl -L https://download.jetbrains.com/idea/ideaIC-2021.2.2.tar.gz | tar -xz --strip-components=1 -C /opt/idea

# Set up display for running GUI applications headlessly
ENV DISPLAY=:99

# Expose port 5000 for the Flask application
EXPOSE 5000

# Command to execute when the container starts
CMD Xvfb :99 -screen 0 1024x768x16 & code & /opt/idea/bin/idea.sh
