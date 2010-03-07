module Mp3Cropper
  class Recording
    include DataMapper::Resource

    property :id,     Serial
    property :name,   String

    is :state_machine, :initial => :raw, :column => :status do
      state :raw
      state :cropped
      state :converted
      state :uploaded
    end


    def self.raw
      all(:status => "raw")
    end
  end
end