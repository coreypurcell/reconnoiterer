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
  
  say('Chose a condtion to monitor')
  choose do |menu|
    menu.index
    menu.choice('Monitor Response Code') do
      url.set_condition(app)
    end
  end

  say("Running scouts")
  app.run(10)

end while agree("Continue?", true)


