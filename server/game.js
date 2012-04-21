var User = function(x, y, color) {
  this.point = {x: x, y: y};
  this.velocity = {x: 0, y: 0};

  this.color = color;
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

    // handle velocity
    user.point = addV(user.point, scaleV(6, user.velocity));
    if (magV(user.velocity) > 0.1) {
      user.velocity = scaleV(0.98, user.velocity);
    }

    // absolute positioning
    var absx = WIDTH/2 + user.point.x;
    var absy = HEIGHT/2 + user.point.y;

    // check walls
    if (absx < WALL_DEPTH) {
      user.point = addV(user.point, {x: WALL_DEPTH - absx, y: 0});
    }
    if (absx + SHIP_WIDTH > WIDTH - WALL_DEPTH) {
      user.point = addV(user.point, {x: WIDTH - WALL_DEPTH - absx - SHIP_WIDTH, y: 0});
    }
    if (absy < WALL_DEPTH + SHIP_WIDTH) {
      user.point = addV(user.point, {x: 0, y: WALL_DEPTH - absy + SHIP_WIDTH});
    }
    if (absy > HEIGHT - WALL_DEPTH) {
      user.point = addV(user.point, {x: 0, y: HEIGHT - WALL_DEPTH - absy});
    }
  }
};

var WIDTH = 800;
var HEIGHT = 600;

var WALL_DEPTH = 1;
var SHIP_WIDTH = 10;


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
