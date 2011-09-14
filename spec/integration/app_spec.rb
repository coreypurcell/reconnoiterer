require 'pry'
require 'rspec'
require_relative '../../lib/reconnoiterer'

describe Reconnoiterer::App do
  
  include Reconnoiterer
  
  let(:app){ Reconnoiterer.app }

  it "return up for google when using a response code condition" do

    url = app.add_url("http://www.msn.com")
    url.response_code(200)

    app.run

    app.outpost.last_status.should == :up
  end

  it "returns up for msn when using a match for response body" do
    url = app.add_url("http://www.msn.com")
    url.response_body(Regexp.new('msn'))

    app.run

    app.outpost.last_status.should == :up
  end

end
