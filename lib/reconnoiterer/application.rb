#!/usr/local/bin/ruby -w

require 'rubygems'
require 'highline/import'
require 'pp'

require 'lib/reconnoiterer'


app = Reconnoiterer.new

begin
  u = ask("Enter a URL to monitor:")
  url = app.add_url(u)
  url.set_condition(app)

  say("Running scouts")
  app.outpost.run
  pp app.outpost.messages

end while agree("Continue?", true)


