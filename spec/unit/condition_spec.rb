require_relative '../../lib/reconnoiterer/condition'

module Outpost
  module Scouts
    class Http
    end
  end
end
include Reconnoiterer
describe Condition do

  before do
    site = double("Site")
    site.stub(:host).and_return("google.com")
    site.stub(:port).and_return(80)

    @cond = Condition.new(site)
  end

  describe '#response_code' do
    it "returns the outpost scout and configuration block" do
      scout, block = @cond.response_code

      scout.should == {Outpost::Scouts::Http => "google.com"}
      block.should be_kind_of Proc
    end

  end

  describe '#reponse_body' do
    it "returns the outpost scout and configuration block" do
      scout, block = @cond.response_body({:match => 'matchme'})

      scout.should == {Outpost::Scouts::Http => "google.com"}
      block.should be_kind_of Proc
    end
  end

end
