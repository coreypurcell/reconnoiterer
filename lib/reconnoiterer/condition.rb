module Reconnoiterer
  class Condition

    def initialize(site)
      @site = site
    end

    def response_code(code=200)
      # Use the local since Outpost passes the block to instance_eval
      # (Closures for the win, just using @site won't work)
      site = @site
      [{Outpost::Scouts::Http => site.uri.host}, lambda do |config|
        options :host => site.uri.host, :port => site.uri.port
        report :up, :response_code => code
      end]
    end

    def response_body(opts)
      # Use the local since Outpost passes the block to instance_eval
      # (Closures for the win, just using @site won't work)
      site = @site
      [{Outpost::Scouts::Http => site.uri.host}, lambda do |config|
        options :host => site.uri.host, :port => site.uri.port
        report :up, :response_body => opts
      end]
    end

    def destroy
      Reconnoiterer.app.scouts.delete_if do |scout,site|
        @site.uri.host == site[:description]
      end
    end

  end
end
