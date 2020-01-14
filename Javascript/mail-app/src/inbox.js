const MessageStore = require("./message_store.js")


const Inbox = {
    render: function(){
        const messageList = document.createElement('ul');
        messageList.className = "messages";
        const messageData = MessageStore.getInboxMessages();

        messageData.forEach( msg => {
            const renderedMessage = this.renderMessage(msg);
            messageList.appendChild(renderedMessage);
        } );

        return messageList;
    },

    renderMessage: function(msg){
        const formattedMsg = document.createElement('li');
        formattedMsg.className = "message";
        let htmlToAdd = `<span class='from'>${msg.from}</span>`;
        htmlToAdd += `<span class='subject'>${msg.subject}</span>`;
        htmlToAdd += `   <span class='body'>${msg.body}</span>`;
        formattedMsg.innerHTML = htmlToAdd;
        return formattedMsg;

    }




}

module.exports = Inbox;