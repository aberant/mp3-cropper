module Mp3Cropper
  class Cropper < WorkerBase
    def process( id, mark_in, mark_out )
      recording = Recording.get( id )

      duration = Duration.new_from_start_stop( mark_in, mark_out ).to_seconds

      Mp3Processor.run!(  mark_in,
                          duration,
                          recording.file_path,
                          Recording::LOCATIONS[:cropped] + "/" + File.basename( recording.file_path))
    end
  end
end