require 'reconnoiterer'

# class Reconnoiterer::Site
# end

# module Outpost;class Application;end;end;

describe Reconnoiterer::App do
  include Reconnoiterer

  let(:app) { App.new }
  before do
    # @outpost_mock = double(:@outpost, :add_scout => "")
    # Outpost::Application.stub!(:new).and_return(@outpost_mock)
    app.stub(:outpost => double(:add_scout => true))
  end

  describe '#add_url' do
    it "adds a Site with the url" do
      app.add_url("google.com")
      app.sites.should have(1).things
      app.sites.first.should be_an_instance_of Site
    end

    it "returns the Site instance" do
      s = app.add_url("google.com")
      s.uri.host.should match(/google\.com/)
    end
  end

  describe '#add_condition' do

    let(:site_mock) { double("Site") }

    context 'a response code requested' do
      it "creates a response code condition" do
        site_mock.should_receive(:response_code)
        app.add_condition(:response_code, site_mock)
      end

      it "adds the scout" do
        site_mock.should_receive(:response_code)
        app.outpost.should_receive(:add_scout)
        app.add_condition(:response_code, site_mock)
      end
    end

    context 'a response body, match requested' do
      it "creates a response body condtion with a match" do
        site_mock.should_receive(:response_body).with(:match => "matchme")
        app.add_condition(:response_body, site_mock, :match => "matchme")
      end

      it "adds the scout" do
        site_mock.should_receive(:response_body).with(:match => "matchme")
        app.outpost.should_receive(:add_scout)
        app.add_condition(:response_body, site_mock, :match => "matchme")
      end
    end
  end

  describe '#run' do

    # it "runs the outpost scouts and caches their reports" do
    #   @outpost_mock.should_receive(:run)
    #   @outpost_mock.should_receive(:last_status).and_return(:up)
    #   app.status_cache.should == :up
    # end

  end
end
