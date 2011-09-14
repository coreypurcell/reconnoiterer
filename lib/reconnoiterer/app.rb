# use bundler to pull my fork of Outpost from github for now
require "bundler/setup"
require 'outpost'
require 'outpost/scouts'
require 'outpost/notifiers'
require 'forwardable'
require_relative 'site'
require_relative 'notifiers/growl'

module Reconnoiterer
  class App

    extend Forwardable

    attr_reader :outpost
    attr_accessor :sites

    def_delegators :@outpost, :scouts, :scouts=, :reports, :reports=, :add_scout

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
      case notifier
      when /growl/i
        @outpost.add_notifier( Outpost::Notifiers::GrowlNotifier, {})
      when /email/i
      when /sms/i
      end
    end

    def run
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
