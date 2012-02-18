# require "spec_helper"
path = File.expand_path "../../", __FILE__
Dir.glob("#{path}/models/*").each do |model|
  require model
end

class Mpd 
  def mpc(command)
    case command
    when "listall" 
"Brontide/Sans souci/01 Matador.m4a
Brontide/Sans souci/02 Limehouse Ink.m4a
Caspian/The Four Trees/01 Moksha.mp3"
    when "playlist"
"Brontide - Matador
Brontide - Limehouse Ink"
    else
      raise "command '#{command}' not found in fixtures"
    end
  end
end

describe Mpd do
  before do 
    @mpd = Mpd.new
  end
  
  it "lists database songs" do
    @mpd.database.should be_an(Array)
    @mpd.database.first.should be_a(Song)
  end
  
  it "lists playlist songs" do
    @mpd.playlist.should be_an(Array)
    @mpd.playlist.first.should be_a(Song)
  end
end