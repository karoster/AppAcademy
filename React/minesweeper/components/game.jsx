import React from "react";
import Board from "./board"
import * as Minesweeper from "./minesweeper";
import Modal from "./modal";

class Game extends React.Component{
    constructor(props){
        super(props);
        this.state = { board: new Minesweeper.Board(9,10) };

        this.updateGame = this.updateGame.bind(this);
        // this.modal = this.modal.bind(this);
        this.resetGame = this.resetGame.bind(this);
    }

    updateGame(tile, flaggingBool){
        if (flaggingBool){
            tile.toggleFlag();
        }else{
            tile.explore();
        }
        this.setState({ board: this.state.board})
    }


    resetGame(event){
        this.setState({board: new Minesweeper.Board(9, 10)})
    }

    render(){
        return(
            <div>
                <Board boardState={this.state.board} updateFxn={this.updateGame}/>
                <Modal board={this.state.board} resetGameFxn={this.resetGame} />
            </div>
        );
    }

}

export default Game;