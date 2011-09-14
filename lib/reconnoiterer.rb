require_relative 'reconnoiterer/app'

module Reconnoiterer
  extend self

  def app
    @app ||= App.new
  end
end

Thread.abort_on_exception = true

