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

/***/ "./src/compose.js":
/*!************************!*\
  !*** ./src/compose.js ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const MessageStore = __webpack_require__(/*! ./message_store.js */ \"./src/message_store.js\");\n\n\nCompose = {\n    render: function(){\n        let newMsg = document.createElement(\"div\");\n        newMsg.className = \"new-message\";\n        newMsg.innerHTML = this.renderForm();\n\n        newMsg.addEventListener(\"change\", (e) => {\n            const changed = e.target;\n            const changedName = changed.name;\n            const changedVal = changed.value;\n            MessageStore.updateDraftField(changedName, changedVal);\n        });\n\n        newMsg.addEventListener(\"submit\", (e) => {\n            e.preventDefault();\n            MessageStore.sendDraft();\n            window.location.hash = \"#inbox\";\n        });\n\n        return newMsg;\n    },\n\n    renderForm: function(){\n        let message = MessageStore.getMessageDraft();\n\n\n        let contentString = '<p class=\"new-message-header\">New Message</p>';\n        contentString += `<form class=\"compose-form\">`;\n        contentString += `<input placeholder=\"Recipient\" name=\"to\", type=\"text\" value=${message.to || \"\"}>`\n        contentString += `<input placeholder=\"Subject\" name=\"subject\", type=\"text\" value=${message.subject || \"\"}>`;\n        contentString += `<textarea name=\"body\" rows=\"20\">${message.body || \"\"}</textarea>`;\n        contentString += `<button type=\"submit\" class=\"btn btn-primary submit-message\">send</button>`;\n        contentString += `</form>`;\n        return contentString;\n    }\n\n}\nmodule.exports = Compose;\n\n//# sourceURL=webpack:///./src/compose.js?");

/***/ }),

/***/ "./src/inbox.js":
/*!**********************!*\
  !*** ./src/inbox.js ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const MessageStore = __webpack_require__(/*! ./message_store.js */ \"./src/message_store.js\")\n\n\nconst Inbox = {\n    render: function(){\n        const messageList = document.createElement('ul');\n        messageList.className = \"messages\";\n        const messageData = MessageStore.getInboxMessages();\n\n        messageData.forEach( msg => {\n            const renderedMessage = this.renderMessage(msg);\n            messageList.appendChild(renderedMessage);\n        } );\n\n        return messageList;\n    },\n\n    renderMessage: function(msg){\n        const formattedMsg = document.createElement('li');\n        formattedMsg.className = \"message\";\n        let htmlToAdd = `<span class='from'>${msg.from}</span>`;\n        htmlToAdd += `<span class='subject'>${msg.subject}</span>`;\n        htmlToAdd += `   <span class='body'>${msg.body}</span>`;\n        formattedMsg.innerHTML = htmlToAdd;\n        return formattedMsg;\n\n    }\n\n\n\n\n}\n\nmodule.exports = Inbox;\n\n//# sourceURL=webpack:///./src/inbox.js?");

/***/ }),

/***/ "./src/index.js":
/*!**********************!*\
  !*** ./src/index.js ***!
  \**********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const Router = __webpack_require__(/*! ./router.js */ \"./src/router.js\");\nconst Inbox = __webpack_require__(/*! ./inbox.js */ \"./src/inbox.js\");\nconst Sent = __webpack_require__(/*! ./sent.js */ \"./src/sent.js\")\nconst Compose = __webpack_require__(/*! ./compose.js */ \"./src/compose.js\")\n\n\nconst routes = {\n    inbox: Inbox,\n    sent: Sent,\n    compose: Compose\n}\n\n\ndocument.addEventListener(\"DOMContentLoaded\", ()=>{\n    const navItems = document.querySelectorAll(\".sidebar-nav li\");\n    const contentNode = document.querySelector(\".content\");\n\n    const router = new Router(contentNode, routes);\n    router.start();\n    window.location.hash = '#inbox'\n\n    navItems.forEach( (li) => {\n        li.addEventListener(\"click\", (e) => {\n            const newLoc = li.innerText.toLowerCase();\n            window.location.hash = newLoc;\n        });\n    });\n\n    \n\n})\n\n//# sourceURL=webpack:///./src/index.js?");

/***/ }),

/***/ "./src/message_store.js":
/*!******************************!*\
  !*** ./src/message_store.js ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("\nlet messages = {\n    sent: [\n      {\n        to: \"friend@mail.com\",\n        subject: \"Check this out\",\n        body: \"It's so cool\"\n      },\n      { to: \"person@mail.com\", subject: \"zzz\", body: \"so booring\" }\n    ],\n    inbox: [\n      {\n        from: \"grandma@mail.com\",\n        subject: \"Fwd: Fwd: Fwd: Check this out\",\n        body:\n          \"Stay at home mom discovers cure for leg cramps. Doctors hate her\"\n      },\n      {\n        from: \"person@mail.com\",\n        subject: \"Questionnaire\",\n        body: \"Take this free quiz win $1000 dollars\"\n      }\n    ]\n    \n};\n\n\n\n\nconst MessageStore = {\n    getInboxMessages: () => {\n        return messages.inbox;\n    },\n    getSentMessages: () => {\n        return messages.sent;\n    },\n\n    getMessageDraft: () => {\n        return messageDraft;\n    },\n\n    Message: function(from, to, subject, body){\n        this.from = from;\n        this.to = to;\n        this.subject = subject;\n        this.body = body;\n    },\n\n    updateDraftField: function(key, val = null){\n        if (!val){\n            return messageDraft[key];\n        }else{\n            messageDraft[key] = val;\n        }\n\n    },\n\n    sendDraft: function(){\n        messages.sent.push(messageDraft);\n        messageDraft = new this.Message();\n\n    }\n\n};\n\nlet messageDraft = new MessageStore.Message();\n\n\nmodule.exports = MessageStore;\n\n//# sourceURL=webpack:///./src/message_store.js?");

/***/ }),

/***/ "./src/router.js":
/*!***********************!*\
  !*** ./src/router.js ***!
  \***********************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("class Router{\n    constructor(node, routes){\n        this.node = node;\n        this.routes = routes;\n    }\n\n    start(){\n        this.render();\n        window.addEventListener(\"hashchange\", (e) => {\n            this.render()\n        });\n\n    }\n\n    render(){\n\n        const component = this.activeRoute();\n        if (!component){\n            this.node.innerHTML = \"\";\n        }else{\n            this.node.innerHTML = \"\";\n            const renderedComponent = component.render();\n            this.node.appendChild(renderedComponent);\n        }\n\n    }\n\n\n    activeRoute(){ \n        let hashFrag = window.location.hash\n        hashFrag = hashFrag.slice(1,hashFrag.length);\n        return this.routes[hashFrag];\n\n    }\n\n    \n}\n\nmodule.exports = Router;\n\n//# sourceURL=webpack:///./src/router.js?");

/***/ }),

/***/ "./src/sent.js":
/*!*********************!*\
  !*** ./src/sent.js ***!
  \*********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

eval("const MessageStore = __webpack_require__(/*! ./message_store.js */ \"./src/message_store.js\")\n\nconst Sent = {\n    render: function(){\n        const messageList = document.createElement('ul');\n        messageList.className = \"messages\";\n        const messageData = MessageStore.getSentMessages();\n\n        messageData.forEach( msg => {\n            const renderedMessage = this.renderMessage(msg);\n            messageList.appendChild(renderedMessage);\n        } );\n\n        return messageList;\n    },\n\n    renderMessage: function(msg){\n        const formattedMsg = document.createElement('li');\n        formattedMsg.className = \"message\";\n        let htmlToAdd = `<span class='to'>${msg.to}</span>`;\n        htmlToAdd += `<span class='subject'>${msg.subject}</span>`;\n        htmlToAdd += `   <span class='body'>${msg.body}</span>`;\n        formattedMsg.innerHTML = htmlToAdd;\n        return formattedMsg;\n\n    }\n\n\n\n\n}\n\nmodule.exports = Sent;\n\n\n//# sourceURL=webpack:///./src/sent.js?");

/***/ })

/******/ });