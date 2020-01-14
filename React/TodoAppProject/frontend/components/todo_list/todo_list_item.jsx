import React from 'react';
import TodoDetailView from './todo_detail_view_container';


class TodoListItem extends React.Component{
    constructor(props){
        super(props);

        this.state = { done: props.todo.done, detail: false }

        this.remove = this.remove.bind(this);
        this.updateTodo = this.updateTodo.bind(this);
        this.renderDetail = this.renderDetail.bind(this);
        this.toggleDetail = this.toggleDetail.bind(this);
    }

    remove(event){
        this.props.removeTodo(this.props.todo.id);
    }

    updateTodo(event){
        const updatedTodo = Object.assign(this.props.todo, {done: this.flipState()});
        this.setState({done: updatedTodo.done});
        this.props.receiveTodo(updatedTodo);

        
    }

    flipState(){
        return this.state.done ? false : true
    }

    renderDetail(){
        if(this.state.detail){
            return (
                <TodoDetailView todo={this.props.todo}/>
            );
        } else { return null; }
    }

    toggleDetail(event){
        this.setState({detail: (this.state.detail) ? false : true})
    }

    render(){
        const todo = this.props.todo;


        return(
            <li>
                <div onClick={this.toggleDetail}>{todo.title}</div>
                <button onClick={this.updateTodo}>{this.props.todo.done ? "Undo" : "Done"}</button>
                {this.renderDetail()}
            </li>

        ); 
    }

}

export default TodoListItem;