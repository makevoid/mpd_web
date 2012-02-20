log = (msg) -> console.log msg if console
  


# events

post = (method, attrs={}) ->
  $.post "/#{method}", attrs, ->
    log "post: #{method}"

$ ->
  $("#player .play").on "click", ->
    val = if $("#player .play").html() == "||"
      post "pause"
      ">"
    else
      post "play"
      get_current_track()
      "||"
    $("#player .play").html(val)
      
  $("#player .prev").on "click", ->
    post "prev"
    get_current_track()
    
  $("#player .next").on "click", ->
    post "next"
    get_current_track()
    
  $("#player .playlist").on "click", ->
    post "play_idx", idx: $(this).data("idx")
    get_current_track()
    
  $("#player .database.name").on "click", ->
    post "add", path: $(this).data("path")
    
  get_current_track()
    
get_current_track = ->
  $.getJSON "/current", (data) ->
    $(".current_track").html(song_view(data))
    
song_view = (data) ->
  album = if data.album then "- #{data.album} " else ""
  "#{data.artist} #{album}- #{data.name}"
  