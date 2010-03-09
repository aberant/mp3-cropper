require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp3Cropper::Recording do
  it "should start in an 'imported' state" do
    r = Mp3Cropper::Recording.create( :name => "bob")
    r.status.should == "imported"
  end
  
  it "should be able to import new recordings into the system" do
    file_name = "bob.mp3"
    file_path = "/data/#{file_name}"
    Dir.should_receive( "[]" ).with(APP_ROOT + "/data/**/*.mp3").and_return( [file_path] )
    Mp3Cropper::Recording.should_receive( :create ).with( :name => file_name )
    
    FileUtils.should_receive( :mv ).with( file_path, Mp3Cropper::Recording::LOCATIONS[:imported] )
    
    Mp3Cropper::Recording.import!
  end
end