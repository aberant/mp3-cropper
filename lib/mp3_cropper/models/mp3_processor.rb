module Mp3Cropper
  class Mp3Processor
    # %x("ffmpeg -ss #{params[:mark_in_value]} -t #{duration} -acodec copy -y -i #{input_file} #{output_file}")

    def self.run!( mark_in, duration, input_file, output_file)
      %x(ffmpeg -ss #{args[:mark_in]} -t #{args[:duration]} -acodec copy -y -i '#{args[:input_file]}' #{args[:output_file]})
    end
  end
end