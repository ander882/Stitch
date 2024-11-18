# Stitch
A script to take a group of single image files and make rotating image matrices from them.

## Problem
Propresenter outputs a set of images (announcement slides) titled 1.jpg 2.jpg to n.jpg.  
But the mac mini in the corner wants triple wide images to display 3 images on three seperate announcement screens.  
What to do?  This script.  

./stitch.sh 3x1 input/ output/

Takes the, say 20, images from the input/ directory (from propresenter) and makes 20 triple wide images from them.  Each image has 3 pics in them like this:
* 1,2,3 
* 2,3,4 
* ...
* 18,19,20
* 19,20,1
* 20,1,2
  
So that these can be displayed, one by one and every image gets equal screen time...

now add in some otpions and other matrix sizes all wrapped within bashews skeleton, and you get this program!

```
$ ./stitch.sh -h
Program : stitch.sh  by ander882
Version : v1.1.0 (2024-11-18 12:39)
Purpose : Stitch together images
Usage   : stitch.sh [-h] [-Q] [-V] [-c] [-w] [-r] [-3] [-L <LOG_DIR>] <msize> <input_dir> <output_dir>
Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -Q|--QUIET       : [flag] no output [default: off]
    -V|--VERBOSE     : [flag] also show debug messages [default: off]
    -c|--cleanup     : [flag] clean the output folder first [default: off]
    -w|--wait        : [flag] check every 3 seconds for all images to load in first [default: off]
    -r|--reverse     : [flag] reverse the direction images move [default: off]
    -3|--timed       : [flag] Images less than 3 minutes old only [default: off]
    -L|--LOG_DIR <?> : [option] folder for log files   [default: /home/ander882/log/stitch]
    <msize>          : [parameter] matrix size of images.  ie [rows]x[cols]
    <input_dir>      : [parameter] input directory of images
    <output_dir>     : [parameter] output directory for stitched images

                                                                                             
### TIPS & EXAMPLES
* [cols]x[rows] mean the number of colums/rows in the stithed together image
  use «stitch 3x1» to make 3 horizontally stitched images ...
  use «stitch 1x3» to make 3 vertically stitched images ...
  from a 1x2 (vertical) or 2x1 (horizontal) up to a 5x5 can be created
* Any type of file can be contained in the input directory
  Only *.png *.jpg *.jpeg file are taken
  Even though images can have different height/width
  it is better when images have the same height/width
* Files named 1.jpg 2.jpg up to n.jpg will be overwritten!
  It may be better to use the -c option to clean out the entire output directory
* Images will normally rotate to the left and up
  use the -r option to have images rotate to the right and down

```

## What is it again?

This script is a wrapper for imagemagick's montage command.  More about this tool can be found at https://legacy.imagemagick.org/Usage/montage/

