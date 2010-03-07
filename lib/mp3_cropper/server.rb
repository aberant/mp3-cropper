require 'sinatra/base'
require 'erb'

module Mp3Cropper
  class Server < Sinatra::Base

    dir = File.dirname( File.expand_path(__FILE__))

    set :views, "#{dir}/server/views"
    set :public, "#{dir}/server/public"

    get "/mp3/:id" do
      file_name = Recording.find( params[:id] ).name
      send_file "public/mp3/#{file_name}", :type => "audio/mpeg"
    end

    get "/" do
      erb :index
    end

    post "/crop/:id" do
      file = Recording.find( params[:id]).name
      start = hh_mm_ss_to_seconds(params[:mark_in_value])
      stop = hh_mm_ss_to_seconds(params[:mark_out_value])
      duration = start - stop

      input_file = File.expand_path("public/mp3/#{file}")
      output_file = File.expand_path("crop_#{params[:id]}.mp3")

      # %x("ffmpeg -ss #{params[:mark_in_value]} -t #{duration} -acodec copy -y -i #{input_file} #{output_file}")
    end

    def hh_mm_ss_to_seconds( hhmmss )
      time = hhmmss.split(":")
      hours = time[0].to_i
      min = time[1].to_i
      seconds = time[2].to_i
      seconds + (60 * seconds) + ( 60 * 60 * hours)
    end
  end
end

