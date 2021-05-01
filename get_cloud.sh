#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`

read -p "Press ENTER to begin."

File="$1"

tput sgr0


Lines=$(cat $File)
for Line in $Lines
do
 
        echo "Collecting a snapshot of the cloud infrastructures for  $Line ..."

curl https://tls.bufferover.run/dns?q=.$Line |& tee -a /home/$File-cloud.out

#sleep 15m
done

echo ""
echo ""
echo "$(tput setaf 2)Cloud infrastructure enumeration COMPLETE!!"
echo ""
echo "See $(tput setaf 1)'/home/$File-cloud.out '$(tput setaf 2) for the output.  Clean the results using Bookmarks in Notepad++ or Excel"
echo ""
echo ""
tput sgr0
