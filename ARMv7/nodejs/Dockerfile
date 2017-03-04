# Node.js Dockerfile
# https://github.com/dockerfile/nodejs
#
# origin: https://github.com/dockerfile/nodejs
# modified by: Wei Lin
# date: 2015/9/3

FROM wei1234c/python_armv7

MAINTAINER Wei Lin

ENV TERM linux

# Install Node.js ____________________________________________________________________________________________
RUN apt-get update && \
    apt-get install -y wget && \
    cd /tmp && \
    wget http://nodejs.org/dist/node-latest.tar.gz && \
    tar xvzf node-latest.tar.gz && \
    rm -f node-latest.tar.gz && \
    cd node-v* && \
    ./configure && \
    CXX="g++ -Wno-unused-local-typedefs" make && \
    CXX="g++ -Wno-unused-local-typedefs" make install && \
    cd /tmp && \
    rm -rf /tmp/node-v* && \
    npm install -g npm && \
    printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc && \
    apt-get remove wget -y 
   
# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]



# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
     apt-get dist-upgrade -y && \
     apt-get autoremove -y && \
     apt-get autoclean -y && \
     apt-get clean -y && \
     rm -rf /var/lib/apt/lists/*
