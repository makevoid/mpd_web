log = (msg) -> console.log msg if console
  


# events

post = (method) ->
  $.post "/#{method}", ->
    log "post: #{method}"

$ ->
  $("#player .play").on "click", ->
    post "play"
  
  $("#player .prev").on "click", ->
    post "prev"
    
  $("#player .next").on "click", ->
    post "next"