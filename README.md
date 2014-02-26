Omnidirectional Camera Calibration Toolbox for Linux
==========

Executable Version of Omnidirectional Camera Calibration Toolbox


------
Description
------

This toolbox is the executable version of [Davide Scaramuzza's toolbox ](https://sites.google.com/site/scarabotix/ocamcalib-toolbox).

In Davide's toolbox, there is no split toolbox only for Linux but the version for windows is used with one compilable folder for corner finding binary file.

This executable version mainly

* Solve the problem of matlab path and OpenCV path conflicts in Linux
* Fix some small bugs in original codes
* Contain one run_script with no competitive clicking when using the original toolbox

-----
Installation and Implementation
-----
* [autoCornerFinder](https://github.com/GabriellaQiong/ocam_linux/tree/master/autoCornerFinder)

Please change the path in the  [Makefile]() to the one where installed OpenCV, e.g.

```
DEFINCS = -I/usr/local/include/opencv -I/usr/local/include/opencv2
DEFLIBS = -L/usr/local/lib
```

* [ocam_calib.m](https://raw.github.com/GabriellaQiong/ocam_linux/master/ocam_calib.m)

In this script, one startup was added to change the libraray environment to the right one. The code is shown below

```
original_path = getenv('LD_LIBRARY_PATH');
opencv_path   = '/usr/local/lib/';
new_path      = [opencv_path,':', original_path];
setenv('LD_LIBRARY_PATH', new_path);
```

Note here the OpenCV path *'/usr/local/lib/'* was put before the MATLAB build-in paths so as to use the right OpenCV libraries.

-----
Update Information
-----
The orignal clicking version toolbox was tested on Ubuntu 12.04 Precise successfully(02/26/2014).

The easy implementation ***run_script*** is under progress...

-----
Resources
-----
Original Toolbox from Davide Scaramuzza: https://sites.google.com/site/scarabotix/ocamcalib-toolbox

-----
License
-----

Copyright (c) 2014 "GabriellaQiong" Qiong Wang
