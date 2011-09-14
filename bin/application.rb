#!/usr/local/bin/ruby
#

require 'rubygems'

require 'highline/import'
require 'pp'

require_relative '../lib/reconnoiterer'


app = Reconnoiterer::App.new

begin
  u = ask("Enter a URL to monitor:")
  url = app.add_url(u)
  
  say("Choose a condtion to monitor")
  choose do |menu|
    menu.index
    menu.choice("Monitor Response Code") do
      url.response_code(200, app)
    end
    menu.choice("Response Regex Match") do
      regx = ask("Enter a regular expression (ex. .*Google):")
      url.response_body(Regexp.new(regx), app)
    end
  end
  app.add_notifier("") 
  say("Running scouts")
  app.run(10)

end while agree("Continue?", true)


