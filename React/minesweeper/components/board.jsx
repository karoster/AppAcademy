import Tile from './tile';
import React from 'react';


class Board extends React.Component{
    constructor(props){
        super(props);

    }

    render(){
        return(
            <div>
                {this.props.boardState.grid.map( (row, rowIdx) => {
                    return (<div key={rowIdx} className="tile-row">
                        {row.map((tile, tileIdx) => {
                            return <Tile key={tileIdx} tile={tile} updateFxn={this.props.updateFxn}/>;
                        })}
                    </div>);

                })}

            </div>

        );

    }

}

export default Board;