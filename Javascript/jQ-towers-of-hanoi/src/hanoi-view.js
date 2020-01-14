class HanoiView {
    constructor(game, $DOMele){
        this.game = game;
        this.$el = $DOMele;
        this.$selPile1 = null;


        this.setupTowers();

        const viewer = this;
        $('ul').on("click", function(event) {viewer.clickTower(event)});

        this.render();
    }

    setupTowers(){
        for(let i = 0; i < 3; i++){
            const $towerStack = $('<ul></ul>');
            $towerStack.data("index-id", i);
            $towerStack.addClass("tower");
            if (i == 0){
                for(let j = 0; j < 3; j++){
                    const $stackLi = $('<li></li>');
                    $stackLi.text("test");
                    $towerStack.append($stackLi);
                    
                }
            }
            this.$el.append($towerStack);
        }

    }

    render(){
        const towers = this.game.towers;
        $('li').remove();

        for(let i = 0; i < 3; i++){
            for(let j = 0; j < 3; j++){

                if(towers[i][j]){
                    const layer = (2-(towers[i][j] - 1))
                    const $newLi = $(`<li class="layer${layer}"></li>`)
                    const parentUl = $(`ul:nth-of-type(${i+1})`);
                    parentUl.append($newLi)
                }

            }

        }

        if (this.game.isWon()){
            $('li').addClass('layerwon');
            alert('Congratulations! You\'ve Won!');
        }


    }

    clickTower(event){
        if(this.$selPile1){
            //make the move interface with source code
            const $selPile2 = $(event.currentTarget);
            try{
                this.game.move(this.$selPile1.data('index-id'), $selPile2.data('index-id'));
            }catch(err){
                alert("invalid move!")
            }

            //reset the class and variable
            this.$selPile1.removeClass('selected')
            this.$selPile1 = null;

            this.render();

        } else {
            this.$selPile1 = $(event.currentTarget);
            (this.$selPile1).addClass('selected')
        }

    }



}


module.exports = HanoiView;