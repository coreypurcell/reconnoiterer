module Reconnoiterer
  class Condition

    def initialize(site)
      @site = site
    end

    def response_code(code=200)
      # Use the local since Outpost passes the block to instance_eval
      # (Closures for the win, just using @site won't work)
      site = @site
      scout = {Outpost::Scouts::Http => site.host}
      config_block = lambda do |config|
        options :host => site.host, :port => site.port
        report :up, :response_code => code
      end
      [scout, config_block]
    end

    def response_body(opts)
      # Use the local since Outpost passes the block to instance_eval
      # (Closures for the win, just using @site won't work)
      site = @site
      scout = {Outpost::Scouts::Http => site.host}
      config_block = lambda do |config|
        options :host => site.host, :port => site.port
        report :up, :response_body => opts
      end
      [scout, config_block]
    end

  end
end
