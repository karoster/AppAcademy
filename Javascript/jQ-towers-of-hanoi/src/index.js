const HanoiView = require('./hanoi-view.js') // require appropriate file
const HanoiGame = require('./game.js')// require appropriate file

$(() => {
  const $rootEl = $('.towers-of-hanoi');
  const game = new HanoiGame();
  new HanoiView(game, $rootEl);
});
