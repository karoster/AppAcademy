import React from 'react';


class StepListItem extends React.Component{
    constructor(props){
        super(props)
        this.state = {done: false};

        this.deleteStep = this.deleteStep.bind(this);
        this.update = this.update.bind(this);
    }

    deleteStep(event){
        this.props.removeStep(this.props.step.id);
    }

    update(event){
        this.setState({done: (this.state.done) ? false : true})
    }

    render(){
        return(
            <div>
                <h1>{this.props.step.title}</h1>
                <p>{this.props.step.body}</p>
                <button onClick={this.update}>{this.state.done ? "Undo" : "Done"}</button>
                <button onClick={this.deleteStep}>Delete</button>
            </div>
        );

    }

}

export default StepListItem;