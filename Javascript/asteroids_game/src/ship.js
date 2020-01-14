const Util = require('./util.js');
const MovingObject = require('./moving_object.js');
const Bullet = require('./bullet.js')


function Ship(options){

    options.rad = Ship.RADIUS;
    options.pos = options.pos || [400, 400]
    options.vel = options.vel || [0, 0];
    options.color = Ship.COLOR;

    MovingObject.call(this, options);

}

Util.inherits(Ship, MovingObject);
Ship.RADIUS = 15;



Ship.prototype.power = function power(impulse) {
    this.vel[0] += impulse[0];
    this.vel[1] += impulse[1];
};

Ship.prototype.relocate = function relocate() {
    this.pos = [400,400]
    this.vel = [0, 0];
};

Ship.prototype.fireBullet = function fireBullet() {
    const norm = Util.norm(this.vel);
  
    if (norm === 0) {
      // Can't fire unless moving.
      return;
    }
  
    const relVel = Util.scale(
      Util.dir(this.vel),
      Bullet.SPEED
    );
  
    const bulletVel = [
      relVel[0] + this.vel[0], relVel[1] + this.vel[1]
    ];
  
    const bullet = new Bullet({
      pos: this.pos,
      vel: bulletVel,
      color: "red",
      game: this.game
    });

    this.game.add(bullet);
    console.log("my vel is ", this.vel);
    console.log("bullet vel is ", bullet.vel);
};


Ship.COLOR = "blue";
// Ship.RADIUS = 5;A/


module.exports = Ship;