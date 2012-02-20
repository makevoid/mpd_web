log = (msg) -> console.log msg if console
  


# events

post = (method, attrs={}, callback) ->
  $.post "/#{method}", attrs, ->
    log "post: #{method}"
    callback() if callback

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
    
  $(".playlist.name").on "click", ->
    post "play_idx", idx: $(this).data("idx")
    get_current_track()
    
  $(".database.name, .database.artist, .database.album").on "click", ->
    post "add", path: $(this).data("path"), ->
      refresh()
    
  $(".playlist .crop").on "click", ->
    post "crop", {}, ->
      refresh()
  
  get_current_track()

refresh = ->
  document.location.href = "/"

get_current_track = ->
  $.getJSON "/current", (data) ->
    $(".current_track").html(song_view(data))
    
song_view = (data) ->
  album = if data.album then "- #{data.album} " else ""
  "#{data.artist} #{album}- #{data.name}"
  