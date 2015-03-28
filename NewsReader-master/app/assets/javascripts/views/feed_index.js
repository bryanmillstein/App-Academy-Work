NewsReader.Views.FeedIndex = Backbone.View.extend({
  template: JST['index'],

  events: {
    "click .delete": "destroy"
  },

  initialize: function (options) {
    this.collection = options.collection
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "remove", this.render);
  },

  render: function () {
    var that = this;
    var content = this.template({collection: this.collection});
    this.$el.html(content);

    this.collection.each( function(feed) {
      var feedIndexItem = new NewsReader.Views.FeedIndexItem({feed: feed});
      console.log(feedIndexItem)
      that.$('ul').append(feedIndexItem.render().$el);
    })
    return this;
  }
  
})
