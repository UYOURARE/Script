#!/bin/bash

#
#Copyright 2016 , Nian
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#

#Set Variable

echo "开始配置系统环境......"
echo "(1/6)安装必要依赖包......"
#Install Package Which Google recommend
sudo apt-get update
sudo apt-get install -y git-core gnupg gcc-multilib g++-multilib \
flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev \
squashfs-tools build-essential zip curl libncurses5-dev \
zlib1g-dev openjdk-6-jre openjdk-6-jdk pngcrush schedtool \
libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool \
lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev openjdk-7-jdk \
zip unzip proxychains 

echo "(2/6)安装Repo 谢谢Mokee......"
if [ ! -d ~/bin ]; then
  mkdir -p ~/bin
fi
curl http://download.mokeedev.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo "(3/6)安装设备驱动......"
wget http://www.broodplank.net/51-android.rules
sudo mv -f 51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644 /etc/udev/rules.d/51-android.rules

echo "(4/6)安装谷歌SDK......"
wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64-20140702.zip
mkdir ~/adt-bundle
mv adt-bundle-linux-x86_64-20140702.zip ~/adt-bundle/adt_x64.zip
cd ~/adt-bundle
unzip adt_x64.zip
mv -f adt-bundle-linux-x86_64-20140702/* .
echo -e '\n# Android tools\nexport PATH=${PATH}:~/adt-bundle/sdk/tools\nexport PATH=${PATH}:~/adt-bundle/sdk/platform-tools\nexport PATH=${PATH}:~/bin' >> ~/.bashrc
echo -e '\nPATH="$HOME/adt-bundle/sdk/tools:$HOME/adt-bundle/sdk/platform-tools:$PATH"' >> ~/.profile

echo "(5/6)应用配置文件......"
source ~/.bashrc
source ~/.profile

echo "(6/6)清除系统垃圾......"
rm -Rf ~/adt-bundle/adt-bundle-linux-x86_64-20140702
rm -f ~/adt-bundle/adt_x64.zip

cd 
echo "完成系统环境配置......"
