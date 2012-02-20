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

  get "/current" do
    content_type :json
    mpd.current.attributes.to_json
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

  post "/toggle" do
    mpd.toggle
    redirect "/"
  end

  post "/play_idx" do
    mpd.play params[:idx]
    redirect "/"
  end

  post "/add" do
    mpd.toggle
    redirect "/"
  end
end
