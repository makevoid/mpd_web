require "spec_helper"
require_relative "mpd_mock"

describe MpdWeb do
  context "/" do

    context "playlist" do
      it "add a track to the playlist" do
        post "/add"
      end
    end

    context "player" do
      it "plays mpd" do
        post "/play"
        app.mpd.state.should == :playing
      end

      it "pause mpd" do
        post "/pause"
        app.mpd.state.should == :paused
      end

      it "switches to next song" do
        post "/next"
      end

      it "toggles play/pause" do
        post "/play"
        post "/toggle"
        app.mpd.state.should == :paused
        post "/toggle"
        app.mpd.state.should == :playing
      end

      it "switches to prev song" do
        post "/prev"
      end
    end

    context "infos" do
      it "gets current track" do
        get "/current"
      end
    end

    context "pages" do

      before do
        get "/"
      end

      it "renders" do
        last_response.should be_ok
      end

      context "playlist" do
        it "shows a list of songs" do
          last_response.should =~ /Playlist/
        end
      end

      context "database" do
        it "shows a list of songs" do
          last_response.should =~ /Database/
        end
      end

    end

  end
end