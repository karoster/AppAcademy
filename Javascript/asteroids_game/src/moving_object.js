const Util = require('./util')
// const Ship = require('./ship')
function MovingObject(optionsObject){
    this.pos = optionsObject.pos;
    this.vel = optionsObject.vel;
    this.rad = optionsObject.rad;
    this.color = optionsObject.color;
    this.game = optionsObject.game;
}

MovingObject.prototype.draw = function(ctx){ 
    ctx.fillStyle = this.color;

    ctx.beginPath();
    ctx.arc(
      this.pos[0], this.pos[1], this.rad, 0, 2 * Math.PI, true
    );
    ctx.fill();

}

MovingObject.prototype.isWrappable = true;


MovingObject.prototype.move = function(){
    const new_pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]]
    // this.pos[0] += this.vel[0];
    // this.pos[1] += this.vel[1];
    this.pos = new_pos;
    if (this.game.isOutOfBounds(this.pos)) {
        if (this.isWrappable) {
          this.pos = this.game.wrap(this.pos);
        } else {
          this.remove();
        }
    }
    
}



MovingObject.prototype.isCollidedWith = function(otherObject){
    const centerDist = Util.dist(this.pos, otherObject.pos);
    return (centerDist < (this.rad + otherObject.rad));
}


MovingObject.prototype.distBetween = function(pos1, pos2){
    return Util.dist(pos1, pos2);
}


MovingObject.prototype.remove = function remove() {
    this.game.remove(this);
};


MovingObject.prototype.collideWith = function(otherObject){

}



module.exports = MovingObject;