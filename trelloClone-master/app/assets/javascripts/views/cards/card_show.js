TrelloClone.Views.CardShow = Backbone.View.extend({
  template: JST['cards/card_show'],
  tagName: "li",
  className: "card",

  events: {
    'click .delete-card': 'destroyCard'
  },

  initialize: function(options) {
    this.listenTo(this.model, 'sync destroy', this.render);
  },

  render: function () {
    var content = this.template({ card: this.model });
    this.$el.html(content);
    return this;
  },

  destroyCard: function (event) {
    this.model.destroy();
  }

});
