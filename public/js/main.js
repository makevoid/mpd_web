(function() {
  var log, post;

  log = function(msg) {
    if (console) return console.log(msg);
  };

  post = function(method) {
    return $.post("/" + method, function() {
      return log("post: " + method);
    });
  };

  $(function() {
    $("#player .play").on("click", function() {
      return post("play");
    });
    $("#player .prev").on("click", function() {
      return post("prev");
    });
    return $("#player .next").on("click", function() {
      return post("next");
    });
  });

}).call(this);
