TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  template: JST['boards/index_item'],
  tagName: 'li',
  events: {
    'click .delete': 'destroyBoard'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync destroy', this.render);
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);

    return this;
  },


  destroyBoard: function (event) {
    this.model.destroy();
  }


});
