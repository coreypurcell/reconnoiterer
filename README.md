Reconnoiterer
================

A simple command line application that wraps the [Outpost
gem](https://github.com/vinibaggio/outpost).

To run the code
    git clone https://github.com/coreypurcell/Reconnoiterer

    bundle install

    ruby bin/application.rb


Input a url that you would like to fetch.

    http://www.google.com

Select a condition to check

    1 # to check if the site returns a 200

Outpost will then check if the site is up


TODO

  * Have the app check multiple sites in the background
  * Have different conditons to check
    * Presence of a css selector on the site
    * Whether a css selector's html meets a condition (>, <, =)
  * Have different kinds of notifiers
    * Email
    * Growl
    * SMS

