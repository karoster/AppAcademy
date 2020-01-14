import React from 'react';

function Modal(props){

    if (props.board.won()){
        return(
            <div className="modal">
                <div>
                    You Won!
                    <br/>
                    <button onClick={props.resetGameFxn}>Play Again</button>
                </div>
            </div>

        );
    } else if(props.board.lost()){
        return(
            <div className="modal">
                <div>
                    You Lost!
                    <button onClick={props.resetGameFxn}>Play Again</button>
                </div>
            </div>
        );
    } else{
        return null;
    }

}


export default Modal