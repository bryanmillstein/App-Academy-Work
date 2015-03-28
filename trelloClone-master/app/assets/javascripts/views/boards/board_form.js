TrelloClone.Views.BoardsNew = Backbone.View.extend({
  template: JST['board/form'],
  tagName: 'form',
  className: 'board-form',
  events: {
    'submit': 'submit'
  },

  initialize: function (options) {
    this.board = options.board;
    this.collection = options.collection;

  },

  render: function () {
    var content = this.template({board: this.board});
    this.$el.html(content);

    return this;
  },

  submit: function (event) {
    event.preventDefault();
    var title = this.$('.board-title').val();
    var board = new TrelloClone.Models.Board({title: title});
    board.save();
    this.collection.add(board);
    Backbone.history.navigate('', true)
  }


});
