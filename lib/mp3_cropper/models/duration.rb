module Mp3Cropper
  class Duration
    def self.parse_hh_mm_ss( hhmmss )
      result = {}
      time = hhmmss.split(":")

      result[:hours] = time[0].to_i
      result[:minutes] = time[1].to_i
      result[:seconds] = time[2].to_i
      result
    end

    def self.hh_mm_ss_to_seconds( hhmmss )
      result = parse_hh_mm_ss( hhmmss )
      result[:seconds] + (60 * result[:minutes]) + (60 * 60 * result[:hours])
    end

    def self.new_from_start_stop( start, stop )
      start_time = hh_mm_ss_to_seconds( start )
      stop_time = hh_mm_ss_to_seconds( stop )

      new(stop_time - start_time).freeze
    end

    attr_reader :duration
    alias to_seconds duration

    def initialize( duration )
      @duration = duration
    end
  end
end