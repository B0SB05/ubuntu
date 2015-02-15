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

function penTester(){
	cd /etc/apt/
	echo deb http://fr.archive.ubuntu.com/ubuntu/ lucid-updates multiverse >> sources.list
	echo deb-src http://fr.archive.ubuntu.com/ubuntu/ lucid-updates multiverse >> sources.list
	echo deb http://archive.canonical.com/ubuntu lucid partner >> sources.list
	echo deb-src http://archive.canonical.com/ubuntu lucid partner >> sources.list
	apt-get update
	apt-get upgrade
	apt-get install build-essential libreadline-dev  libssl-dev libpq5 libpq-dev libreadline5 libsqlite3-dev libpcap-dev openjdk-7-jre subversion git-core autoconf postgresql pgadmin3 curl zlib1g-dev libxml2-dev libxslt1-dev vncviewer libyaml-dev ruby1.9.3
	gem install wirble sqlite3 bundler 
	# Building dircotry
	mkdir ~/Development
cd ~/Development

#Installing Wireshark 
apt-get install wireshark
dpkg-reconfigure wireshark-common

# Installing NMAP
svn co https://svn.nmap.org/nmap
cd nmap
./configure
make
make install
make clean
#Postgres Switch User 
su postgres
createuser msf -P -S -R -D
createdb -O msf msf
exit
exit
#Installing Metasploit-Framework
cd /opt
git clone https://github.com/rapid7/metasploit-framework.git
cd metasploit-framework
sudo bash -c 'for MSF in $(ls msf*); do ln -s /opt/metasploit-framework/$MSF /usr/local/bin/$MSF;done'
#Installing Armitage
curl -# -o /tmp/armitage.tgz http://www.fastandeasyhacking.com/download/armitage-latest.tgz
tar -xvzf /tmp/armitage.tgz -C /opt
ln -s /opt/armitage/armitage /usr/local/bin/armitage
ln -s /opt/armitage/teamserver /usr/local/bin/teamserver
echo java -jar /usr/local/share/armitage/armitage.jar \$\* > /usr/local/share/armitage/armitage
perl -pi -e 's/armitage.jar/\/usr\/local\/share\/armitage\/armitage.jar/g' /usr/local/share/armitage/teamserver
bundle install

# Installing Zap Proxy
wget http://zaproxy.googlecode.com/files/ZAP_1.2.0_Linux.tar.gz
mkdir -p /opt/zap/
tar xvzf ZAP_1.2.0_Linux.tar.gz -C /opt/zap/
ln -s /opt/zap/zap.sh /usr/local/bin/zap
}
function developer(){
#################################################
wget http://cisofy.com/files/lynis-1.6.3.tar.gz
 tar xvfvz lynis-1.6.3.tar.gz -C /opt
cd /opt/lynis-1.6.3/d /opt/lynis/
##################################################
apt-get install openssh-server 
apt-get install git
apt-get install apache2 
apt-get install mysql-server libapache2-mod-auth-mysql php5-mysql
apt-get install php5 libapache2-mod-php5 php5-mcrypt
apt-get install matplotlib
installme apache2 mysql-server libapache2-mod-auth-mysql php5-mysql  php5 libapache2-mod-php5 php5-mcrypt
installme virtualbox-guest-dkms
installme terminator
#########################################################################
wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3065_i386.deb
dpkg -i sublime-text_build-3065_i386.deb
 echo "alias edit='/opt/sublime_text/sublime_text'" >> "/home/"$(whoami)"/.bashrc"
 edit "/home/"$(whoami)"/.bashrc"
#
#########################################################################
installme openjdk-8-jdk openjdk-8-doc openjdk-8-demo openjdk-8-dbg openjdk-8-jre 
firefox http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/SR1/eclipse-jee-luna-SR1-linux-gtk.tar.gz&mirror_id=1090
}


rootme
penTester
