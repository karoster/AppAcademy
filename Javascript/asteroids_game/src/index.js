const GameView = require('./game_view.js');
const Game = require('./game.js')


document.addEventListener("DOMContentLoaded", function(){
    let canvasEl = document.getElementById("game-canvas");
    let ctx = canvasEl.getContext("2d");
    ctx.canvas.width  = 1000;
    ctx.canvas.height = 600;
    let game = new Game();
    let gameView = new GameView(ctx, game);
    gameView.start();
});




