#!/usr/local/bin/ruby
#

require 'rubygems'

require 'highline/import'
require 'pp'

require_relative '../lib/reconnoiterer'


app = Reconnoiterer.app

say("Reconnoiterer - Monitoring your site")
loop do
  say("What would you like to do?")
  choose do |menu|
    menu.index
    menu.choice("Add a site to monitor") do

      url = ask("Enter the site's URL") 
      url = app.add_url(url)

      say("Choose a condition to monitor")
      choose do |add_menu|
        add_menu.index
        add_menu.choice("Monitor Response Code") do
          url.response_code(200)
        end
        add_menu.choice("Response Body Regex Match") do
          regx = ask("Enter a regular expression (without the forward slashes)")
          url.response_body(Regexp.new(regx))
        end
      end

    end
    menu.choice("List monitored sites with statuses") do
      say("#{app.sites.map{|s| s.uri.host}.join(", ")}")
      app.run(10)
      say("#{app.outpost.messages}")
    end
    menu.choice("Remove a monitored site") do
      say("Select a site to remove")
      choose do |rm_menu|
        rm_menu.index
        app.sites.each do |site|
          rm_menu.choice("#{site.uri.host}") do 
            app.remove_site(site)
          end
        end
      end
    end
    menu.choice("Add a notifier") do
      say("Select a new notifier")
      choose do |note_menu|
        note_menu.index
        note_menu.choice("Growl Notification") do
          app.add_notifier("")
        end
      end
    end
    menu.choice("Exit")do
      exit
    end
    
  end

end


