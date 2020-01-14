
function GameView(ctx, game){
    this.game = game;
    this.context = ctx;
    this.ship = this.game.addShip();
}

GameView.prototype.start = function(){
    let myView = this
    myView.bindKeyHandlers();
    setInterval(function(){
        myView.game.step();   
        myView.game.draw(myView.context);
    }, 20);
}

GameView.prototype.bindKeyHandlers = function(){
    key('left', () => { this.ship.power([-0.35,0]) });
    key('right', () => { this.ship.power([0.35,0]) });
    key('up', () => { this.ship.power([0,-0.35]) });
    key('down', () => { this.ship.power([0,0.35]) });
    key('space', () => { this.ship.fireBullet(); });
}

module.exports = GameView;