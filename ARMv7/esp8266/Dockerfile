# by: Wei Lin
# date: 2017/2/18
# ref:	https://github.com/pfalcon/esp-open-sdk
#	https://gist.github.com/hoihu/bebcb195287233b7c6ff477e235d2fc4 


FROM wei1234c/ubuntu_armv7:16.10

MAINTAINER Wei Lin

ENV TERM linux

# apt-get update && apt-get install -y make unrar-free autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial sed git unzip bash help2man wget bzip2
# useradd -G adm,sudo,users -s /bin/bash -m xtensa && echo 'xtensa:raspberry' | chpasswd
# cd /home/xtensa
# git clone --recursive https://github.com/pfalcon/esp-open-sdk.git 
# chmod 777 -R /home/xtensa/esp-open-sdk
# chown -R xtensa:xtensa /home/xtensa/esp-open-sdk/
# su xtensa
# cd /home/xtensa/esp-open-sdk
# make


# apt-get update && apt-get dist-upgrade -y && apt-get install -y make unrar-free autoconf automake libtool gcc g++ gperf flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial sed git unzip bash help2man wget bzip2
RUN 	apt-get update && apt-get dist-upgrade -y
RUN	apt-get install -y \
	make unrar-free autoconf automake libtool gcc g++ gperf \
	flex bison texinfo gawk ncurses-dev libexpat-dev python-dev python python-serial \
	sed git unzip bash help2man wget bzip2 libtool-bin 
	 

# export PATH=/usr/xpg4/bin:$PATH
# ENV PATH /usr/xpg4/bin:$PATH  


# Add user xtensa
# useradd -G adm,sudo,users -s /bin/bash -m xtensa && echo 'xtensa:raspberry' | chpasswd
RUN \
	useradd -G sudo,users -s /bin/bash -m xtensa && \
	echo 'xtensa:raspberry' | chpasswd


# # install GMP
# WORKDIR /home/xtensa
# RUN wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.lz
# RUN tar --lzip -xvf gmp-6.1.2.tar.lz
# WORKDIR /home/xtensa/gmp-6.1.2
# RUN ./configure
# RUN make install


# install ESP SDK 
WORKDIR /home/xtensa
RUN git clone --recursive https://github.com/pfalcon/esp-open-sdk.git 

RUN chmod 777 -R /home/xtensa/esp-open-sdk
RUN chown -R xtensa:xtensa /home/xtensa/esp-open-sdk/
ENV PATH /home/xtensa/esp-open-sdk/xtensa-lx106-elf/bin:$PATH 
# ENV PATH /home/xtensa/esp-open-sdk/xtensa-lx106-elf/bin:/home/xtensa/esp-open-sdk/crosstool-NG/.build/xtensa-lx106-elf/buildtools/bin:/home/xtensa/esp-open-sdk/crosstool-NG/.build/tools/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games/:/usr/xpg4/bin


USER xtensa
WORKDIR /home/xtensa/esp-open-sdk
RUN make STANDALONE=y

ENV PATH /home/xtensa/esp-open-sdk/xtensa-lx106-elf/bin:$PATH 



# Misc. ______________________________________________________________________________________________________

# Upgrade and clean up
RUN \
	apt-get dist-upgrade -y && \
	apt-get autoremove -y && \
	apt-get autoclean -y && \
	apt-get clean -y && \
	rm -rf /var/lib/apt/lists/*

# USER xtensa
RUN cd
