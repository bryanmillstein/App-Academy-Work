(function () {
  if (typeof window.Snake === "undefined") {
    window.Snake = {};
  }


Snake.Snake = function (rows, cols, board) {
  this.segments = [[10,10], [10,9],[10,8],[10,7],[10,6]];
  this.rows = rows;
  this.cols = cols;
  this.dir = "E";
  this.board = board;

};

Snake.Snake.prototype.move = function() {
  console.log ("move")
  var head = this.segments[0];
  var removed = this.segments.pop();
  var removedIndex = this.index(removed[0], removed[1]);
  this.board.toggleSegment(removedIndex);

  switch(this.dir) {
    case "W":
      this.segments.unshift([head[0], head[1] - 1])
      if (head[1] === 0) {
        this.segments[0][1] = this.cols - 1
      }
      break;
    case "E":
      this.segments.unshift([head[0], head[1] + 1])
      if (head[1] >= this.cols - 1) {
        this.segments[0][1] = 0
      }
      console.log(this.segments[0][0], this.segments[0][1])
      break;
    case "N":
      this.segments.unshift([head[0] - 1, head[1]])
      if (head[0] === 0) {
        this.segments[0][0] = this.rows - 1
      }
      break;
    case "S":
      this.segments.unshift([head[0] + 1, head[1]])
      if (head[0] >= this.cols - 1) {
        this.segments[0][0] = 0
      }
      break;

  }

  var newHead = this.segments[0];
  var newHeadIndex = this.index(newHead[0], newHead[1]);
  this.board.toggleSegment(newHeadIndex);
};

Snake.Snake.prototype.index = function(i, j) {
  var index = i * this.rows + j;
  return index;

};

Snake.Snake.prototype.turn = function(dir) {
  this.dir = dir
}




})();
