class Router{
    constructor(node, routes){
        this.node = node;
        this.routes = routes;
    }

    start(){
        this.render();
        window.addEventListener("hashchange", (e) => {
            this.render()
        });

    }

    render(){

        const component = this.activeRoute();
        if (!component){
            this.node.innerHTML = "";
        }else{
            this.node.innerHTML = "";
            const renderedComponent = component.render();
            this.node.appendChild(renderedComponent);
        }

    }


    activeRoute(){ 
        let hashFrag = window.location.hash
        hashFrag = hashFrag.slice(1,hashFrag.length);
        return this.routes[hashFrag];

    }

    
}

module.exports = Router;