require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mp3Cropper::Duration do
  it "should be able to parse the hh:mm:ss format" do
    result = Mp3Cropper::Duration.parse_hh_mm_ss( "01:22:54" )
    result.should == { :hours => 1, :minutes => 22, :seconds => 54 }
  end
  
  it "should accept a start and end time in hh:mm:ss format and calculate the duration in seconds" do
    duration = Mp3Cropper::Duration.new_from_start_stop( "00:00:00", "00:00:35")
    duration.to_seconds.should == 35
  end
end