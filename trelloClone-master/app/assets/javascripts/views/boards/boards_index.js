TrelloClone.Views.BoardsIndex = Backbone.View.extend({
  template: JST['boards/index'],
  tagName: "section",
  className: "board-home",

  initialize: function () {
    this.listenTo(this.collection, 'sync remove', this.render)
  },

  render: function () {
  var content = this.template();
  this.$el.html(content);

  var that = this;
  this.collection.each(function (board) {
    var view = new TrelloClone.Views.BoardIndexItem({ model: board });
    that.$('.boards').append(view.render().$el);
  });

  return this;
}


});
