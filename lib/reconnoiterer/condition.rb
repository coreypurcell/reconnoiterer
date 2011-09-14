module Reconnoiterer
  class Condition

    def initialize(site)
      @site = site
    end

    def response_code(code)
      site = @site
      Reconnoiterer.app.outpost.add_scout(Outpost::Scouts::Http => @site.uri.host) do |config|
        options :host => site.uri.host, :port => site.uri.port
        report :up, :response_code => code
      end
    end

    def response_body(regx)
      site = @site
      Reconnoiterer.app.outpost.add_scout(Outpost::Scouts::Http => @site.uri.host) do |config|
        options :host => site.uri.host, :port => site.uri.port
        report :up, :response_body => {:match => regx}
      end
    end

    def destroy
      Reconnoiterer.app.outpost.scouts.delete_if {|scout,site| @site.uri.host == site[:description]}
    end

  end
end
