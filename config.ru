#!/usr/bin/env ruby

$LOAD_PATH.unshift ::File.expand_path(::File.dirname(__FILE__) + '/lib')
require 'mp3_cropper'

use Rack::ShowExceptions
run Server.new