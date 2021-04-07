#!/bin/bash

echo "[*] Starting Install... [*]"
echo "[*] Upgrade installed packages to latest [*]"
echo -e "\nRunning a package upgrade...\n"
apt-get -qq update -y
wait
apt-get -qq dist-upgrade -y
wait
apt full-upgrade -y
wait
apt-get autoclean
wait


echo "[*] Installing packages [*]"

apt install -y python-pip
apt install -y python3-pip
#apt install -y golang-go
apt install -y nmap
apt install -y docker.io
apt install -y python3-virtualenv
apt install -y brutespray
apt install -y unzip
apt install -y ssmtp

pip install aiodnsbrute
pip install  setuptools
pip install  mmh3
pip install  colorama
pip install  bs4
pip install  requests
pip install shodan

pip3 install colored
pip3 install tldextract
pip3 install configparser
pip3 install unidecode
pip3 install texttable
pip3 install lockfile
pip3 install lxml
pip3 install dnspython


echo "[*] Initialize Shodan API Key..."

# shodan init <api key>


echo "[*] Create and Populate Recon Folder..."

mkdir /home/Recon
mkdir /home/Recon/inputs
mkdir /home/Recon/outputs
mkdir /home/Recon/Wordlists



echo "[*] Install Go..."

cd /home/Recon

wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.16.2.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
echo "export GOPATH=~/.go" >> ~/.profile
source ~/.profile



echo "[*] Install FFuf..."
git clone https://github.com/ffuf/ffuf
cd /home/Recon/ffuf
go get
go build

wget https://github.com/ffuf/ffuf-scripts/blob/master/ffuf_basicauth.sh
chmod +x ffuf_basicauth.sh
cp ffuf /usr/local/bin

cd /home/Recon

echo "[*] Add  DNS resolvers... [*]"

touch /home/Recon/resolvers.txt
echo 1.1.1.1 > /home/Recon/resolvers.txt
echo 1.0.0.1 >> /home/Recon/resolvers.txt
echo 208.67.222.222 >> /home/Recon/resolvers.txt
echo 208.67.220.220 >> /home/Recon/resolvers.txt
echo 9.9.9.9 >> /home/Recon/resolvers.txt
echo 149.112.112.112 >> /home/Recon/resolvers.txt
echo 8.26.56.26 >> /home/Recon/resolvers.txt
echo 8.20.247.20 >> /home/Recon/resolvers.txt
echo 64.6.64.6 >> /home/Recon/resolvers.txt
echo 64.6.65.6 >> /home/Recon/resolvers.txt



# echo nameserver 1.1.1.1 >> /etc/resolv.conf
# echo nameserver 1.0.0.1 >> /etc/resolv.conf
# echo nameserver 208.67.222.222 >> /etc/resolv.conf
# echo nameserver 208.67.220.220 >> /etc/resolv.conf
# echo nameserver 9.9.9.9 >> /etc/resolv.conf
# echo nameserver 149.112.112.112 >> /etc/resolv.conf
# echo nameserver 8.26.56.26 >> /etc/resolv.conf
# echo nameserver 8.20.247.20 >> /etc/resolv.conf
# echo nameserver 64.6.64.6 >> /etc/resolv.conf
# echo nameserver 64.6.65.6 >> /etc/resolv.conf


echo "[*] Copy Password and WordLists [*]"
cd /home/Recon/Wordlists
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
git clone https://github.com/fuzzdb-project/fuzzdb.git
wget https://gist.github.com/jhaddix/f64c97d0863a78454e44c2f7119c2a6a/raw/96f4e51d96b2203f19f6381c8c545b278eaa0837/all.txt
wget https://gist.github.com/jhaddix/b80ea67d85c13206125806f0828f4d10/raw/c81a34fe84731430741e0463eb6076129c20c4c0/content_discovery_all.txt
wget https://s3.amazonaws.com/assetnote-wordlists/data/manual/2m-subdomains.txt


echo "[*] Install Nuclei [*]"
mkdir /home/Recon/nuclei
cd /home/Recon/nuclei
#GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
wget https://github.com/projectdiscovery/nuclei/releases/download/v2.3.1/nuclei_2.3.1_linux_amd64.tar.gz
tar -xzvf nuclei*.tar.gz
./nuclei -update-templates
wait
echo "[*] install ShoSubGo [*]"

cd /home/Recon
git clone https://github.com/pownx/shosubgo.git

echo "[*] install EyeWitness [*]"

cd /home/Recon
git clone https://github.com/FortyNorthSecurity/EyeWitness.git
cd /home/Recon/EyeWitness/Python/setup
./setup.sh

echo "[*] install Sublist3r [*]"
cd /home/Recon
git clone https://github.com/aboul3la/Sublist3r.git

echo "[*] Install GitHub Search Scripts  [*]"
git clone https://github.com/gwen001/github-search



echo "[*] Install AMass  [*]"

wget https://github.com/OWASP/Amass/releases/download/v3.11.9/amass_linux_amd64.zip
unzip amass_linux_amd64.zip
rm /home/Recon/amass_linux_amd64.zip

echo "[*] Install HTTProbe  [*]"

go get -u github.com/tomnomnom/httprobe
cd /root/.go/bin
cp httprobe /usr/local/bin

echo "[*] Install DN MassScan  [*]"

cd /home/Recon
git clone https://github.com/rastating/dnmasscan.git


echo "[*] Install FavFreak  [*]"
git clone https://github.com/devanshbatham/FavFreak


echo "[*] Install Aquatone and Chromium Headless  [*]"

snap install chromium

cd /home/Recon
mkdir aquatone
cd aquatone
wget https://github.com/michenriksen/aquatone/releases/download/v1.7.0/aquatone_linux_amd64_1.7.0.zip
unzip aquatone_linux_amd64_1.7.0.zip
cp aquatone /usr/local/bin


echo "[*] Install masscan  [*]"
apt install masscan



echo "[*] Install FinDomain  [*]"

cd /home/Recon
mkdir findomain
cd findomain
wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux
chmod +x findomain-linux


cd /home/Recon


read -p "Enter your Shodan API key: " shodankey
shodan init $shodankey
touch /home/Recon/shosubgo/.tokens
echo $shodankey /home/Recon/shosubgo/.tokens
echo "Shodan key added to the tokens file in /home/Recon/shosubgo/.tokens"

touch /home/Recon/github-search/.tokens
read -p "Enter your GitHub API key: " githubkey

echo $githubkey > /home/Recon/github-search/.tokens

echo "GitHub key added to the tokens file in /home/Recon/github-search/.tokens"

cd /home/Recon


echo "************************** Setup Complete.  Restart now and then check DNS resolvers via /etc/resolv.conf **************************"