require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp3Cropper::Cropper do
  before :each do
    @file_name = "mega-file.mp3"
    @file_path = "/data/imported/mega-file.mp3"
    @recording = Mp3Cropper::Recording.create( :name => @file_name, :file_path => @file_path )
  end
  
  it "sends the cropping information off to the mp3 processor" do
    Mp3Cropper::Mp3Processor.should_receive(:run!).with( "00:00:30", 30,  @file_path, /data\/cropped\/mega-file.mp3/) 
    
    worker = Mp3Cropper::Cropper.new
    worker.process( @recording.id, "00:00:30", "00:01:00" )    
  end
  
end
