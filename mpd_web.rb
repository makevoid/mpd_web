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
    @artists = mpd.artists
    haml :index
  end

  get "/current" do
    content_type :json

    if mpd.current
      mpd.current.attributes.to_json
    else
      {}.to_json
    end
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
    mpd.play_idx params[:idx]
    redirect "/"
  end

  post "/add" do
    mpd.add params[:path]
    redirect "/"
  end

  post "/crop" do
    mpd.crop
    redirect "/"
  end

  post "/del" do
    mpd.del params[:idx]
    redirect "/"
  end

  post "/volume/:volume" do |volume|
    mpd.volume = volume
    redirect "/"
  end

end
