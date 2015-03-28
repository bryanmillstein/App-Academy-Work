TrelloClone.Collections.Lists = Backbone.Collection.extend({
  url: 'api/lists',
  model: TrelloClone.Models.List,
  comparator: 'order',

  initialize: function(options) {
    this.board = options.board;
  }

});
