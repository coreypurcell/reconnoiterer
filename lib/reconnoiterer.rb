require 'rubygems'
require 'outpost'
require 'outpost/scouts'
require 'uri'

require 'pry'


class Reconnoiterer

  attr_reader :outpost
  attr_writer :urls

  def initialize
    @outpost = Outpost::Application.new
    @sites = []
  end

  def add_url(url)
    site = Site.new(url)
    @sites << site
    site
  end

end

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
end
