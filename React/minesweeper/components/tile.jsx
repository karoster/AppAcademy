import React from "react";
class Tile extends React.Component{
    constructor(props){
        super(props)
        this.renderType = this.renderType.bind(this);
        this.handleClick = this.handleClick.bind(this);
    }

    renderType(){
        const tile = this.props.tile

        if(tile.flagged){
            return 	'flag';

        } else if (tile.explored){
            if(tile.bombed){
                return 'bomb'
            }else if (tile.adjacentBombCount() > 0){
                return "revealed";
            } else if (tile.adjacentBombCount() == 0){
                return "empty";
            }
        } else{
            return "unexplored"
        }

    }

    handleClick(e){
        if (e.altKey){
            this.props.updateFxn(this.props.tile, true);
        }
        else{
            this.props.updateFxn(this.props.tile, false);
        }

    }

    render(){
        const tile = this.props.tile;
        const renderClass = this.renderType();
        return (<div className={"tile " + renderClass} onClick={this.handleClick}>
            {Tile.RENDERS[renderClass] || tile.adjacentBombCount()}
        </div>);
    }

}


//revealed not given key/value so that above || statement returns number of surrounding bombs
//rather than a (below) object value.
Tile.RENDERS = { "bomb":<span>&#128163;</span>,
    "unexplored": " ",
    "empty": " ",
    "flag": <span>&#x2691;</span>
}

export default Tile;