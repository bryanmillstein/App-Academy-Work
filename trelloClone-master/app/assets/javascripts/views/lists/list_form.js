TrelloClone.Views.ListForm = Backbone.View.extend({
  template: JST['lists/form'],
  tagName: 'form',
  className: 'list-form',
  events: {
    'submit': 'submit'
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submit: function(event) {
    event.preventDefault();
    var title = this.$('.list-title').val();
    var newList = new TrelloClone.Models.List({title: title, board_id: this.model.id});
    newList.save();
    Backbone.history.navigate('', { trigger: true })
    // Backbone.history.navigate('boards/' + this.board.id, true);

  }



});
