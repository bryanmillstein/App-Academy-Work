window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    alert('Hello from Backbone!');
    NewsReader.feeds = new NewsReader.Collections.Feeds();
    new NewsReader.Routers.Feeds({
      "$rootEl": $("#content")
    });
    Backbone.history.start()
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});
