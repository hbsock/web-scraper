#!/bin/bash

# This script is used to change outputs to have 4 digits in their number output
# as shown in the below example.
#
# This was done because most file manager/browser programs I could find on Android
# did not support numeric sorting of files, so the order of the chapter files were
# all messed up.
#
# This script should be applied when the working directory is at the output directory with all the *.txt files inside.
#
# chapter-1.txt     =>  chapter-0001.txt
# chapter-10.txt    =>  chapter-0010.txt


rename -v -- 's/(\d+)/sprintf("%04d",$1)/e' *.txt
