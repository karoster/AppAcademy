import {RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO} from '../actions/todo_actions'

const initialState = {
    1: {
      id: 1,
      title: "wash car",
      body: "with soap",
      done: false
    },
    2: {
      id: 2,
      title: "wash dog",
      body: "with shampoo",
      done: true
    }
};

const reducer = (state = initialState, action) => {
    switch(action.type){
        case RECEIVE_TODO:
            const dupedState = Object.assign({}, state);
            dupedState[action.todo.id] = action.todo;
            return(dupedState);

        case RECEIVE_TODOS:
            const todoHash = {};
            action.todos.forEach( (task) => todoHash[task.id] = task );
            return(todoHash);

        case REMOVE_TODO:
            const newState = Object.assign({}, state);
            delete newState[action.id];
            return newState;

        default:
            return state;
    }

}


export default reducer