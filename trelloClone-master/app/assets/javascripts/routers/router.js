TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
    '': 'boardsIndex',
    'boards/new': 'boardsNew',
    'boards/:id': 'boardsShow'

  },

  initialize: function(options) {
    this.$rootEl = options.$rootEl;

  },

  boardsNew: function () {
    board = new TrelloClone.Models.Board();
    var boardsIndexView = new TrelloClone.Views.BoardsNew({board: board, collection: TrelloClone.boards});

    this._swapView(boardsIndexView);
  },

  boardsShow: function (id) {
    var board = TrelloClone.Collections.boards.getOrFetch(id);

    var boardsShowView = new TrelloClone.Views.BoardShow({model: board});

    this._swapView(boardsShowView);
  },

  boardsIndex: function () {
    var boardsIndexView = new TrelloClone.Views.BoardsIndex({collection: TrelloClone.Collections.boards});

    this._swapView(boardsIndexView);
  },

  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }



});







//
//
//
//
// new: function () {
//   var newPost = new JournalApp.Models.Post();
//   var formView = new JournalApp.Views.PostForm({
//     collection: JournalApp.posts,
//     model: newPost
//   });
//
//   this._swapView(formView);
// },
