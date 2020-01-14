/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/index.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/dom_node_collection.js":
/*!************************************!*\
  !*** ./src/dom_node_collection.js ***!
  \************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\nclass DOMNodeCollection{\n    constructor(nodeArray){\n        this.nodes = nodeArray;\n    }\n\n\n    html(innerHTMLString = null){\n        if(innerHTMLString){\n            this.nodes.forEach( (node) => node.innerHTML = innerHTMLString )\n        } else{\n            const firstNode = this.nodes[0];\n            return firstNode.innerHTML;\n        }\n    }\n\n    //remove all innerHTML/content of nodes in array\n    empty(){\n        this.nodes.forEach( (node) => node.innerHTML = \"\" )\n    }\n\n\n    append(content){\n\n        if (typeof content == \"string\"){\n            this.nodes.forEach( (node) => {\n                node.innerHTML = node.innerHTML + content;\n            });\n\n\n        }else if(content instanceof DOMNodeCollection){\n            this.nodes.forEach( (node) => {\n                content.nodes.forEach( (HTMLele) => {\n                    node.innerHTML = node.innerHTML + HTMLele.outerHTML;\n                });\n            });\n\n        }else if (content instanceof HTMLElement){\n\n            this.nodes.forEach( (node) => {\n                node.innerHTML = node.innerHTML + content.outerHTML;\n            });\n        }\n    }\n\n    //ignoring improper usage for now...    \n    attr(assignedAttributes = null, attrValue){\n        if (assignedAttributes){\n            this.nodes.forEach((node) => {\n                node.setAttribute(assignedAttributes, attrValue);\n\n            });\n\n        }else{\n            return this.nodes[0].attributes;\n        }\n\n    }\n\n\n    addClass(className){\n        this.nodes.forEach( node => { node.classList.add(className) } );\n\n    }\n\n    removeClass(className){\n        this.nodes.forEach( node => node.classList.remove(className) );\n\n    }\n\n    /*  TRAVERSAL METHODS  */\n\n    children(){\n        const childarr = [];\n\n        this.nodes.forEach( (node) => {\n            console.log(node);\n            childarr.concat(Array.from(node.children));\n        });\n\n        return new DOMNodeCollection(childarr);\n    }\n\n    parent(){\n        const parents = [];\n        this.nodes.forEach( (node) => {\n            parent = node.parentNode;\n            if (!this.parent.visited){\n                parents.push(parent);\n                parent.visited = true;\n            }\n        } );\n\n        parents.forEach( (parent) => { parent.visited = false } );\n\n        return new DOMNodeCollection(parents);\n\n    }\n\n    find(selector){\n        const matchingDescendants = [];\n        this.nodes.forEach( (node) => {\n            const found = node.querySelectorAll(selector);\n            matchingDescendants.concat(Array.from(found));\n\n        } );\n        return new DOMNodeCollection(matchingDescendants);\n    }\n\n    remove(){\n        this.nodes.forEach( (node) => {\n            node.remove();\n        } );\n\n    }\n\n    on(action, actionHandler){\n        this.nodes.forEach( node => {\n            node.addEventListener(action, actionHandler)\n            //store the function...\n            node.eventFunction = actionHandler;\n        } );\n\n    }\n\n    off(action){\n        this.nodes.forEach(  node => {\n            node.removeEventListener(action, node.eventFunction);\n        });\n\n    }\n\n}\n\n\n\nmodule.exports = DOMNodeCollection\n\n//# sourceURL=webpack:///./src/dom_node_collection.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const DOMNodeCollection = __webpack_require__(/*! ./dom_node_collection.js */ \"./src/dom_node_collection.js\")\n\nwindow.$l = function(el){\n    console.log(el);\n    if (typeof el == \"string\"){\n        matchingNodes = document.querySelectorAll(el);\n        return (new DOMNodeCollection(matchingNodes))\n    }\n\n    else if(el instanceof HTMLElement){\n        return (new DOMNodeCollection( [el] ));\n    }\n\n    else if(typeof el === \"function\"){\n        document.addEventListener(\"DOMContentLoaded\", el);\n\n    }\n\n}\n\n\n$l.extend = function(objA,...objs){\n    const returnObj = objA;\n    objs.forEach((obj) => {\n        Object.keys(obj).forEach( (key) => {\n            returnObj[key] = obj[key];\n        } );\n\n\n    });\n    return returnObj;\n}\n\n$l.ajax = function(optionsObj){\n    defaultRequest = {\n        success: (r) => console.log(r),\n        error: (r) => console.log(r.status),\n        url: window.location.href,\n        method: 'GET',\n        data: {},\n        contentType: 'text/html'\n\n    }\n\n    const sendingReq = $l.extend(defaultRequest, optionsObj);\n\n    const xhr = new XMLHttpRequest();\n\n    xhr.open(sendingReq[method], sendingReq[url]);\n\n    xhr.onload = function () {\n        console.log(xhr.status) // for status info\n        console.log(xhr.responseType) //the type of data that was returned\n        console.log(xhr.response) //the actual response. For JSON api calls, this will be a JSON string\n    }\n\n    xhr.send(sendingReq);\n\n\n}\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ })

/******/ });