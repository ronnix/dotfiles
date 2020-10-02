if [ "$(uname -s)" == "Linux" ]; then
  wget https://www.thregr.org/~wavexx/software/screenkey/releases/screenkey-1.2.tar.gz
  tar xzf screenkey-1.2.tar.gz
  rm screenkey-1.2.tar.gz
  pushd screenkey-1.2/
  sudo apt-get install python3-gi gir1.2-gtk-3.0 python3-cairo python3-setuptools python3-distutils-extra fonts-font-awesome slop
  /usr/bin/python3 ./setup.py bdist_egg
  sudo /usr/bin/python3 ./setup.py install
  popd
  rm -rf screenkey-1.2
fi
