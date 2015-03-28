

$.FollowToggle = function (el) {
  this.$el = $(el);

  this.userId = this.$el.data("user-id");
  this.url = this.$el.data("follow-url");

  if (this.$el.data("follow-state")) {
    this.followState = "followed";
  } else {
    this.followState = "unfollowed";
  };

  // if (options.followState) {
  //   this.followState = options.followState;
  // }



  this.render();
  this.$el.on("click", this.handleClick.bind(this, event));

};

$.FollowToggle.prototype.render = function () {

  this.$el.prop("disabled", false);

  if (this.followState === "unfollowed") {
    this.$el.html("Follow");
  } else if (this.followState === "followed"){
    this.$el.html("Unfollow");
  }
  else {
    this.$el.html("Processing...");
    this.$el.prop("disabled", true);
  }


};

$.FollowToggle.prototype.handleClick = function (event) {
    event.preventDefault();

    if (this.followState === "unfollowed") {
      this.followState = "processing";
      this.render();

      $.ajax({
        type: "POST",
        url: this.url,
        dataType: "json",

        success: function(data) {
          this.followState = "followed";
          this.render();
        }.bind(this),

        error: function (data) {
          console.log("follow error");
        }
      });
    } else {
      this.followState = "processing";
      this.render();

      $.ajax({
        type: "DELETE",
        url: this.url,
        dataType: "json",

        success: function(data) {
          this.followState = "unfollowed";
          this.render();
        }.bind(this),

        error: function (data) {
          console.log("unfollow error");
        }
      });
    };

};
