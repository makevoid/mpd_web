# encoding: utf-8

class Mpd

  @@state = nil

  def state
    @@state
  end

  def toggle
    mpc 'toggle'
    @@state = @@state == :playing ? :paused : :playing
  end

  def play
    mpc 'play'
    @@state = :playing
  end

  def play_idx(idx)
    mpc "play #{idx}"
    @@state = :playing
  end

  def pause
    mpc 'pause'
    @@state =  :paused
  end

  def prev
    mpc 'prev'
  end

  def next
    mpc 'next'
  end

  def add(path)
    mpc "add \"#{path}\""
  end

  def crop
    mpc "crop"
  end

  def voldown
    mpc 'volume -10'
  end

  def volup
    mpc 'volume +10'
  end

  def volume
    mpc('volume').grep(/([0-9]+)/)
    $1
  end

  def current
    list_songs(:label, mpc("current")).first
  end

  def track
    mpc '-f "%title%" current'
  end

  def artist
    mpc '-f "%artist%" current'
  end

  def album
    mpc '-f "%album%" current'
  end

  def launched?
    %x(mpc 2> /dev/null)
    $? == 0
  end

  def host
    ENV['MPD_HOST'] || super
  end

  def search(name)
    mpc "search any #{name}"
  end

  def listall
    list_songs :path, mpc("listall")
  end
  alias :database :listall

  def playlist
    list_songs :label, mpc("playlist")
  end

  private

  def mpc(command)
    %x(mpc #{command}).strip
  end

  def list_songs(type, string)
    string = string.encode("UTF-8", invalid: :replace, undef: :replace)
    songs = string.split("\n")
    songs.map do |song|
      Song.new type, song
    end
  end
end
