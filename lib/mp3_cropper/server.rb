require 'sinatra/base'
require 'erb'

module Mp3Cropper
  class Server < Sinatra::Base
    dir = File.dirname( File.expand_path(__FILE__))

    set :views, "#{dir}/server/views"
    set :public, "#{dir}/server/public"

    get "/mp3/:id" do
      file_name = Recording.get( params[:id] ).name
      send_file "public/mp3/#{file_name}", :type => "audio/mpeg"
    end

    get "/" do
      erb :index
    end

    post "/crop/:id" do
      file = Recording.get( params[:id]).name
      duration = Duration.new_from_start_stop( params[:mark_in_value], params[:mark_out_value] ).to_seconds

      input_file = File.expand_path("public/mp3/#{file}")
      output_file = File.expand_path("crop_#{params[:id]}.mp3")

      # %x("ffmpeg -ss #{params[:mark_in_value]} -t #{duration} -acodec copy -y -i #{input_file} #{output_file}")
    end
  end
end

