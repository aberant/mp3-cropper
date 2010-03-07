module Mp3Cropper
  class Recording
    include DataMapper::Resource

    property :id,     Serial
    property :name,   String
  end
end