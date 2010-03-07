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

# ====================
# = Datamapper Setup =
# ====================
require 'dm-core'
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'mysql://localhost/mp3_cropper')


require 'mp3_cropper/models/recording'
require 'mp3_cropper/workers/worker'
