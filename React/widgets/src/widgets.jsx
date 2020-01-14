import React from 'react';
import ReactDOM from 'react-dom';
import Clock from './clock';
import Tabs from './tabs';
import AutoComplete from './autocomplete';


document.addEventListener("DOMContentLoaded", () => {
    const root = document.getElementById('root');
    const tabs = [ {title:"One", content:"I am the first"},
     {title:"Two", content: "I am the second"},
     {title:"Three", content:"I am the third"} ];

    const names = [ {name: "Jeff"}, {name: "Jake"},
     {name: "Jimmy"}, {name: "Jared"}, {name: "Jane"} ];

    ReactDOM.render(
        <div>
            <Clock/>
            <Tabs tabList={tabs}/>
            <AutoComplete names={names}/>
        </div>,
        root);

});