NewsReader.Views.FeedShow = Backbone.View.extend({
  events: {
    'click .refresh': 'render'
  },

  template: JST['show'],

  initialize: function(options) {
    this.feed = options.feed;
    this.collection = options.collection;
    this.listenTo(this.collection, 'sync', this.render)
    this.listenTo(this.feed, 'change', this.render)    
  },

  render: function() {
    var $li = this.template({feed: this.feed});
    this.$el.html($li);
    return this;
  }

})
