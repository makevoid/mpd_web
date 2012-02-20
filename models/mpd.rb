# encoding: utf-8

class Mpd

  @@state = nil

  def self.state=(state)
    @@state = state
  end

  def self.state
    @@state
  end

  def playpause
    mpc 'toggle'
  end

  def play
    mpc 'play'
  end

  def pause
    mpc 'pause'
  end

  def prev
    mpc 'prev'
    super
  end

  def next
    mpc 'next'
    super
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
