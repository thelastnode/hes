$(function() {
  var socket = io.connect('http://localhost:3000/');

  var rect_side = 10;

  var clear_canvas = function(ctx) {
    ctx.fillStyle = 'black';
    ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  };

  var draw_point = function(ctx, p) {
    var x = ctx.canvas.width / 2 + p.point.x;
    var y = ctx.canvas.height / 2 - p.point.y;
    ctx.fillRect(x, y, rect_side, rect_side);
  };

  var draw_canvas = function(data) {
    var canvas = document.getElementById('game');
    var ctx = canvas.getContext('2d');

    clear_canvas(ctx);
    ctx.strokeStyle = ctx.fillStyle = 'white';
    _(data).forEach(function(p) {
      draw_point(ctx, p);
    });
  };

  socket.on('render', function (data) {
    draw_canvas(data);
  });
});
