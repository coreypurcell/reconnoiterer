require 'outpost'
require 'outpost/scouts'
require 'uri'
require_relative 'site'

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

    def run(sleep_time)
      outpost = @outpost
      Thread.new do
        sleep(sleep_time)
        outpost.run
        pp outpost.messages
      end
    end

  end
end
