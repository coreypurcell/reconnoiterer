# Don't load bundler it's too slow for tests.
# I'm using a my built fork, everyone
# else can use bundler to load the fork
# from Github

begin
  require 'outpost'
rescue LoadError
  require 'bundler'
  Bundler.setup(:default)
  require 'outpost'
end
require 'forwardable'
require 'ruby-growl'
require 'uri'
require 'twilio-rb'
require 'mail'
require 'tinder'
require 'net/ping/external'

require 'outpost/scouts'
require 'outpost/notifiers'
require_relative 'reconnoiterer/version'
require_relative 'reconnoiterer/app'
require_relative 'reconnoiterer/site'
require_relative 'reconnoiterer/condition'
require_relative 'reconnoiterer/notifiers/growl'
require_relative 'reconnoiterer/notifiers/sms'

module Reconnoiterer
  extend self

  def app
    @app ||= App.new
  end
end

Thread.abort_on_exception = true

