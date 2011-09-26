module Reconnoiterer
  class App

    extend Forwardable

    attr_reader :outpost
    attr_accessor :sites
    attr_reader :status_cache

    def_delegators :@outpost, :scouts, :scouts=, :reports, :reports=, :add_scout, :messages, :last_status

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
      outpost.add_scout(scout, &config_blk)
    end

    def add_notifier(notifier, options={})
      case notifier
      when :growl
        @outpost.add_notifier(Outpost::Notifiers::GrowlNotifier, {})
      when :sms
        @outpost.add_notifier(Outpost::Notifiers::SMS, options)
      end
    end

    def run
      @outpost.run
      if @status_cache != @outpost.last_status
        @status_cache = @outpost.last_status
        @outpost.notify
      end
    end

    def remove_site(site)
      @sites.delete(site)
      outpost.scouts.delete_if do |scout,s|
        site.host == s[:description]
      end
      # Clear out old reports
      @outpost.reports = {}
    end

  end
end
