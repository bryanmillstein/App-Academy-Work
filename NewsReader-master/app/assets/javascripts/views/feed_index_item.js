NewsReader.Views.FeedIndexItem = Backbone.View.extend({

  template: JST['feed_index_item'],

  events: {
    'click .delete': 'destroy'
  },

  initialize: function(options) {
    this.feed = options.feed
  },

  render: function() {
    var $div = this.template({feed: this.feed})
    this.$el.html($div);
    return this;
  },

  destroy: function(event) {
    this.feed.destroy();
  }


})
