APP_PATH = File.expand_path "../../", __FILE__ unless defined?(APP_PATH)
require 'bundler/setup'
Bundler.require :default

require 'sinatra/base'

Dir.glob("#{APP_PATH}/models/*").each do |model|
  require model
end