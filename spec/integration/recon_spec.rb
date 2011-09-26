require 'spec_helper'
require 'reconnoiterer'

describe Reconnoiterer::App do

  include Reconnoiterer


  it "return up for google when using a response code condition" do

    url = subject.add_url("http://www.google.com")
    subject.add_condition(:response_code, url)

    VCR.use_cassette('google') do
      subject.run
    end

    subject.last_status.should == :up
  end

  it "returns up for msn when using a match for response body" do
    url = subject.add_url("http://www.msn.com")
    subject.add_condition(:response_body, url, :match => Regexp.new('msn'))
    VCR.use_cassette('msn') do
      subject.run
    end

    subject.last_status.should == :up
  end

  it "notifies you when a status changes" do
    # url = app.add_url("http://www.google.com")
    # app.add_condition(:response_body, url, :match => Regexp.new('google'))

    # YOU CAN'T USE VCR LIKE THIS
    # VCR.use_cassette('google') do
    #   app.run
    # end
    # app.outpost.last_status.should == :up

    # VCR.use_cassette('msn') do
    #   app.run
    # end
    # app.outpost.last_status.should == :down

    pending
  end

end
