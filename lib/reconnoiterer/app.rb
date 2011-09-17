# use bundler to pull my fork of Outpost from github for now
require 'forwardable'

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

    def add_condition(condition, url, options={})
      scout, config_blk = case condition
      when :response_code
        url.response_code
      when :response_body
        url.response_body(options)
      end
      @outpost.add_scout(scout, &config_blk)
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
