import React from 'react';
import { uniqueId } from './../../util/utils';


class TodoForm extends React.Component{
    constructor(props){
        super(props)
        this.state = { title:"", body:"", tag:[]}

        this.addTodo = this.addTodo.bind(this);
        this.changeTitle = this.changeTitle.bind(this);
        this.changeBody = this.changeBody.bind(this);
    }

    addTodo(event){
        event.preventDefault();
        const todo = Object.assign({}, this.state);
        todo.id = uniqueId();
        this.props.receiveTodo(todo);
        this.clearInputs();
        this.setState({title:"", body:"", tag:[]});
    }

    clearInputs(){
        document.getElementById('form-title').value = ""
        document.getElementById('form-body').value = ""
        document.getElementById('form-tag').value = ""
    }

    changeTitle(event){
        const input = event.currentTarget;
        this.setState({title: input.value})
    }

    changeBody(event){
        const input = event.currentTarget;
        this.setState({body: input.value})
    }

    render(){
        return(
            <div>
                <form>
                    <label htmlFor="form-title">Title</label>
                    <br/>
                    <input onChange={this.changeTitle} id="form-title" type="text" placeholder="Buy Milk"/>
                    <br/>
                    <label htmlFor="form-body">Body</label>
                    <br/>
                    <input onChange={this.changeBody} id="form-body" type="text" placeholder="2% or whatever is on sale"/>
                    <br/>
                    <label htmlFor="form-tag">Tags</label>
                    <br/>
                    <input id="form-tag" type="text" placeholder="Enter a new tag"/>
                    <br/>
                    <button>Add Tag</button> 
                    <br/>
                    <input type="submit" onClick={this.addTodo} value="Create Todo!"/>
                </form>
            </div>
        );
    }
}

export default TodoForm;