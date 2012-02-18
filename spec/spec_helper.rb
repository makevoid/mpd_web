path = File.expand_path "../../", __FILE__
require "#{path}/mpd_web"

require "rack/test"
RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  MpdWeb
end