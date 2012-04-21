$(function() {
  var socket = io.connect('http://localhost:3000/');

  var rect_side = 15;
  var bullet_side = 6;

  var clear_canvas = function(ctx) {
    ctx.fillStyle = 'black';
    ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height);
  };

  var draw_point = function(ctx, p) {
    ctx.fillStyle = '#' + p.color;
    ctx.strokeStyle = 'white';
    var x = ctx.canvas.width / 2 + p.point.x;
    var y = ctx.canvas.height / 2 - p.point.y;
    ctx.fillRect(x, y, rect_side, rect_side);
    ctx.strokeRect(x, y, rect_side, rect_side);

    _(p.bullets).forEach(function(b) {
      draw_bullet(ctx, b, p.color);
    });
  };

  var draw_bullet = function(ctx, b, color) {
    ctx.fillStyle = '#' + color;
    ctx.strokeStyle = 'white';
    var x = ctx.canvas.width / 2 + b.point.x;
    var y = ctx.canvas.height / 2 - b.point.y;
    ctx.fillRect(x, y, bullet_side, bullet_side);
    ctx.strokeRect(x, y, bullet_side, bullet_side);
  };

  var draw_canvas = function(data) {
    var canvas = document.getElementById('game');
    var ctx = canvas.getContext('2d');

    clear_canvas(ctx);
    _(data).forEach(function(p) {
      draw_point(ctx, p);
    });
  };

  socket.on('render', function (data) {
    draw_canvas(data);
  });
});
