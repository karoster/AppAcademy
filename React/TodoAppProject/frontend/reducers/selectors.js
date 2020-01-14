export const allTodos = (state) => {
    const keys = Object.keys(state.todos);
    return (keys.map( (key) => state.todos[key] ));
}

export const stepsByTodoId = (stepObj, todoId) => {
    const keys = Object.keys(stepObj);
    const steps = keys.map( (key) => stepObj[key] );
    return ( steps.filter( (step) => step.todo_id == todoId  ) )
}
