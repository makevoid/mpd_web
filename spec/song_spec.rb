# require "spec_helper"
path = File.expand_path "../../", __FILE__
Dir.glob("#{path}/models/*").each do |model|
  require model
end

describe Song do
  it "should split a path" do
    song = Song.new(:path, "Caspian/The Four Trees/01 Moksha 1.mp3")
    song.name.to_s.should == "01 Moksha 1"
    song.artist.to_s.should == "Caspian"
    song.album.to_s.should == "The Four Trees"
  end
end