(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var clicked = undefined;

  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.$el = $el;

    this.bindEvents(this);

  };

  Hanoi.View.prototype.bindEvents = function () {
    this.$el.on("click", ".pole", this.handleClick.bind(this));

  };

  Hanoi.View.prototype.handleClick = function(event) {
    var pole = $(event.currentTarget);
    var valid = true;

    if (clicked) {
      // rules
      console.log(clicked.data("pos"), pole.data("pos"))
      console.log(this.game.isValidMove(clicked.data("pos"), pole.data("pos")))
      if (pole.data("pos") === clicked.data("pos")) {
        valid = true;
      } else if (!this.game.isValidMove(clicked.data("pos"), pole.data("pos"))) {
        valid = false;
      }

      var topDisk = $(clicked).find(".disks li:last-child");
    } else {
      // in tower
      var topDisk = $(pole).find(".disks li:last-child");
    }
    if (valid) {
      if (clicked === undefined) {
        clicked = pole;
        topDisk.addClass("clicked");
      } else {
        this.game.move(clicked.data("pos"), pole.data("pos"))
        topDisk.removeClass("clicked");
        topDisk.remove();
        $(pole).find(".disks").append(topDisk);
        clicked = undefined;
          if (this.game.isWon()) {
            alert("YOU WIN!!!!");
          }
      }
    } else {
      alert("You can't move there");
    }


  };


})();
