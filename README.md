heroku-prolog-buildpack
=======================

How hard can it be?

This is a very rough skeleton of a buildpack to enable SWI-Prolog-based applications to run on the Heroku service.

Currently you must put your code in a file called main.pl (yes, THAT rough), and your Procfile should launch a process ./splunge. (Yes, THAT rough!!)

I will shortly make this a lot less arbitrary, but first I wanted a proof of concept!
