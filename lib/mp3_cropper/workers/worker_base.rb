module Mp3Cropper
  class WorkerBase

    def self.run!( id, *args )
      with_fork do
        new process( id, *args )
      end
    end

    def process( id, *args) end

    def with_fork
      if @child = Kernel.fork
        Process.wait
      else
        yield
        exit!
      end
    end
  end
end