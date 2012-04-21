var net = require('net');
var carrier = require('carrier');
var uuid = require('node-uuid');

var Server = function(connect_callback, line_callback, end_callback) {
  var sockets = this.sockets = {};
  this.server = net.createServer(function(socket) {
    var uid = uuid.v4();
    console.log('CONNECT: %s', socket.address().address);
    sockets[uid] = socket;
    carrier.carry(socket, function(line) {
      line = new Buffer(line, 'base64').toString('ascii');
      console.log('LINE: %s', line);
      line_callback(uid, JSON.parse(line));

      // TODO: nuke this
      if (JSON.parse(line).right) {
        socket.write(new Buffer('{"dhealth": -1}', 'ascii').toString('ascii') + '\n');
      }
    });

    socket.on('close', function() {
      end_callback(uid);
      delete sockets[uid];
    });

    connect_callback(uid);
  });
};

Server.prototype.listen = function(port) {
  this.server.listen(port);
};

Server.prototype.send = function(uid, data) {
  this.sockets[uid].write(new Buffer(JSON.stringify(data), 'ascii').toString('ascii') + '\n');
};

Server.prototype.health = function(uid, health) {
  this.send(uid, {
    health: health,
  });
};

Server.prototype.score = function(uid, score) {
  this.send(uid, {
    score: score,
  });
};

Server.prototype.vibrate = function(uid, vibrate) {
  this.send(uid, {
    vibrate: vibrate,
  });
};

Server.prototype.color = function(uid, color) {
  this.send(uid, {
    color: parseInt('0xFF' + color),
  });
};

module.exports = Server;
