NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: 'api/feeds',
  model: NewsReader.Models.Feed,

  getOrFetch: function(id) {
    var model = this.get(id);
    var that = this;
      if (model) {
        model.fetch();
      } else {
        model = new NewsReader.Models.Feed({id: id});
        model.fetch({
          success: function () {
            that.add(model);
          }
        });
      }
      return model;
  }

});
