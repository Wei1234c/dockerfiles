# HackRF
sudo apt-get install -y gqrx-sdr 
sudo apt-get install -y libhackrf0 libhackrf-dev hackrf
sudo apt-get install -y gr-osmosdr 

# sudo apt-get install -y gr-fosphor gr-osmosdr qtbase5-dev libqwt-qt5-dev swig python-qwt-qt5




## build gr-osmosdr
## https://osmocom.org/projects/gr-osmosdr/wiki

# sudo apt-get purge -y gr-osmosdr 

# cd ~/Downloads
# rm -rf gr-osmosdr

# git clone git://git.osmocom.org/gr-osmosdr
# cd gr-osmosdr/

# mkdir build
# cd build/
# cmake ../

# make
# sudo make install
# sudo ldconfig

# cd build/
# cmake ../ -DENABLE_DOXYGEN=1
# make -C docs



# GNU Radio  *******************************************
# sudo apt-get purge -y gnuradio
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libcanberra-gtk-module 
sudo add-apt-repository ppa:gnuradio/gnuradio-releases-3.7  
# sudo add-apt-repository --remove ppa:gnuradio/gnuradio-releases-3.7   
# sudo add-apt-repository ppa:gnuradio/gnuradio-releases 
# sudo add-apt-repository --remove ppa:gnuradio/gnuradio-releases
sudo apt-get update 
sudo apt-get install -y gnuradio

# export LD_LIBRARY_PATH PYTHONPATH

