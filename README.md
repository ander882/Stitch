# Stitch
A script to take single image files and make rotating image matrices from them.

## Problem
Propresenter outputs a set of images (announcement slides) titled 1.jpg 2.jpg to n.jpg.  
But the mac mini in the corner needs 1 looong images to display on three seperate announcement screens.  
What to do?  This script.  

./stitch.sh 3x1 input/ output/

Takes the, say 20, images from the input directory (from propresenter) and makes 20 sets of images that have 3 pics in them like this:
* 1,2,3 
* 2,3,4 
* ...
* 18,19,20
* 19,20,1
* 20,1,2
  
So that these can be displayed, one by one and every image gets equal screen time...

now add in some otpions and other matrix sizes all wrapped within bashews skeleton, and you get this program!

'''
$ ./stitch.sh -h
Program : stitch.sh  by ander882
Version : v1.0.0 (2024-08-30 12:14)
Purpose : Stitch together images
Usage   : stitch.sh [-h] [-Q] [-V] [-c] [-r] [-L <LOG_DIR>] <msize> <input_dir> <output_dir>
Flags, options and parameters:
    -h|--help        : [flag] show usage [default: off]
    -Q|--QUIET       : [flag] no output [default: off]
    -V|--VERBOSE     : [flag] also show debug messages [default: off]
    -c|--cleanup     : [flag] clean the output folder first [default: off]
    -r|--reverse     : [flag] reverse the direction images move [default: off]
    -L|--LOG_DIR <?> : [option] folder for log files   [default: /home/ander882/log/stitch]
    <msize>          : [parameter] matrix size of images.  ie [rows]x[cols]
    <input_dir>      : [parameter] input directory of images/text
    <output_dir>     : [parameter] output directory for stitched images/text
                                                                                             
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

'''
