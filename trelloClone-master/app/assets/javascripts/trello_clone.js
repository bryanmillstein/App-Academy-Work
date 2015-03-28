window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  Utils: {},
  initialize: function() {
    TrelloClone.Collections.boards = new TrelloClone.Collections.Boards();
    TrelloClone.Collections.boards.fetch();
    new TrelloClone.Routers.Router({"$rootEl": $("#main")});
    Backbone.history.start();
    
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});
