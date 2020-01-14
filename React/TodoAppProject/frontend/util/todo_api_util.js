const fetchTodos = () => (
    $.ajax({
        url: "/api/todos",
        method: "GET"
    })
);


export default fetchTodos;