const Router = require('./router.js');
const Inbox = require('./inbox.js');
const Sent = require('./sent.js')
const Compose = require('./compose.js')


const routes = {
    inbox: Inbox,
    sent: Sent,
    compose: Compose
}


document.addEventListener("DOMContentLoaded", ()=>{
    const navItems = document.querySelectorAll(".sidebar-nav li");
    const contentNode = document.querySelector(".content");

    const router = new Router(contentNode, routes);
    router.start();
    window.location.hash = '#inbox'

    navItems.forEach( (li) => {
        li.addEventListener("click", (e) => {
            const newLoc = li.innerText.toLowerCase();
            window.location.hash = newLoc;
        });
    });

    

})