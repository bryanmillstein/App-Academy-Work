NewsReader.Routers.Feeds = Backbone.Router.extend({

  initialize: function(options) {
    this.$rootEl = options.$rootEl;
    NewsReader.feeds.fetch();
  },

  routes: {
    '': 'feedIndex',
    'feeds/:id': 'feedShow'
  },

  feedIndex: function () {
    var indexView = new NewsReader.Views.FeedIndex({collection: NewsReader.feeds});
    this._swapView(indexView);
  },

  feedShow: function(id) {
    var feed = NewsReader.feeds.getOrFetch(id)
    var showView = new NewsReader.Views.FeedShow({feed: feed, collection: NewsReader.feeds});
    this._swapView(showView);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el)
  }

})
