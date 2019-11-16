#!/bin/bash

uas="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36 OPR/56.0.3051.36"

helloPT="`wget -q -U "$uas" https://www.islamicfinder.org/  -O - | sed -n 's/.*<span class="todayPrayerTime">\([^<]*\).*/\1/p'`" 

helloPT2=`echo "$helloPT" | sed 's/$/ |/'`

#echo "$helloPT"

helloN="`wget -q -U "$uas" https://www.islamicfinder.org/ -O - | sed -n 's/underlined clickable">\([^<]*\).*/\1/p'`"

helloN2=`echo "$helloN" | awk '{print $2}'| sed 's/^/| /'`

Current1="`wget -q -U "$uas" https://www.islamicfinder.org/  -O - | sed -n 's/<span class="xxl uppercase prayer-margin-right">\([^<]*\).*/\1/p'`"

Current2="`wget -q -U "$uas" https://www.islamicfinder.org/  -O - | sed -n 's/<span id="current-city" class="text-lightest m-r-xs">\([^"<]*\).*/\1/p'`"

echo ""

Date2="`wget -q -U "$uas" https://www.islamicfinder.org/  -O - | sed -n 's/<p id="hijri-date" class="xs medium bold">\([^"<]*\).*/\1/p'`"

Date1="`wget -q -U "$uas" https://www.islamicfinder.org/  -O - | sed -n 's/<p id="greg-date" class="text-lightest xs">\([^"<]*\).*/\1/p'`"

Nexto=`wget -q -U "$uas" https://www.islamicfinder.org/  -O - | awk '$1=$1' | grep -A1 --after-context=02 clockdiv | grep : | rev | cut -c7- | rev`




#Date2=<p id="hijri-date" class="xs medium bold">
#Date1=<p id="greg-date" class="text-lightest xs">


echo Prayer Times in: 
echo $Current2
echo ""

Date1F=${Date1//&nbsp;/ }
Date2F=${Date2//&nbsp;/ }

echo Date:
echo $Date1F
echo $Date2F

echo ""

echo -e "\e[7m                                   "
echo "                                   "

tput cuu1
tput cuu1

echo -e "\e[7mUpcoming Prayer:                   "
echo -ne "  "
echo -ne $Current1"       coming  in  $Nexto"

echo -e "\e[27m"

echo "+---------------------------------+"
pr -t -m -w 50 <(echo "$helloN2") <(echo "$helloPT2")
echo "+---------------------------------+"

echo ""
