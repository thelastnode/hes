var User = function(x, y) {
  this.point = {x: x, y: y};
  this.velocity = {x: 0, y: 0};
};


var Game = module.exports = function Game() {
  this.users = {};
};

Game.prototype.receiveInput = function(id, input) {
  if (!input.left) {
    return;
  }
  var user = this.users[id];
  user.velocity = input.left;
};

Game.prototype.getData = function() {
  return this.users;
};

Game.prototype.connect = function(id) {
  this.users[id] = new User(0, 0);
};

Game.prototype.disconnect = function(id) {
  delete this.users[id];
};

Game.prototype.tick = function(delta) {
  for (var id in this.users) {
    var user = this.users[id];
    user.point = addV(user.point, scaleV(6, user.velocity));
    if (magV(user.velocity) > 0.1) {
      user.velocity = scaleV(0.98, user.velocity);
    }
  }
};


var addV = function(v1, v2) {
  return {
    x: v1.x + v2.x,
    y: v1.y + v2.y,
  };
};

var scaleV = function(a, v) {
  return {
    x: v.x * a,
    y: v.y * a,
  };
};

var magV = function(v) {
  return Math.sqrt(v.x * v.x + v.y * v.y);
};
