import React from 'react';
import StepListContainer from '../step_list/step_list_container';

class TodoDetailView extends React.Component{
    constructor(props){
        super(props)
        this.remove = this.remove.bind(this);
    }

    remove(){
        this.props.removeTodo(this.props.todo.id);
    }

    render(){
        return(
            <div>
                <p>{this.props.todo.body}</p>
                <StepListContainer todo_id={this.props.todo.id}/>
                <button onClick={this.remove}>Delete Todo</button>

            </div>

        );
    }

}

export default TodoDetailView;