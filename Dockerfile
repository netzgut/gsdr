FROM openjdk:8-jdk

LABEL maintainer="info@netzgut.net"

# The reports etc. should be easily usable by setting the correct uid/gid
ARG USERID=1000
ARG GROUPID=1000

RUN addgroup --system \
             --gid=$GROUPID \
             docker
RUN adduser --system \
            --uid=$USERID \
            --gid=$GROUPID \
            --shell /bin/bash docker

RUN apt-get update -qqy \
    && apt-get install -qqy --no-install-recommends \
        dumb-init \
        gnupg \
        wget \
        ca-certificates \
        apt-transport-https \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt-get clean \
    && apt-get purge

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update -qqy \
    && apt-get install -qqy --no-install-recommends \
        google-chrome-stable \
    && rm /etc/apt/sources.list.d/google-chrome.list \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/* \
    && apt-get clean \
    && apt-get purge


# Add the runner project and fix permissions
ADD runner /runner
RUN chown -R docker:docker /runner

# Switch to correct user and directory
USER docker
WORKDIR /runner

# Install gradle wrapper
RUN sh gradlew wrapper

CMD ["sh", "gradlew", "--info", "--stacktrace", "test"]


