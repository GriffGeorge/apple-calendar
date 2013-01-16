apple-calendar
==============

A script, written in Objective-C that allows command line access to Apple Calendar data.

Basically, it retreives the next 18 hours of events and spits them out to `stdout`. Not very useful in general, but in the code you will find a good example of how to access Apple Calendar data with Objective-C. Also, the Makefile contains an example of how to compile and run Objective-C without using XCode.

This was sort of a single use script. When my schedule opens up, I'll implement some of the Next Steps outlined below.

Usage
-----

Being on a Mac and having XCode installed are required. This script works on Mac OS X 10.8.2.

**First**, `git clone` into this repo. 

**Next:**

    $ make
    gcc -c -o build/main.o main.m
    gcc -o apple-calendar build/main.o -lobjc -framework Foundation -framework EventKit
     $

**Finally:**

     $ ./apple-calendar
    4:00 PM Info Retreival
    5:30 PM Digital Cartography
    7:00 PM CUSEC 2013 - uOttawa Delegation
    8:30 PM Digital Cartography
    8:00 AM Canadian University Software Engineering Conference 2013
    8:30 AM Real Time
     $ 

**Profit!**

Next Steps
----------

- create an option that allows the user to specify a specific span of time to display.
- create an option that allows the user to specify a specific number of hours in the future to display.
- create an option that allows the user to specify a date format.
- create an option that allows the user to specify a specific set of fields for each event.
