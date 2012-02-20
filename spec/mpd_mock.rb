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
    when /play|pause|next|prev|toggle/
      ""
    when "current"
      "Zero 7 - Throw It All Away - Feat. Sia"
    else
      msg = "command '#{command}' not found in fixtures"
      puts msg
      raise msg
    end
  end
end