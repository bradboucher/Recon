#!/bin/bash
#fuzz for content enumeration


red=`tput setaf 1`
green=`tput setaf 2`


echo "$(tput setaf 1)Run in SCREEN to avoid interruptions!" 
echo ""
echo "screen -S 'fuzzjob'"
echo "Then run: ./just_fuzz.sh roots-and-subs.txt"
echo "CTRL+A then 'D' to detach from the screen session."
echo "To connect back into the session, run:  screen -r fuzzjob"

read -p "Press ENTER to begin."

File="$1"

tput sgr0


Lines=$(cat $File)
for Line in $Lines
do
 
        echo "Currently Using FFUF to perform content discovery on $Line ..."
        
	#ffuf -c -v -t 50 -fl 1 -recursion -recursion-depth 4 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/test.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File3
    #    ffuf -c -v -t 50 -p 0.5 -sf -maxtime 3400 -fl 1 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/custom-fuzzlist.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File.out
        ffuf -c -v -t 1000 -fl 1 -recursion -recursion-depth 4 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/all.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File.out
        #ffuf -c -v -t 50 -fl 1 -recursion -recursion-depth 4 -mc 200,201,202,203,204,206,207 -w /home/Recon/Wordlists/all.txt -u $Line/FUZZ |& tee -a /home/ffuf-outputs/$File3

#sleep 15m
done

echo ""
echo ""
echo "$(tput setaf 2)FFUF Fuzz COMPLETE!!"
echo ""
echo "See $(tput setaf 1)'/home/ffuf-outputs/'$(tput setaf 2) for the FFUF output.  Clean the results using Bookmarks in Notepad++"
echo ""
echo ""
tput sgr0