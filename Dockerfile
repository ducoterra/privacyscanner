# Pull base image
FROM python:latest
 
# Install chromium dependencies
RUN apt update && apt install -y python3-dev libx11-dev libx11-xcb-dev libxcomposite-dev libxcursor-dev libxdamage-dev libasound-dev libxss-dev libxi-dev libxtst-dev libxrandr-dev libgtk-3-dev libnss3-dev

# Setup working directory
WORKDIR /scanner

# Setup chromium
COPY chrome-linux ./chrome-linux

# install privacyscore
COPY privacyscanner ./privacyscanner
RUN pip install -e privacyscanner

RUN useradd -m -s /bin/bash scanner
WORKDIR /app
RUN chown -R scanner:scanner .
USER scanner
ENV PATH $PATH:/scanner/chrome-linux
RUN privacyscanner update_dependencies
CMD /bin/bash