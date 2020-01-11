# Please choose from the following available PPAs:
 # * 'gnuradio':  GNU Radio PPA
 # * 'gnuradio-master':  GNU Radio - Master Builds
 # * 'gnuradio-releases':  GNU Radio Releases
 # * 'gnuradio-releases-3.7':  GNU Radio Releases - 3.7

docker build -t wei1234c/gnuradio:3.7 .  --build-arg version=-3.7 # --build-arg user_name=sdr_user  --build-arg workdir=/tmp/sdr
docker build -t wei1234c/gnuradio:3.8 .  --build-arg version=""    # --build-arg user_name=sdr_user  --build-arg workdir=/tmp/sdr