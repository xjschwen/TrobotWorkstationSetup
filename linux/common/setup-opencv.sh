#!/bin/bash
err_report() {
    echo "Error on line $1"
    exit 1
}

trap 'err_report $LINENO' ERR
#set -e

#http://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/

if [ -z $1 ] ; then
  if [ $USER = "pi" ] ; then
    sudo rpi-update
  fi

  #Step 1:  Make sure that we are upto date with the OS
  # these steps are in install general packages 
  # sudo apt-get -y update
  # sudo apt-get -y upgrade

  # Step 2 Install some general tools
  ./install_general_packages.sh

  sudo apt-get -yf install gstreamer1.0*
  # additional packages that are needed when starting from
  # the raspbian jessie minimal packages

  sudo apt-get -yf install libffi-dev
  sudo apt-get -yf install python-dev
  # lets stick withjust python 2.7
  # sudo apt-get -yf install python3-dev
  sudo apt-get -yf install libssl-dev
  sudo apt-get -yf install libxml2-dev
  sudo apt-get -yf install zlib1g-dev

  #Step 3: Image file format utilities
  sudo apt-get -yf install libjpeg8-dev libjasper-dev libpng12-dev
  # sudo apt-get -yf update
  # sudo apt-get -yf upgrade
   
  sudo apt-get -yf install libtiff5-dev
  

  # Step 4: Image display utilities
  sudo apt-get -yf install libgtk2.0-dev


  # Step 5: Image stream utilites  (Video stream readers)
  sudo apt-get -yf install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev

  #Step 6: Optomize it for various processors
  sudo apt-get -yf install libatlas-base-dev gfortran

  # clean some cruft from the package base
  sudo apt-get -yf autoremove

  #Step 7: Install PIP
  rm -Rf /tmp/get-pip.py
  wget https://bootstrap.pypa.io/get-pip.py  -P /tmp
  sudo python /tmp/get-pip.py


  #Step 8 use pip to install some useful packages
  sudo pip install virtualenv virtualenvwrapper
  #resolve a warning about https://urllib3.readthedocs.io/en/latest/user-guide.html#ssl-py2
  sudo pip install urllib3[secure]
  sudo rm -rf ~/.cache/pip

  touch ~/.bashrc
  cp -f ~/.bashrc ~/.bashrc.bak
  
  echo $USER
  ls -l ~/.bashrc
  cat ~/.bashrc | grep -v 'export WORKON_HOME=' | grep -v 'virtualenvwrapper.sh' | cat > /tmp/$USER.bashrc
  echo "export WORKON_HOME=$HOME/.virtualenvs" >> /tmp/$USER.bashrc
  echo "source /usr/local/bin/virtualenvwrapper.sh" >> /tmp/$USER.bashrc
  mv -f /tmp/$USER.bashrc ~/.bashrc

  # execute the new bash rc file
  source ~/.bashrc

  #Make the cv virtual environment
  mkvirtualenv cv
  #workon cv

  #Step 9  install python 2.7 and numpy
  sudo apt-get -yf install python2.7-dev

  sudo pip install --upgrade numpy
  sudo pip install --upgrade imutils

  # clear the apt-get cache to save some file system space
  sudo apt-get clean

fi
#Step 10 get opencv  and opencv_contrib from github

OPENCV_ROOT=~/opencv
OPENCV_VER="3.3.0"
if [ -d "$OPENCV_ROOT" ] ; then
  pushd "$OPENCV_ROOT"
  git fetch --all
  git checkout tags/${OPENCV_VER} -B "$OPENCV_VER"
  popd
else
  pushd ~
  git clone https://github.com/Itseez/opencv.git
  pushd  "$OPENCV_ROOT"
  git checkout tags/${OPENCV_VER} -B "$OPENCV_VER"
  popd
  popd
fi

# checkout the open cv contribs
OPENCV_CONTRIB_ROOT=~/opencv_contrib
if [ -d "$OPENCV_CONTRIB_ROOT" ] ; then
  pushd $OPENCV_CONTRIB_ROOT
  git fetch --all
  git checkout tags/${OPENCV_VER} -B "$OPENCV_VER"
  popd
else
  pushd ~
  git clone https://github.com/Itseez/opencv_contrib.git
  pushd $OPENCV_CONTRIB_ROOT
  git checkout tags/${OPENCV_VER} -B "$OPENCV_VER"
  popd
  popd
fi

#config the build scripts

cd $OPENCV_ROOT
export JAVA_HOME=${JAVA_HOME:-/opt/java/jdk1.8}
export PATH=$JAVA_HOME:$JAVA_HOME/bin:$PATH

mkdir -p $OPENCV_ROOT/build
cd $OPENCV_ROOT/build

#warning... spaces/tabs after the line continue will
#cause the command to fail with -D unknown command style of failure cmake D 

cmake CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/opt/opencv \
-D INSTALL_C_EXAMPLES=OFF \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_JAVA_EXAMPLES=ON \
-D BUILD_SHARED_LIBS=OFF \
-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
-D BUILD_EXAMPLES=OFF ..


# multi thread the compile process for speed
# use one thread per core on your server
cores=$(grep -c ^processor /proc/cpuinfo)
#
#
#compile using multi cores.
make -j${cores}

# install the open cv
sudo make install
sudo ldconfig


rm -f get-pip.py*


#soft link the open cv so module into python dirs
if [ -f /opt/opencv/lib/python2.7/dist-packages/cv2.so ] ; then
  if [ -d /usr/lib/python2.7/dist-packages/ ] ; then
    ln -sf /opt/opencv/lib/python2.7/dist-packages/cv2.so
  fi
fi

# todo: softlink the open cv so modules to Java


#rm -rf ~/opencv/build/bin
