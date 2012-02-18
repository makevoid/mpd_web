APP_PATH = File.expand_path "../", __FILE__
require "#{APP_PATH}/config/env"

class MpdWeb < Sinatra::Base
  @@mpd = Mpd.new
  
  require "#{APP_PATH}/helpers/view_helpers"
  include ViewHelpers
  
  get "/" do
    @playlist = @@mpd.playlist
    @database = @@mpd.database
    haml :index
  end
  
  # post "/play" do
  #   @@mpd.play
  # end
  # 
  # post "/pause" do
  #   @@mpd.pause
  # end
  
end
