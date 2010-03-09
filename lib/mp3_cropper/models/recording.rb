require 'fileutils'

module Mp3Cropper
  class Recording
    include DataMapper::Resource

    LOCATIONS = { :raw => APP_ROOT + "/data",
                  :imported => APP_ROOT + "/data/imported",
                  :cropped => APP_ROOT + "/data/cropped" }

    property :id,         Serial
    property :name,       String
    property :file_path,  String

    is :state_machine, :initial => :imported, :column => :status do
      state :imported
      state :cropped
      state :converted
      state :uploaded
    end

    def self.import!
      glob = LOCATIONS[:raw] + "/**/*.mp3"

      Dir[glob].each do |file|
        Mp3Cropper::Recording.create( :name => File.basename( file ), :file_path => file )
        FileUtils.mv( file, LOCATIONS[:imported] )
      end
    end

    def self.imported
      all(:status => "imported")
    end
  end
end