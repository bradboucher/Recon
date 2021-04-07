#!/bin/bash

read -p "Text file containing your ROOTS and SUBS (i.e. cnn-roots-subs.txt):  " File



echo "Currently HTTProbing $File  ..."
cat $File | httprobe | tee $File-httprobed.txt

File2=$File-httprobed.txt


Lines=$(cat $File2)
for Line in $Lines
do

        echo "Currently Using FFUF to perform content discovery on $Line ..."
        /home/Recon/ffuf/./ffuf -c -v -sf -fl 1 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt -u $Line/FUZZ >> $Line-ffufresults.txt

done

#cat /home/$project/*-results.txt | sort | uniq -u > /home/$project/combined.txt

echo "COMPLETE!!"