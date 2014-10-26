#!/bin/bash


## check Id is zero ## 
function rootme(){
me=$(id | cut -d"=" -f2 | cut -d"(" -f1)
if [ $me -ne 0 ];then
	echo "You must be root "
	sudo su
fi
}

function installme(){
args=("$@")
rootme
for i in $(seq 0 ${#});do
	apt-get install  ${args[$i]}
done
}


#################################################
#wget http://cisofy.com/files/lynis-1.6.3.tar.gz
# tar xvfvz lynis-1.6.3.tar.gz -C /opt
#cd /opt/lynis-1.6.3/d /opt/lynis/
##################################################
#apt-get install openssh-server 
#apt-get install git
#apt-get install apache2 
#apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
#apt-get install php5 libapache2-mod-php5 php5-mcrypt
#apt-get install matplotlib
#installme apache2 mysql-server libapache2-mod-auth-mysql php5-mysql  php5 libapache2-mod-php5 php5-mcrypt
#installme virtualbox-guest-dkms
#installme terminator
#########################################################################
#wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3065_i386.deb
#dpkg -i sublime-text_build-3065_i386.deb
# echo "alias edit='/opt/sublime_text/sublime_text'" >> "/home/"$(whoami)"/.bashrc"
# edit "/home/"$(whoami)"/.bashrc"
#
#########################################################################
#installme openjdk-8-jdk openjdk-8-doc openjdk-8-demo openjdk-8-dbg openjdk-8-jre 
#firefox http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/SR1/eclipse-jee-luna-SR1-linux-gtk.tar.gz&mirror_id=1090