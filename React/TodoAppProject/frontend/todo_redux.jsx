import React from 'react';
import ReactDOM from 'react-dom';
import configureStore from './store/store';
import Root from './components/root';

import fetchTodos from './util/todo_api_util.js'
window.fetchTodos = fetchTodos;

const store = configureStore();

window.store = store;

document.addEventListener("DOMContentLoaded", ()=>{
    const rootEl = document.getElementById('root');
    ReactDOM.render(
        <div>
            <Root store={store}/>
        </div>,
        rootEl)

})