require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp3Cropper::Server do
  include Rack::Test::Methods
  
  def app
    @app ||= Mp3Cropper::Server
  end
  before :each do
    @recording = Mp3Cropper::Recording.create(:name => "test-name.mp3", :file_path => "/data/test-name.mp3")
  end
  
  it "should list the newly created recordings" do
    get "/"
    last_response.body.should include( @recording.name )
  end 

  it "provides a way to edit the files" do
    get "/edit/#{@recording.id}"
    
    last_response.should be_ok
  end
  
  it "should redirect to root path if thre is no file" do
    get "/edit/999999"
    
    last_response.should be_redirect #to("/")
  end
  
  it "should pass the post params to the cropper" do
    Mp3Cropper::Cropper.should_receive( :run! ).with( @recording.id, "00:00:25", "00:00:45" )
    
    post "/crop/#{@recording.id}", {:mark_in => "00:00:25", :mark_out => "00:00:45"}
  end
  
end
