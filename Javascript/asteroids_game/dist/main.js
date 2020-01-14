/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/index.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/asteroid.js":
/*!*************************!*\
  !*** ./src/asteroid.js ***!
  \*************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./util.js */ \"./src/util.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Ship = __webpack_require__(/*! ./ship.js */ \"./src/ship.js\");\nconst Bullet = __webpack_require__(/*! ./bullet.js */ \"./src/bullet.js\");\n\n\nfunction Asteroid(positionGameObject){\n\n    optionsObject = {\n        color: Asteroid.COLOR,\n        rad: Asteroid.RADIUS,\n        pos: positionGameObject.pos,\n        vel: Util.randomVec(1),\n        game: positionGameObject.game\n    };\n\n    MovingObject.call(this, optionsObject);\n}\n\nUtil.inherits(Asteroid, MovingObject);\n\n\nAsteroid.prototype.collideWith = function(otherObject){\n    if (otherObject instanceof Ship){\n        otherObject.relocate();\n    } else if (otherObject instanceof Bullet){\n        this.remove();\n        otherObject.remove();\n    }\n\n}\n\n\nAsteroid.COLOR = \"orange\";\nAsteroid.RADIUS = 30;\n\n\nmodule.exports = Asteroid;\n\n//# sourceURL=webpack:///./src/asteroid.js?");

/***/ }),

/***/ "./src/bullet.js":
/*!***********************!*\
  !*** ./src/bullet.js ***!
  \***********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object */ \"./src/moving_object.js\");\n\nfunction Bullet(options) {\n  options.rad = Bullet.RADIUS;\n\n  MovingObject.call(this, options);\n}   \n\nBullet.RADIUS = 2;\nBullet.SPEED = 15;\n\nUtil.inherits(Bullet, MovingObject);\n\nBullet.prototype.isWrappable = false;\n\nmodule.exports = Bullet;\n\n\n//# sourceURL=webpack:///./src/bullet.js?");

/***/ }),

/***/ "./src/game.js":
/*!*********************!*\
  !*** ./src/game.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Asteroid = __webpack_require__(/*! ./asteroid.js */ \"./src/asteroid.js\");\nconst Ship = __webpack_require__(/*! ./ship.js */ \"./src/ship.js\");\nconst Bullet = __webpack_require__(/*! ./bullet.js */ \"./src/bullet.js\");\nconst Util = __webpack_require__(/*! ./util */ \"./src/util.js\");\n\n\nfunction Game(){\n    this.asteroids = [];\n    this.bullets = [];\n    this.ships = [];\n    // this.ship = new Ship( { game: this, pos: [400, 400] } );\n\n    this.addAsteroids();\n}\n\nGame.prototype.addAsteroids = function(){\n    for(let i = 0; i < Game.NUM_ASTEROIDS; i++){\n        let asteroidPos = this.randomPos();\n        this.asteroids.push(new Asteroid({ pos: asteroidPos, game: this }));\n    }\n\n}\n\nGame.prototype.addShip = function addShip() {\n    const ship = new Ship({\n      pos: [400,400],\n      game: this\n    });\n  \n    this.add(ship);\n  \n    return ship;\n};\n\nGame.prototype.randomPos = function(){\n    const x = Math.floor(Math.random() * Game.DIM_X);\n    const y = Math.floor(Math.random() * Game.DIM_Y);\n\n    return [x, y];\n}\n\nGame.prototype.draw = function(ctx){\n\n    ctx.clearRect(0, 0, Game.DIM_X, Game.DIM_Y);\n    ctx.fillStyle = \"gray\";\n    ctx.fillRect(0, 0, Game.DIM_X, Game.DIM_Y);\n  \n    this.allObjects().forEach( function(object) {\n      object.draw(ctx);\n    });\n\n}\n\nGame.prototype.moveObjects = function(){\n    this.allObjects().forEach( (object) =>{\n        object.move();\n    });\n}   \n\n//feel like there should be easy way to do this modularly...\nGame.prototype.wrap = function(pos) {\n    return [\n        Util.wrap(pos[0], Game.DIM_X), Util.wrap(pos[1], Game.DIM_Y)\n    ];\n}\n\nGame.prototype.checkCollisions = function(){\n  const allObjects = this.allObjects();\n  for (let i = 0; i < allObjects.length; i++) {\n    for (let j = 0; j < allObjects.length; j++) {\n      const obj1 = allObjects[i];\n      const obj2 = allObjects[j];\n      if (obj1.isCollidedWith(obj2)) {\n        const collision = obj2.collideWith(obj1);\n        if (collision) return;\n      }\n    }\n  }\n    \n}\n// bool  = true\nGame.prototype.step = function(){\n    // if (bool){new Asteroid({ pos: [10,10], game: this })}\n    this.moveObjects();\n    this.checkCollisions();\n\n}\n\nGame.prototype.add = function(object){\n    if (object instanceof Asteroid){\n        this.asteroids.push(object);\n    } else if (object instanceof Bullet){\n        this.bullets.push(object);\n    } else if(object instanceof Ship){\n        this.ships.push(object);\n    }else{console.log(\"uh oh neither object asteroid or bullet was 'object'\");} \n}\n\nGame.prototype.remove = function(object){\n    if (object instanceof Asteroid){\n        this.asteroids.splice(this.asteroids.indexOf(object), 1);\n\n    } else if (object instanceof Bullet){\n        this.bullets.splice(this.bullets.indexOf(object), 1);\n    } else {console.log(\"uh oh neither object asteroid or bullet was 'object' (remove)\");}\n\n}\n\nGame.prototype.allObjects = function(){\n    return [].concat(this.ships, this.asteroids, this.bullets);\n\n}\n\nGame.prototype.isOutOfBounds = function(pos){\n    if ((pos[0] >= Game.DIM_X || pos[0] <= 0) || (pos[1] >= Game.DIM_Y || pos[1] <= 0)) { return true; }\n    return false;\n\n}\n\nGame.DIM_X = 1000;\nGame.DIM_Y = 600;\nGame.NUM_ASTEROIDS = 5;\n\nmodule.exports = Game;\n\n//# sourceURL=webpack:///./src/game.js?");

/***/ }),

/***/ "./src/game_view.js":
/*!**************************!*\
  !*** ./src/game_view.js ***!
  \**************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\nfunction GameView(ctx, game){\n    this.game = game;\n    this.context = ctx;\n    this.ship = this.game.addShip();\n}\n\nGameView.prototype.start = function(){\n    let myView = this\n    myView.bindKeyHandlers();\n    setInterval(function(){\n        myView.game.step();   \n        myView.game.draw(myView.context);\n    }, 20);\n}\n\nGameView.prototype.bindKeyHandlers = function(){\n    key('left', () => { this.ship.power([-0.35,0]) });\n    key('right', () => { this.ship.power([0.35,0]) });\n    key('up', () => { this.ship.power([0,-0.35]) });\n    key('down', () => { this.ship.power([0,0.35]) });\n    key('space', () => { this.ship.fireBullet(); });\n}\n\nmodule.exports = GameView;\n\n//# sourceURL=webpack:///./src/game_view.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const GameView = __webpack_require__(/*! ./game_view.js */ \"./src/game_view.js\");\nconst Game = __webpack_require__(/*! ./game.js */ \"./src/game.js\")\n\n\ndocument.addEventListener(\"DOMContentLoaded\", function(){\n    let canvasEl = document.getElementById(\"game-canvas\");\n    let ctx = canvasEl.getContext(\"2d\");\n    ctx.canvas.width  = 1000;\n    ctx.canvas.height = 600;\n    let game = new Game();\n    let gameView = new GameView(ctx, game);\n    gameView.start();\n});\n\n\n\n\n\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/moving_object.js":
/*!******************************!*\
  !*** ./src/moving_object.js ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./util */ \"./src/util.js\")\n// const Ship = require('./ship')\nfunction MovingObject(optionsObject){\n    this.pos = optionsObject.pos;\n    this.vel = optionsObject.vel;\n    this.rad = optionsObject.rad;\n    this.color = optionsObject.color;\n    this.game = optionsObject.game;\n}\n\nMovingObject.prototype.draw = function(ctx){ \n    ctx.fillStyle = this.color;\n\n    ctx.beginPath();\n    ctx.arc(\n      this.pos[0], this.pos[1], this.rad, 0, 2 * Math.PI, true\n    );\n    ctx.fill();\n\n}\n\nMovingObject.prototype.isWrappable = true;\n\n\nMovingObject.prototype.move = function(){\n    const new_pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]]\n    // this.pos[0] += this.vel[0];\n    // this.pos[1] += this.vel[1];\n    this.pos = new_pos;\n    if (this.game.isOutOfBounds(this.pos)) {\n        if (this.isWrappable) {\n          this.pos = this.game.wrap(this.pos);\n        } else {\n          this.remove();\n        }\n    }\n    \n}\n\n\n\nMovingObject.prototype.isCollidedWith = function(otherObject){\n    const centerDist = Util.dist(this.pos, otherObject.pos);\n    return (centerDist < (this.rad + otherObject.rad));\n}\n\n\nMovingObject.prototype.distBetween = function(pos1, pos2){\n    return Util.dist(pos1, pos2);\n}\n\n\nMovingObject.prototype.remove = function remove() {\n    this.game.remove(this);\n};\n\n\nMovingObject.prototype.collideWith = function(otherObject){\n\n}\n\n\n\nmodule.exports = MovingObject;\n\n//# sourceURL=webpack:///./src/moving_object.js?");

/***/ }),

/***/ "./src/ship.js":
/*!*********************!*\
  !*** ./src/ship.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Util = __webpack_require__(/*! ./util.js */ \"./src/util.js\");\nconst MovingObject = __webpack_require__(/*! ./moving_object.js */ \"./src/moving_object.js\");\nconst Bullet = __webpack_require__(/*! ./bullet.js */ \"./src/bullet.js\")\n\n\nfunction Ship(options){\n\n    options.rad = Ship.RADIUS;\n    options.pos = options.pos || [400, 400]\n    options.vel = options.vel || [0, 0];\n    options.color = Ship.COLOR;\n\n    MovingObject.call(this, options);\n\n}\n\nUtil.inherits(Ship, MovingObject);\nShip.RADIUS = 15;\n\n\n\nShip.prototype.power = function power(impulse) {\n    this.vel[0] += impulse[0];\n    this.vel[1] += impulse[1];\n};\n\nShip.prototype.relocate = function relocate() {\n    this.pos = [400,400]\n    this.vel = [0, 0];\n};\n\nShip.prototype.fireBullet = function fireBullet() {\n    const norm = Util.norm(this.vel);\n  \n    if (norm === 0) {\n      // Can't fire unless moving.\n      return;\n    }\n  \n    const relVel = Util.scale(\n      Util.dir(this.vel),\n      Bullet.SPEED\n    );\n  \n    const bulletVel = [\n      relVel[0] + this.vel[0], relVel[1] + this.vel[1]\n    ];\n  \n    const bullet = new Bullet({\n      pos: this.pos,\n      vel: bulletVel,\n      color: \"red\",\n      game: this.game\n    });\n\n    this.game.add(bullet);\n    console.log(\"my vel is \", this.vel);\n    console.log(\"bullet vel is \", bullet.vel);\n};\n\n\nShip.COLOR = \"blue\";\n// Ship.RADIUS = 5;A/\n\n\nmodule.exports = Ship;\n\n//# sourceURL=webpack:///./src/ship.js?");

/***/ }),

/***/ "./src/util.js":
/*!*********************!*\
  !*** ./src/util.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\n\nconst Util = {\n    // Normalize the length of the vector to 1, maintaining direction.\n    dir(vec) {\n      const norm = Util.norm(vec);\n      return Util.scale(vec, 1 / norm);\n    },\n    // Find distance between two points.\n    dist(pos1, pos2) {\n      return Math.sqrt(\n        Math.pow(pos1[0] - pos2[0], 2) + Math.pow(pos1[1] - pos2[1], 2)\n      );\n    },\n    // Find the length of the vector.\n    norm(vec) {\n      return Util.dist([0, 0], vec);\n    },\n    // Return a randomly oriented vector with the given length.\n    randomVec(length) {\n      const deg = 2 * Math.PI * Math.random();\n      return Util.scale([Math.sin(deg), Math.cos(deg)], length);\n    },\n    // Scale the length of a vector by the given amount.\n    scale(vec, m) {\n      return [vec[0] * m, vec[1] * m];\n    },\n    inherits(ChildClass, BaseClass) {\n      ChildClass.prototype = Object.create(BaseClass.prototype);\n      ChildClass.prototype.constructor = ChildClass;\n    },\n  \n    wrap(coord, max) {\n      if (coord < 0) {\n        return max - (coord % max);\n      } else if (coord > max) {\n        return coord % max;\n      } else {\n        return coord;\n      }\n    }\n};\n  \nmodule.exports = Util;\n  \n\n//# sourceURL=webpack:///./src/util.js?");

/***/ })

/******/ });