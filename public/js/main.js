(function() {
  var get_current_track, log, post, song_view;

  log = function(msg) {
    if (console) return console.log(msg);
  };

  post = function(method, attrs) {
    if (attrs == null) attrs = {};
    return $.post("/" + method, attrs, function() {
      return log("post: " + method);
    });
  };

  $(function() {
    $("#player .play").on("click", function() {
      var val;
      val = $("#player .play").html() === "||" ? (post("pause"), ">") : (post("play"), get_current_track(), "||");
      return $("#player .play").html(val);
    });
    $("#player .prev").on("click", function() {
      post("prev");
      return get_current_track();
    });
    $("#player .next").on("click", function() {
      post("next");
      return get_current_track();
    });
    $("#player .playlist").on("click", function() {
      post("play_idx", {
        idx: $(this).data("idx")
      });
      return get_current_track();
    });
    $("#player .database.name").on("click", function() {
      return post("add", {
        path: $(this).data("path")
      });
    });
    return get_current_track();
  });

  get_current_track = function() {
    return $.getJSON("/current", function(data) {
      return $(".current_track").html(song_view(data));
    });
  };

  song_view = function(data) {
    var album;
    album = data.album ? "- " + data.album + " " : "";
    return "" + data.artist + " " + album + "- " + data.name;
  };

}).call(this);
