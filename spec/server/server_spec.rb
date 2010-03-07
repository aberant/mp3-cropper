require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp3Cropper::Server do
  include Rack::Test::Methods
  
  def app
    @app ||= Mp3Cropper::Server
  end
  
  it "should provide a root action" do
    recording = Mp3Cropper::Recording.create(:name => "test-name")
    
    get "/"
    last_response.body.should include( recording.name )
  end  
end
