require_relative 'condition'
require 'uri'
require 'forwardable'

module Reconnoiterer
  class Site

    extend Forwardable

    attr_reader :uri

    def_delegators :@condition, :response_code, :response_body

    def initialize(url)
      @uri = URI.parse(url)
      @condition = Condition.new(self)
    end

    def destroy
      @condition.destroy
    end

  end
end
