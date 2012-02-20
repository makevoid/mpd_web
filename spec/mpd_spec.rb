# require "spec_helper"
path = File.expand_path "../../", __FILE__
Dir.glob("#{path}/models/*").each do |model|
  require model
end

require_relative "mpd_mock"

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