$.UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find(".search-bar");
  this.$ul = this.$el.find(".users-list");

  this.$el.on("input", this.inputHandler.bind(this));

};

$.UserSearch.prototype.renderResults = function (usersArr) {

  this.$ul.empty();

  usersArr.forEach(function(user){
    this.$ul.append('<li><a href="/users/'+user.id+
                    '">'+user.username+'</a></li>');

    this.$ul.append('<button class="' + user.username +
    'data-follow-state="<%= current_user.follows?(User.find(' + user.id +
    ')) %>" data-user-id="' + user.id + '"></button>');

    // $.fn.followToggle = function (options) {
    // return this.each(function () {
    //   new $.FollowToggle($("."+user.username));

  }.bind(this));

};

$.UserSearch.prototype.inputHandler = function () {

  var val = this.$input.val();


  $.ajax({
    type: "GET",
    URL: "users/search/",
    data: {query: val},
    dataType: "json",

    success: function (resp) {
      this.renderResults.call(this, resp);
    }.bind(this),

    error: function (data) {
      console.log("get error");
    }
  });

};
