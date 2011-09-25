Reconnoiterer
================

A simple command line application that wraps the [Outpost
gem](https://github.com/vinibaggio/outpost).

This application allows you to monitor websites and alerts you to
certain conditions about the site, such as the response code return or
the body contains a certain string. It uses Growl to popup a
notification, so make sure you have Growl set to allow remote
application registration. Eventually I will switch to use the
tools as autotest-growl and allow popups to work with Windows and Linux.
Hopefully you can still test the app without growl on your system.

![Growl
Screen](http://dl.dropbox.com/u/262398/Screen%20Shot%202011-09-14%20at%203.20.07%20PM.png)

To run the code
    git clone https://github.com/coreypurcell/Reconnoiterer

    bundle install

    ruby bin/recon


Input a url that you would like to fetch.

    http://www.google.com

Select a condition to check

    1 # to check if the site returns a 200

Outpost will then check if the site is up


### SMS Notifications

Currently Reconnoiterer will use my Twilio account to send messages.
Feel free to use it for testing, but if you want to keep using the app
you must change it to use your account. Copy the twilio.yaml.example
file and set up your twilio account.

    twilio.yaml # twilio configuration file


