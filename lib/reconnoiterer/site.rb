require_relative 'condition'

module Reconnoiterer
  class Site

    attr_reader :uri

    def initialize(url)
      @uri = URI.parse(url)
    end

    def set_condition(app)
      @condition = Condition.new(self).response_code(200, app)
    end

    # def destroy
    #   @condition.destroy
    # end


  end
end
