# Celery Worker Dockerfile
# 20151229
 
FROM wei1234c/python_armv7

MAINTAINER Wei Lin

ENV TERM linux

# Add user pi
RUN \
	useradd -G adm,sudo,users -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd

# Install Celery  ____________________________________________________________________________________________
RUN \
	pip3 install -U redis celery flower

    
WORKDIR /data

USER pi

EXPOSE 5555

CMD ["bash"]
