# Author: David McFarlane
# Date: 2024-06-13
# Version: 1.0
# Description: Renames files in directory with a number appended to end of new file name.
# Will start incrementing from provided starting number.
# Will ignore files that already have the new name.
############################################################
# Help                                                     #
############################################################

Help()
{
   # Display Help
   echo "Renames files ending with provided extension to \"<newFileName>_[incrementedNumber].<extension>.\""
   echo
   echo "Syntax: rename.sh <newFileName> <extension> <startingNumber>"
   echo "Script will start incrementing from provided starting number, e.g., someFile.test => newFileName_01.test"
   echo "Will ignore files that already have the new name."
}

#main program
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      n) # Name
         name=$OPTARG;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done 

let -i x=$3
#assign default value to x

x=${x:=1}
FILENAME=$1

#assign default value to FILENAME
FILENAME=${FILENAME:=newFileName}

EXTENSION=$2
#assign default value to EXTENSION
EXTENSION=${EXTENSION:=ext}
for f in *.$2; 

do
    # skip files that already have the new name
    if [[ $f == $1* ]]; then
        continue
    fi

    a=""
    if [ $x -lt 10 ] 
    then 
        a="0$x"
       # echo $a
    else 
        a="$x"
      #  echo $a
    fi

    echo $a 
    x=$((x+1))
    mv -- "$f" "$1_$a.$2"
done
