var User = function(x, y, color) {
  this.point = {x: x, y: y};
  this.velocity = {x: 0, y: 0};
  this.bullets = [];
  this.lastFired = new Date(0);
  this.color = color || randomColor();
};


var Game = module.exports = function Game(server) {
  this.users = {};
  this.server = server;
};

Game.prototype.receiveInput = function(id, input) {
  var user = this.users[id];
  if (input.left) {
    user.velocity = input.left;
  }
  if (input.right) {
    var diff = (new Date() - user.lastFired).valueOf();
    if (diff > FIRE_RATE) {
      user.bullets.push({
        point: user.point,
        velocity: normalizeV({
          x: input.right.x,
          y: input.right.y,
        }),
      });
      user.lastFired = new Date();
    }
  }
};

Game.prototype.getData = function() {
  return this.users;
};

Game.prototype.connect = function(id) {
  this.users[id] = new User(0, 0);

  this.server.color(id, this.users[id].color);
  this.server.vibrate(id, 200);
};

Game.prototype.disconnect = function(id) {
  delete this.users[id];
};

Game.prototype.tick = function(delta) {
  for (var id in this.users) {
    var user = this.users[id];

    // handle velocity
    user.point = addV(user.point, scaleV(8, user.velocity));
    if (magV(user.velocity) > 0.1) {
      user.velocity = scaleV(0.98, user.velocity);
    }

    // absolute positioning
    var absx = WIDTH/2 + user.point.x;
    var absy = HEIGHT/2 + user.point.y;

    // check walls
    if (absx < WALL_DEPTH) {
      user.point = addV(user.point, {x: WALL_DEPTH - absx, y: 0});
      this.server.vibrate(id, 20);
    }
    if (absx + SHIP_WIDTH > WIDTH - WALL_DEPTH) {
      user.point = addV(user.point, {x: WIDTH - WALL_DEPTH - absx - SHIP_WIDTH, y: 0});
      this.server.vibrate(id, 20);
    }
    if (absy < WALL_DEPTH + SHIP_WIDTH) {
      user.point = addV(user.point, {x: 0, y: WALL_DEPTH - absy + SHIP_WIDTH});
      this.server.vibrate(id, 20);
    }
    if (absy > HEIGHT - WALL_DEPTH) {
      user.point = addV(user.point, {x: 0, y: HEIGHT - WALL_DEPTH - absy});
      this.server.vibrate(id, 20);
    }
    
    // check collisions between ships
    for (var id2 in this.users) {
      if (id != id2 && shipsCollide(absx, absy, WIDTH/2 + this.users[id2].point.x, HEIGHT/2 + this.users[id2].point.y)) {
        this.server.vibrate(id, 500);
        this.server.vibrate(id2, 500);
      }
    }

    // bullets
    user.bullets.forEach(function(b) {
      b.point = addV(b.point, scaleV(BULLET_SPEED, b.velocity));
    });

    // bullet collisions
    var newbullets = [];
    user.bullets.forEach(function(b) {
      var absx = WIDTH/2 + user.point.x;
      var absy = HEIGHT/2 + user.point.y;

      if ((absx < WALL_DEPTH)
          || (absx + BULLET_WIDTH > WIDTH - WALL_DEPTH)
          || (absy < WALL_DEPTH + BULLET_WIDTH)
          || (absy > HEIGHT - WALL_DEPTH)) {
      } else {
        newbullets.push(b);
      }

      // TODO: hit ships and shit
    });
  }
};

var WIDTH = 1385;
var HEIGHT = 692;

var WALL_DEPTH = 1;
var SHIP_WIDTH = 15;
var BULLET_WIDTH = 4;

var FIRE_RATE = 200;
var BULLET_SPEED = 10;

var shipsCollide = function(x1, y1, x2, y2) {
  if (x2 < x1) {
    var tmp = x1;
    x1 = x2;
    x2 = tmp;
    tmp = y1;
    y1 = y2;
    y2 = tmp; 
  }
  if (x1 <= x2 && x2 <= x1 + SHIP_WIDTH) {
    if (y2 < y1) {
      var tmp = x1;
      x1 = x2;
      x2 = tmp;
      tmp = y1;
      y1 = y2;
      y2 = tmp; 
    }
    if (y1 <= y2 && y2 <= y1 + SHIP_WIDTH) {
      return true;
    }
  } 
  return false;
}

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

var normalizeV = function(v) {
  return scaleV(1 / magV(v), v);
};


var randomColor = function() {
  var red = Math.floor(Math.random() * 256).toString(16);
  var green = Math.floor(Math.random() * 256).toString(16);
  var blue = Math.floor(Math.random() * 256).toString(16);

  if (red.length < 2) red = '0' + red;
  if (green.length < 2) green = '0' + green;
  if (blue.length < 2) blue = '0' + blue;

  return red + green + blue;
};
