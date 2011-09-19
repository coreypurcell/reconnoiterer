require_relative '../../lib/reconnoiterer/site'


describe Reconnoiterer::Site do
  include Reconnoiterer

class Reconnoiterer::Condition;end;

  it "parses the url for an http" do
    s = Site.new("www.google.com")
    s.uri.should == URI.parse("http://www.google.com")
  end

end
