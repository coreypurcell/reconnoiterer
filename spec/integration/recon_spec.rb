require 'spec_helper'
require_relative '../../lib/reconnoiterer'

describe Reconnoiterer::App do

  include Reconnoiterer

  let(:app){ App.new }

  it "return up for google when using a response code condition" do

    url = app.add_url("http://www.google.com")
    app.add_condition(:response_code, url)

    VCR.use_cassette('google') do
      app.run
    end

    app.outpost.last_status.should == :up
  end

  it "returns up for msn when using a match for response body" do
    url = app.add_url("http://www.msn.com")
    app.add_condition(:response_body, url, :match => Regexp.new('msn'))
    VCR.use_cassette('msn') do
      app.run
    end

    app.outpost.last_status.should == :up
  end

end
