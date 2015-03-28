Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    "click li" : "selectPokemonFromList"
  },

  initialize: function () {
    this.collection = new Pokedex.Collections.Pokemon();
    this.listenTo(this.collection, "add", this.addPokemonToList);
  },

  addPokemonToList: function (pokemon) {
    console.log("add")

    var content = JST["pokemonListItem"]({pokemon: pokemon});
    this.$el.append(content);
  },

  myTest: function () {
    console.log("triggered")
  },

  refreshPokemon: function (options) {
    console.log("refresh")
    this.$el.empty();
    this.collection.fetch ({
      success: function () {
        // this.render();
        if (options.success) {
          options.success();
        }
      }.bind(this)
    });
  },

  render: function () {
    console.log("render")

    var that = this;

    this.$el.empty();

    this.collection.each( function (pokemon) {
      that.addPokemonToList(pokemon);
    });

    return this;
  },

  selectPokemonFromList: function (event) {
    Backbone.history.navigate('/pokemon/' + $(event.target).data("id"), { trigger: true })
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    "click .toys li" : "selectToyFromList"
  },

  // initialize: function (options) {
  //   this.model = options.model;
  //   this.listenTo(this.model, "change", this.refreshPokemon);
  // },

  refreshPokemon: function (options) {
    this.model.fetch({
      success: this.render.bind(this)
    });
  },

  render: function () {
    var content = JST["pokemonDetail"]({pokemon: this.model});
    this.$el.html(content);

    var $toys = this.$('.toys')

    this.model.toys().each((function(toy) {
      var toy = JST['toyListItem']({toy: toy});
      $toys.append(toy);
    }).bind(this));
  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data("id");
    var pokeId = $(event.currentTarget).data("pokemon-id");
    var path = "/pokemon/" + pokeId + "/toys/" + toyId;


    Backbone.history.navigate(path, { trigger: true} );
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({

  initialize: function (options) {

    this.model = options.model;
    this.pokes = options.pokes;

  },

  render: function () {
    var content = JST["toyDetail"]({toy: this.model, pokes:  this.pokes});
    this.$el.html(content);
  }
});

// $(function () {
//   var pokemonIndex = new Pokedex.Views.PokemonIndex();
//   pokemonIndex.refreshPokemon();
//   $("#pokedex .pokemon-list").html(pokemonIndex.$el);
// });
