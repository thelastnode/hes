var net = require('net');
var carrier = require('carrier');

var server = net.createServer(function(socket) {
  console.log('CONNECT: %s', socket.address().address);
  carrier.carry(socket, function(line) {
    console.log('LINE: %s', line);
  });

  setTimeout(function() {
    var line = JSON.stringify({
      foo: 5,
      bar: 'yay',
    });
    console.log('SEND: %s', line);
    line = new Buffer(line).toString('base64');
    socket.write(line + '\n');
  }, 1000);
});

module.exports = server;
