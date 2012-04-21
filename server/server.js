var net = require('net');
var carrier = require('carrier');
var uuid = require('node-uuid');

var Server = function(connect_callback, line_callback) {
  this.server = net.createServer(function(socket) {
    var uid = uuid.v4();
    console.log('CONNECT: %s', socket.address().address);
    carrier.carry(socket, function(line) {
      line = new Buffer(line, 'base64').toString('ascii');
      console.log('LINE: %s', line);
      line_callback(uid, JSON.parse(line));

      // TODO: nuke this
      if (JSON.parse(line).right) {
        socket.write(new Buffer('{"color": 0xFFFF0000}', 'ascii').toString('ascii') + '\n');
      }
    });
    connect_callback(uid);
  });
};

Server.prototype.listen = function(port) {
  this.server.listen(port);
};

module.exports = Server;
