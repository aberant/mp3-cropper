require 'sinatra/base'
require 'erb'

module Mp3Cropper
  class Server < Sinatra::Base
    dir = File.dirname( File.expand_path(__FILE__))


    set :views, "#{dir}/server/views"
    set :public, "#{dir}/server/public"

    get "/mp3/:id" do
      file_name = Recording.get( params[:id] ).name
      send_file "#{dir}/../../#{file_name}", :type => "audio/mpeg"
    end

    get "/" do
      @recordings = Recording.raw
      erb :index
    end

    get "/edit/:id" do
      @recording = Recording.get( params[:id] )
      redirect "/" unless @recording
      erb :show
    end

    post "/crop/:id" do
      recording = Recording.get( params[:id])
      redirect "/" unless recording

      duration = Duration.new_from_start_stop( params[:mark_in_value], params[:mark_out_value] ).to_seconds

      input_file = File.expand_path("public/mp3/#{recording.name}")
      output_file = File.expand_path("crop_#{params[:id]}.mp3")

      # %x("ffmpeg -ss #{params[:mark_in_value]} -t #{duration} -acodec copy -y -i #{input_file} #{output_file}")
    end
  end
end

