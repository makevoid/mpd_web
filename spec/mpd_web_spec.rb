require "spec_helper"

describe MpdWeb do
  context "/" do
    
    context "player" do
      it "plays mpd" do
        post "/play"
        Mpd.state.should == "playing"
      end
      
      it "pause mpd" do
        post "/pause"
        Mpd.state.should == "playing"
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