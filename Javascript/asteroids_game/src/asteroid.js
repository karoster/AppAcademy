const Util = require('./util.js');
const MovingObject = require('./moving_object.js');
const Ship = require('./ship.js');
const Bullet = require('./bullet.js');


function Asteroid(positionGameObject){

    optionsObject = {
        color: Asteroid.COLOR,
        rad: Asteroid.RADIUS,
        pos: positionGameObject.pos,
        vel: Util.randomVec(1),
        game: positionGameObject.game
    };

    MovingObject.call(this, optionsObject);
}

Util.inherits(Asteroid, MovingObject);


Asteroid.prototype.collideWith = function(otherObject){
    if (otherObject instanceof Ship){
        otherObject.relocate();
    } else if (otherObject instanceof Bullet){
        this.remove();
        otherObject.remove();
    }

}


Asteroid.COLOR = "orange";
Asteroid.RADIUS = 30;


module.exports = Asteroid;