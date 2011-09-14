require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers'
require 'uri'
require_relative 'site'
require_relative 'notifiers/growl'

module Reconnoiterer
  class App
    attr_reader :outpost
    attr_accessor :urls

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
      puts "add note"
      @outpost.add_notifier( Outpost::Notifiers::GrowlNotifier, {} )
      puts "added note"
    end

    def run(sleep_time)
      outpost = @outpost
      outpost.run
      pp outpost.messages
      outpost.notify
    end

  end
end
