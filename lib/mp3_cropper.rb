require 'yaml'

# =================
# = Bundler setup =
# =================
begin
  # Try to require the preresolved locked set of gems.
  require File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fall back on doing an unlocked resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

Bundler.require
APP_ROOT =  File.dirname(__FILE__) + "/.."

require 'mp3_cropper/models/recording'
require 'mp3_cropper/models/duration'
require 'mp3_cropper/models/mp3_processor'

require 'mp3_cropper/workers/worker_base'
require 'mp3_cropper/workers/cropper'

require 'mp3_cropper/server'


# ====================
# = Datamapper Setup =
# ====================
config = YAML.load( File.open( File.dirname(__FILE__) + "/../config/database.yml" ) )
environment = ENV['APP_ENV'] || "development"

DataMapper::Logger.new($stdout, :error)
DataMapper.setup(:default, "mysql://localhost/#{config[environment]["db_name"]}")
DataMapper.auto_upgrade!


