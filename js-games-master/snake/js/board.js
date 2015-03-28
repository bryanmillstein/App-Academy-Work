(function () {
  if (window.Snake === undefined) {
    window.Snake = {}
  }

  Array.prototype.isEqual = function (arr) {
    if (this.length !== arr.length) {
      return false
    } else {

      for ( var i = 0; i < this.length; i++ ) {
        if (this[i] !== arr[i]) {
          return false
        }
      }
    }
    return true
  }

  Snake.Board = function (rows, cols, $el) {
    this.rows = rows;
    this.columns = cols;
    this.$el = $el;
    this.snake = new Snake.Snake(rows, cols, this);
    this.keyBindings();
  }

  Snake.Board.prototype.makeGrid = function () {


    for(var i = 0; i < this.rows; i++ ) {
      for(var j = 0; j< this.columns; j++){
        var $li = $("<li></li>");
        $li.data("pos", [i, j]);

        this.$el.append($li)
      };
    };

    for (var i = 0; i < this.snake.segments.length; i ++) {
      var index = this.snake.index(this.snake.segments[i][0], this.snake.segments[i][1]);
      this.toggleSegment(index);
    }

  };

  Snake.Board.prototype.toggleSegment = function (index) {
    $("li").eq(index).toggleClass("segment");
  }

  Snake.Board.prototype.keyBindings = function () {
    var snake = this.snake
    key('up', function(){ snake.turn("N") });
    key('down', function(){ snake.turn("S") });
    key('right', function(){ snake.turn("E") });
    key('left', function(){ snake.turn("W")});
  }


  $(document).ready( function () {
    var board = new Snake.Board(20,20, $(".snake"));
    board.makeGrid()
    setInterval(board.snake.move.bind(board.snake), 1000)
  }) ;



})();
