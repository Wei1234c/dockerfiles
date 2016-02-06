# modified by: Wei Lin
# date: 2015/10/1

FROM	wei1234c/java_armv7

MAINTAINER	Wei Lin

ENV	TERM	linux 

USER	root


# Install Java _______________________________________________________________________________________________
# Define commonly used JAVA_HOME variable.
ENV	JAVA_HOME	/usr/lib/jvm/java-8-oracle
ENV	PATH		${PATH}:${JAVA_HOME}/bin


# Install SSH ________________________________________________________________________________________________
RUN \
	apt-get update && \
	apt-get install -y openssh-server && \
	mkdir /var/run/sshd

# root password and login permission / use user pi instead
# RUN echo 'root:raspberry' | chpasswd && \
  # sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Add user pi
RUN \
	useradd -G adm,sudo,users -s /bin/bash -m pi && \
	echo 'pi:raspberry' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN \
	sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose port 22
EXPOSE	22

# Define default command.
CMD	["/usr/sbin/sshd", "-D"]




# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*
