@echo off

echo Hello there
echo -----------------
echo This script will pack multiple images into a 60 fps video using the ffmpeg command line tool.
echo To get started few conditions must be met:
echo 1 - this script file is inside the same folder as the frame images
echo 2 - ffmpeg.exe file is also inside this same folder
echo 3 - the frame images must be named frame*15digitZeroPaddedNumber*.png
echo If so you may continue, if not please close this window and correct these.

echo -----------------
pause
echo -----------------

echo You must now provide the first frame number. Do not include the leading zeroes!
echo This acts as a starting point, all png files with subsequent numbers will be loaded automatically
echo -----------------
set /p start="Enter frame: "

ffmpeg.exe -r 60 -f image2 -s 1920x1080 -start_number %start% -i frame%%015d.png -vcodec libx264 -crf 15 -pix_fmt yuv420p out.avi

echo -----------------
echo If no errors occured the folder now contains the video as out.avi file
echo -----------------

pause