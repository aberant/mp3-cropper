require 'sinatra/base'
require 'erb'

module Mp3Cropper
  class Server < Sinatra::Base
    dir = File.dirname( File.expand_path(__FILE__))

    def file_store_path( dir, file_name )
      "#{dir}/../../#{file_name}"
    end

    set :views, "#{dir}/server/views"
    set :public, "#{dir}/server/public"

    get "/mp3/:id" do
      @recording = Recording.get( params[:id] )
      redirect "/" unless @recording
      send_file @recording.file_path, :type => "audio/mpeg"
    end

    get "/" do
      @recordings = Recording.imported
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

      Cropper.new.run!( recording.id, params )
      redirect "/"
    end
  end
end

