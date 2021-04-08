#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`


echo "$(tput setaf 1)Run in SCREEN to avoid interruptions!"
echo ""
echo "screen -S 'fuzzjob'"
echo "Then run: ./probe_and_fuzz.sh roots-and-subs.txt"
echo "CTRL+A then 'D' to detach from the screen session."
echo "To connect back into the session, run:  screen -r fuzzjob"

read -p "Press ENTER to begin."

File="$1"

tput sgr0


echo "Currently HTTProbing $File  ..."
cat $File | httprobe | tee $File-httprobed.out

File2=$File-httprobed.out
File3=$File-fuzzed.out


Lines=$(cat $File2)
for Line in $Lines
do

        echo "Currently Using FFUF to perform content discovery on $Line ..."

        #ffuf -c -v -t 50 -fl 1 -recursion -recursion-depth 4 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/test.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File3
        ffuf -c -v -t 50 -fl 1 -recursion -recursion-depth 4 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/content_discovery_all.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File3
        #ffuf -c -v -t 50 -fl 1 -recursion -recursion-depth 4 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/all.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File3
done

cp $File2 /home/httprobe-outputs
rm /home/*-httprobed.out

echo ""
echo ""
echo "$(tput setaf 2)HTTP Probe and FFUF Fuzz COMPLETE!!"
echo ""
echo "See $(tput setaf 1)'/home/httprobe-outputs/$File3'$(tput setaf 2) for the HTTP Probed URLs output."
echo "See $(tput setaf 1)'/home/ffuf-outputs/$File3'$(tput setaf 2) for the FFUF output.  Clean the results using Bookmarks in Notepad++"
echo ""
echo ""
tput sgr0
tput bel
