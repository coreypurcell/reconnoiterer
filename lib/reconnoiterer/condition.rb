module Reconnoiterer
  class Condition

    def initialize(site)
      @site = site
    end

    def response_code(code, app)
      site = @site
      app.outpost.add_scout(Outpost::Scouts::Http => @site.uri.host) do |config|
        options :host => site.uri.host, :port => site.uri.port
        report :up, :response_code => code
      end
    end

    def css_selector(css_query, app)

    end
  end
end
