Pokedex.Views = (Pokedex.Views || {});

Pokedex.Views.PokemonForm = Backbone.View.extend({
  events: {
    "submit" : "savePokemon"
  },

  render: function () {
    var content = JST['pokemonForm']()
    this.$el.html(content);
  },

  savePokemon: function (event) {
    event.preventDefault();
    var that = this;

    var attrs = $(event.target).serializeJSON()["pokemon"]
    var poke = new Pokedex.Models.Pokemon(attrs);
    poke.save( {}, {
      success: function () {
        that.render();
        that.collection.add(poke);
        Backbone.history.navigate("/pokemon/" + poke.id, {trigger: true})
      }
    })

  }
});
