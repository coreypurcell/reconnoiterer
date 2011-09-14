# use bundler to pull my fork from github
require "bundler/setup"
require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers'
require 'uri'
require_relative 'site'
require_relative 'notifiers/growl'

module Reconnoiterer
  class App
    attr_reader :outpost
    attr_accessor :sites

    def initialize
      @outpost = Outpost::Application.new
      @sites = []
    end

    def add_url(url)
      site = Site.new(url)
      @sites << site
      site
    end

    def add_notifier(notifier)
      # can add multiple notifier types here
      @outpost.add_notifier( Outpost::Notifiers::GrowlNotifier, {} )
    end

    def run(sleep_time)
      @outpost.run
      @outpost.notify
    end

    def remove_site(site)
      @sites.delete(site)
      site.destroy
      # Clear out old reports
      @outpost.reports = {}
    end

  end
end
