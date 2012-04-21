var net = require('net');
var carrier = require('carrier');

var server = net.createServer(function(socket) {
  console.log('CONNECT: %s', socket.address().address);
  carrier.carry(socket, function(line) {
    console.log('LINE: %s', line);
  });
});

module.exports = server;
