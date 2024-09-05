#!/bin/bash

PASSED=$1
NEWDIR="TWide"


## Usage
usage() { 
echo "          Triple wide Script "
echo " "
echo "Usage: 3wide.sh [Directory] [Name]"
echo " " 

echo " This program will take a set of images in the supplied [Directory] and"
echo " make a set of 3 wide images off of those.  The images will be placed"
echo " in a '3Wide' directory if a [Name] is not supplied."
echo " "

echo " Example usages: "
echo "  3wide.sh ~/Desktop/00-Anouncements "
echo "    will take all images in that directory and make triple wide images"
echo "    in a ~/Desktop/00-Anouncements/3Wide directory"
echo "  3wide.sh ~/Desktop/00-Anouncements triple"
echo "    will take all images in that directory and make triple wide images"
echo "    in a ~/Desktop/00-Anouncements/triple directory"
exit 1
} 


## Check the paramaters
if [ $# -lt 1 ]
then
        usage

elif [ ! -e "$PASSED" ]
then
        echo "!! Directory does not exist!"
	echo "'" $PASSED "'"
	echo " "
        usage

elif [ ! -d "$PASSED" ]
then
       echo "!! Not a valid Directory"
       echo " "
       usage
fi

if [ $# -gt 2 ]
then
	echo "! Extra options ignored"
	echo " "
fi

if [ $# -gt 1 ]
then
	NEWDIR=$2
	# String's length check
	val=$(echo "${#NEWDIR}")
	if [ $val -gt 64 ];
	   then 
	   echo "!! [Name] is too long"
	   echo " "
	   usage
	fi

	# First character check
	key=$(echo $NEWDIR | cut -c1-1)
	if ! [[ $key =~ ^[0-9a-zA-Z]+$ ]]; 
	then
	    echo "!! [Name] does not start with a number or letter"
	    echo " "
	    usage
	fi

	# Is valid characters exist
	if ! [[ $key =~ ^[0-9a-zA-Z_-]+$ ]]
	then
	  echo '!! illegal characters in the [Name]. Only letters, numbers and -_'
	  echo " "
	  usage
	fi    
fi


## Exit here for testing
#echo "'a"
#echo $@
#Echo "'"
#echo " "
#
#echo "'1"
#echo $1
#echo "'"
#echo " "
#
#echo "'2"
#echo $2
#echo "'"
#usage
## Exit here for testing

#echo "Passed Now"
#echo $PASSED

## change the directory to the directory passed in
cd "$PASSED"


###############################################
###############################################
# New step 1:
# . go through the list
# . run the command
# . . convert 1.jpg -threshold 1% -format "%[mean]" info:
# . on each of the files.  If the return is <= 1888.18
# . remove it and all of the next files.
###############################################
###############################################

echo "Checking for the mostly black image..."


## get a list of all of the "JPG" files
declare -a arrPics
arrPics=($(ls -v *.jpg | sort -n))

NUM_ELEM=${#arrPics[@]}
# 0 through (N-1)

Delete=0

for ((i=0; i<NUM_ELEM && Delete==0; i++))
do

  #echo ${arrPics[i]} ${arrPics[j]} ${arrPics[k]}
  
  OUT=$( convert ${arrPics[i]} -threshold 1% -format "%[mean]" info: )
  echo -ne "\b\b$i"
  if [ ${OUT%%.*} -lt 20000 ]
  then 
    Delete=$i
  fi

  #if [ $Delete -ge 1 ]
  #then
    #echo ${arrPics[i]}  $OUT
    #rm ${arrPics[i]} 
  #fi

  if [ $i -eq $((NUM_ELEM-1)) ]
  then
    tmp=$NUM_ELEM
    arrPics=($(ls -v *.jpg | sort -n))
    NUM_ELEM=${#arrPics[@]}
    if [ $tmp -ne $NUM_ELEM ] 
    then
      echo ' ...'
      sleep 1
    fi
  fi

done

if [ $i -eq $NUM_ELEM ]
then
  Delete=$NUM_ELEM
fi

echo " images found"

###############################################
###############################################

echo "Creating the tripple wide images..."

## get a list of all of the "JPG" files
#declare -a arrPics
#arrPics=($(ls -v *.jpg | sort -n))

#NUM_ELEM=${#arrPics[@]}
NUM_ELEM=$Delete
# 0 through (N-1)

#echo $1

#Check to make sure there are enough files
if (( NUM_ELEM < 3 ))
then
  echo "!! There are not enough files to process!";
  echo " "
  usage
fi


## Create the new directory
# and remove all JPG files in there.  We will make more
mkdir -p $NEWDIR
rm -f $NEWDIR/*.jpg

## Start making the new 3Wide images

for ((i=0; i<NUM_ELEM; i++))
do
  echo -ne "\b\b$i"
  # i hold the reference to the first file
  # i will be the file name for the new 3 wide file
  # j holds the references to the second file
  let j=$i+1
  if((j >= NUM_ELEM)) 
  then 
    let j=$j-$NUM_ELEM 
  fi
  # k holds the references to the third file
  let k=$j+1
  if((k >= NUM_ELEM)) 
  then 
    let k=$k-$NUM_ELEM 
  fi

  #echo $i $j $k
  #echo ${arrPics[i]} ${arrPics[j]} ${arrPics[k]}


  #Lets go
  #echo "combining " ${arrPics[i]} ${arrPics[j]} ${arrPics[k]} " > " $NEWDIR/$i.jpg


  convert +append ${arrPics[i]} ${arrPics[j]} ${arrPics[k]} $NEWDIR/$i.jpg

done  

echo -ne "\b\b$i images made!"
echo ""

## Go ahead and remove the origional image files now.
#for ((i=0; i<NUM_ELEM; i++))
#do
#  rm ${arrPics[i]}
#done
