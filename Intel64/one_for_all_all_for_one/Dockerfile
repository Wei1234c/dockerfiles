# one_for_all_all_for_one
# Celery Worker Dockerfile
# for Intel64
# 20160512
 
FROM celery

MAINTAINER Wei Lin

USER root

# Add user pi
RUN \
	useradd -G adm,sudo,users -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd


RUN apt-get update && \
    apt-get install -y python3-pandas

RUN	mkdir /celery_projects
	
WORKDIR /celery_projects

COPY . /celery_projects/
 
RUN	chmod +x /celery_projects/start_workers.sh

USER pi

CMD ["/bin/sh", "/celery_projects/start_workers.sh"]
