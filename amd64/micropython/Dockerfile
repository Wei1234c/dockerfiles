# by: Wei Lin
# date: 2017/2/18  

FROM wei1234c/esp8266

MAINTAINER Wei Lin

ENV TERM linux

WORKDIR /home/xtensa
RUN git clone --recursive https://github.com/micropython/micropython.git 
WORKDIR /home/xtensa/micropython

# https://github.com/micropython/micropython/issues/2700
# RUN	sed -ie 's/irom0_0_seg :  org = 0x40209000, len = 0x87000/irom0_0_seg :  org = 0x40209000, len = 0x8C000/g' /home/xtensa/micropython/esp8266/esp8266.ld

