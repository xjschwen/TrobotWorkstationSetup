#!/bin/bash
#set -e

#http://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/

#add a g streamer project to support video streaming
sudo add-apt-repository -y ppa:gstreamer-developers/ppa
sudo apt-get -y update 
sudo apt-get -y install gstreamer1.0

#Step 1:  Make sure that we are upto date with the OS
sudo apt-get -y update
sudo apt-get -y upgrade

#Step 2: First round of developer tools
sudo apt-get -y install build-essential cmake git pkg-config 
sudo apt-get -y install vim


#Step 3: Image file format utilities
sudo apt-get -y install libjpeg8-dev libjasper-dev libpng12-dev

# libtiff4-dev not available on RPI
if [ "$USER" != "pi"] ; then
  sudo apt-get -y install libtiff4-dev
fi


#Step 4: Image display utilities
sudo apt-get -y install libgtk2.0-dev

#Step 5: Image stream utilites  (Video stream readers)
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev


#Step 6: Optomize it for various processors 
sudo apt-get -y install libatlas-base-dev gfortran


#Step 7: Install PIP
wget https://bootstrap.pypa.io/get-pip.py  -P /tmp 
sudo python /tmp/get-pip.py


#Step 8 use pip to install some useful packages
sudo pip install virtualenv virtualenvwrapper
sudo rm -rf ~/.cache/pip

# make a copy of the .bashrc file
cp -f ~/.bashrc ~/.bashrc.bak
cat ~/.bashrc | grep -v 'export WORKON_HOME=' | grep -v 'virtualenvwrapper.sh' > /tmp/$USER.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> /tmp/$USER.bashrc
echo "source /usr/local/bin/virtualenvwrapper.sh" >> /tmp/$USER.bashrc
mv -f /tmp/$USER.bashrc ~/.bashrc

# execute the new bash rc file
source ~/.bashrc

sudo pip install --upgrade numpy
sudo pip install --upgrade imutils


#Make the cv virtual environment
mkvirtualenv cv
workon cv

#Step 9  install python 2.7 and numpy
sudo apt-get install python2.7-dev

pip install --upgrade numpy
pip install --upgrade imutils

# clear the apt-get cache to save some file system space
sudo apt-get clean

#Step 10 get opencv  and opencv_contrib from github

OPENCV_ROOT=~/opencv
OPENCV_VER="3.0.1"
if [ -d "$OPENCV_ROOT" ] ; then
  pushd "$OPENCV_ROOT"
  git fetch --all
  git checkout -B "$OPENCV_VER"
  git pull origin "$OPENCV_VER"
  popd
else
  pushd ~
  git clone https://github.com/Itseez/opencv.git
  pushd  "$OPENCV_ROOT"
  git checkout -B "$OPENCV_VER"
  popd
  popd
fi

# checkout the open cv contribs 
OPENCV_CONTRIB_ROOT=~/opencv_contrib
if [ -d "$OPENCV_CONTRIB_ROOT" ] ; then
  pushd $OPENCV_CONTRIB_ROOT
  git fetch --all
  git checkout -B "$OPENCV_VER"
  git pull origin "$OPENCV_VER"
  popd 
else
  pushd ~
  git clone https://github.com/Itseez/opencv_contrib.git
  pushd $OPENCV_CONTRIB_ROOT
  git checkout -B "$OPENCV_VER"
  popd
  popd
fi

#config the build scripts

cd $OPENCV_ROOT
export JAVA_HOME=/opt/java/jdk1.8
export PATH=$JAVA_HOME:$JAVA_HOME/bin:$PATH

mkdir -p $OPENCV_ROOT/build
cd $OPENCV_ROOT/build

#warning... spaces/tabs afte the line continue will 
#cause the command to fail with -D unknown command style of failures

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/opt/opencv \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_JAVA_EXAMPLES=ON \
-D BUILD_SHARED_LIBS=OFF \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D BUILD_EXAMPLES=ON ..
	
#
#  
#compile using 2 cores.
sudo time make -j2

# install the open cv
sudo make install
sudo ldconfig

rm -f get-pip.py*

