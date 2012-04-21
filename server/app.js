
/**
 * Module dependencies.
 */

var express = require('express')
var socket_io = require('socket.io');

var routes = require('./routes');

var Server = require('./server');
var Game = require('./game');

var game = new Game();

var app = module.exports = express.createServer();

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

app.get('/', routes.index);

app.listen(3000, function(){
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});


var server = new Server(function(id) {
  game.connect(id);
}, function(id, input) {
  game.receiveInput(id, input);
}, function(id) {
  game.disconnect(id);
});
(function(port) {
  server.listen(port);
  console.log("Game server listening on port %d", port);
})(4000);

var io = socket_io.listen(app);

io.set('log level', 2);

setInterval(function() {
  io.sockets.emit('render', game.getData());
  game.tick();
}, 25);
