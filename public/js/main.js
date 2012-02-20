(function() {
  var get_current_track, log, post, refresh, song_view;

  log = function(msg) {
    if (console) return console.log(msg);
  };

  post = function(method, attrs, callback) {
    if (attrs == null) attrs = {};
    return $.post("/" + method, attrs, function() {
      log("post: " + method);
      if (callback) return callback();
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
    $(".playlist.name").on("click", function() {
      post("play_idx", {
        idx: $(this).data("idx")
      });
      return get_current_track();
    });
    $(".database.name, .database.artist, .database.album").on("click", function() {
      return post("add", {
        path: $(this).data("path")
      }, function() {
        return refresh();
      });
    });
    $(".playlist .crop").on("click", function() {
      return post("crop", {}, function() {
        return refresh();
      });
    });
    return get_current_track();
  });

  refresh = function() {
    return document.location.href = "/";
  };

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
