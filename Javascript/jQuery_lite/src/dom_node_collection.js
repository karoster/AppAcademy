
class DOMNodeCollection{
    constructor(nodeArray){
        this.nodes = nodeArray;
    }


    html(innerHTMLString = null){
        if(innerHTMLString){
            this.nodes.forEach( (node) => node.innerHTML = innerHTMLString )
        } else{
            const firstNode = this.nodes[0];
            return firstNode.innerHTML;
        }
    }

    //remove all innerHTML/content of nodes in array
    empty(){
        this.nodes.forEach( (node) => node.innerHTML = "" )
    }


    append(content){

        if (typeof content == "string"){
            this.nodes.forEach( (node) => {
                node.innerHTML = node.innerHTML + content;
            });


        }else if(content instanceof DOMNodeCollection){
            this.nodes.forEach( (node) => {
                content.nodes.forEach( (HTMLele) => {
                    node.innerHTML = node.innerHTML + HTMLele.outerHTML;
                });
            });

        }else if (content instanceof HTMLElement){

            this.nodes.forEach( (node) => {
                node.innerHTML = node.innerHTML + content.outerHTML;
            });
        }
    }

    //ignoring improper usage for now...    
    attr(assignedAttributes = null, attrValue){
        if (assignedAttributes){
            this.nodes.forEach((node) => {
                node.setAttribute(assignedAttributes, attrValue);

            });

        }else{
            return this.nodes[0].attributes;
        }

    }


    addClass(className){
        this.nodes.forEach( node => { node.classList.add(className) } );

    }

    removeClass(className){
        this.nodes.forEach( node => node.classList.remove(className) );

    }

    /*  TRAVERSAL METHODS  */

    children(){
        const childarr = [];

        this.nodes.forEach( (node) => {
            console.log(node);
            childarr.concat(Array.from(node.children));
        });

        return new DOMNodeCollection(childarr);
    }

    parent(){
        const parents = [];
        this.nodes.forEach( (node) => {
            parent = node.parentNode;
            if (!this.parent.visited){
                parents.push(parent);
                parent.visited = true;
            }
        } );

        parents.forEach( (parent) => { parent.visited = false } );

        return new DOMNodeCollection(parents);

    }

    find(selector){
        const matchingDescendants = [];
        this.nodes.forEach( (node) => {
            const found = node.querySelectorAll(selector);
            matchingDescendants.concat(Array.from(found));

        } );
        return new DOMNodeCollection(matchingDescendants);
    }

    remove(){
        this.nodes.forEach( (node) => {
            node.remove();
        } );

    }

    on(action, actionHandler){
        this.nodes.forEach( node => {
            node.addEventListener(action, actionHandler)
            //store the function...
            node.eventFunction = actionHandler;
        } );

    }

    off(action){
        this.nodes.forEach(  node => {
            node.removeEventListener(action, node.eventFunction);
        });

    }

}



module.exports = DOMNodeCollection