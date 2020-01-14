const Asteroid = require('./asteroid.js');
const Ship = require('./ship.js');
const Bullet = require('./bullet.js');
const Util = require("./util");


function Game(){
    this.asteroids = [];
    this.bullets = [];
    this.ships = [];
    // this.ship = new Ship( { game: this, pos: [400, 400] } );

    this.addAsteroids();
}

Game.prototype.addAsteroids = function(){
    for(let i = 0; i < Game.NUM_ASTEROIDS; i++){
        let asteroidPos = this.randomPos();
        this.asteroids.push(new Asteroid({ pos: asteroidPos, game: this }));
    }

}

Game.prototype.addShip = function addShip() {
    const ship = new Ship({
      pos: [400,400],
      game: this
    });
  
    this.add(ship);
  
    return ship;
};

Game.prototype.randomPos = function(){
    const x = Math.floor(Math.random() * Game.DIM_X);
    const y = Math.floor(Math.random() * Game.DIM_Y);

    return [x, y];
}

Game.prototype.draw = function(ctx){

    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);
    ctx.fillStyle = "gray";
    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);
  
    this.allObjects().forEach( function(object) {
      object.draw(ctx);
    });

}

Game.prototype.moveObjects = function(){
    this.allObjects().forEach( (object) =>{
        object.move();
    });
}   

//feel like there should be easy way to do this modularly...
Game.prototype.wrap = function(pos) {
    return [
        Util.wrap(pos[0], Game.DIM_X), Util.wrap(pos[1], Game.DIM_Y)
    ];
}

Game.prototype.checkCollisions = function(){
  const allObjects = this.allObjects();
  for (let i = 0; i < allObjects.length; i++) {
    for (let j = 0; j < allObjects.length; j++) {
      const obj1 = allObjects[i];
      const obj2 = allObjects[j];
      if (obj1.isCollidedWith(obj2)) {
        const collision = obj2.collideWith(obj1);
        if (collision) return;
      }
    }
  }
    
}
// bool  = true
Game.prototype.step = function(){
    // if (bool){new Asteroid({ pos: [10,10], game: this })}
    this.moveObjects();
    this.checkCollisions();

}

Game.prototype.add = function(object){
    if (object instanceof Asteroid){
        this.asteroids.push(object);
    } else if (object instanceof Bullet){
        this.bullets.push(object);
    } else if(object instanceof Ship){
        this.ships.push(object);
    }else{console.log("uh oh neither object asteroid or bullet was 'object'");} 
}

Game.prototype.remove = function(object){
    if (object instanceof Asteroid){
        this.asteroids.splice(this.asteroids.indexOf(object), 1);

    } else if (object instanceof Bullet){
        this.bullets.splice(this.bullets.indexOf(object), 1);
    } else {console.log("uh oh neither object asteroid or bullet was 'object' (remove)");}

}

Game.prototype.allObjects = function(){
    return [].concat(this.ships, this.asteroids, this.bullets);

}

Game.prototype.isOutOfBounds = function(pos){
    if ((pos[0] >= Game.DIM_X || pos[0] <= 0) || (pos[1] >= Game.DIM_Y || pos[1] <= 0)) { return true; }
    return false;

}

Game.DIM_X = 1000;
Game.DIM_Y = 600;
Game.NUM_ASTEROIDS = 5;

module.exports = Game;