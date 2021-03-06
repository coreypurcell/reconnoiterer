module Reconnoiterer
  class Site

    extend Forwardable

    attr_reader :uri

    def_delegators :@condition, :response_code, :response_body
    def_delegators :@uri, :host, :port

    def initialize(url)
      if url =~ /^http:\/\//
        @uri = URI.parse(url)
      else
        @uri = URI.parse("http://#{url}")
      end
      @condition = Condition.new(self)
    end

  end
end
