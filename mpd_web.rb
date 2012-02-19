APP_PATH = File.expand_path "../", __FILE__
require "#{APP_PATH}/config/env"

class MpdWeb < Sinatra::Base

  require "#{APP_PATH}/helpers/view_helpers"
  include ViewHelpers

  def self.mpd
    @@mpd
  end

  def mpd
    @@mpd ||= Mpd.new
  end

  get "/" do
    @playlist = mpd.playlist
    @database = mpd.database
    haml :index
  end

  post "/play" do
    mpd.play
    redirect "/"
  end

  post "/pause" do
    mpd.pause
    redirect "/"
  end

  post "/prev" do
    mpd.prev
    redirect "/"
  end

  post "/next" do
    mpd.next
    redirect "/"
  end

end
