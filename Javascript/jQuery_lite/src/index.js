const DOMNodeCollection = require("./dom_node_collection.js")

window.$l = function(el){
    console.log(el);
    if (typeof el == "string"){
        matchingNodes = document.querySelectorAll(el);
        return (new DOMNodeCollection(matchingNodes))
    }

    else if(el instanceof HTMLElement){
        return (new DOMNodeCollection( [el] ));
    }

    else if(typeof el === "function"){
        document.addEventListener("DOMContentLoaded", el);

    }

}


$l.extend = function(objA,...objs){
    const returnObj = objA;
    objs.forEach((obj) => {
        Object.keys(obj).forEach( (key) => {
            returnObj[key] = obj[key];
        } );


    });
    return returnObj;
}

$l.ajax = function(optionsObj){
    defaultRequest = {
        success: (r) => console.log(r),
        error: (r) => console.log(r.status),
        url: window.location.href,
        method: 'GET',
        data: {},
        contentType: 'text/html'

    }

    const sendingReq = $l.extend(defaultRequest, optionsObj);

    const xhr = new XMLHttpRequest();

    xhr.open(sendingReq[method], sendingReq[url]);

    xhr.onload = function () {
        console.log(xhr.status) // for status info
        console.log(xhr.responseType) //the type of data that was returned
        console.log(xhr.response) //the actual response. For JSON api calls, this will be a JSON string
    }

    xhr.send(sendingReq);


}