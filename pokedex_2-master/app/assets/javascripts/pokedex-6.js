Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    if (!this._pokemonIndex) {
      this.pokemonIndex( function () {
        this.pokemonDetail(id, callback);
      }.bind(this));
    } else {
      var poke = this._pokemonIndex.collection.get(id);
      poke.fetch({
        success: function () {
          if (this._toyDetailView){
            this._toyDetailView.remove()
          }

          this._pokeDetail = new Pokedex.Views.PokemonDetail({ model: poke })
          $("#pokedex .pokemon-detail").html(this._pokeDetail.$el)
          this._pokeDetail.refreshPokemon();
          if (callback) {
            callback();
          }
        }.bind(this)
      })
    }
  },

  pokemonIndex: function (callback) {
    this._pokemonIndex = new Pokedex.Views.PokemonIndex();
    this._pokemonIndex.refreshPokemon({success: callback});
    $("#pokedex .pokemon-list").html(this._pokemonIndex.$el);
    this.pokemonForm();
  },

  toyDetail: function (pokemonId, toyId) {
    if (!this._pokeDetail) {
      this.pokemonDetail(pokemonId, function () {
        this.toyDetail(pokemonId, toyId);
      }.bind(this));
    } else {
      var toy = this._pokeDetail.model.toys().get(toyId);
      var toyDetailView = new Pokedex.Views.ToyDetail({model: toy, pokes: this._pokemonIndex.collection})
      this._toyDetailView = toyDetailView;
      $("#pokedex .toy-detail").html(toyDetailView.$el)
      toyDetailView.render();
    }
  },

  pokemonForm: function () {
    var pokeFormView = new Pokedex.Views.PokemonForm({
      model: new Pokedex.Models.Pokemon(),
      collection: this._pokemonIndex.collection
    })

    $("#pokedex .pokemon-form").html(pokeFormView.$el)
    pokeFormView.render();
  },

  // _swapPokeDetailView: function (newView) {
  //   if (!this._currentViews) {
  //       this._currentViews = {in
  //   }
  //   this._currentView = newView;
  //   this.$el.html(newView.render().$el);
  // }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
