require 'spec_helper'
require_relative '../../lib/reconnoiterer'

describe Reconnoiterer::App do
  
  include Reconnoiterer
  
  let(:app){ Reconnoiterer.app }

  it "return up for google when using a response code condition" do

    url = app.add_url("http://www.msn.com")
    url.response_code(200)

    VCR.use_cassette('google') do
      app.run
    end

    app.outpost.last_status.should == :up
  end

  it "returns up for msn when using a match for response body" do
    url = app.add_url("http://www.msn.com")
    url.response_body(Regexp.new('msn'))

    VCR.use_cassette('msn') do
      app.run
    end

    app.outpost.last_status.should == :up
  end

end
