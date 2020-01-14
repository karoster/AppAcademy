const MessageStore = require("./message_store.js");


Compose = {
    render: function(){
        let newMsg = document.createElement("div");
        newMsg.className = "new-message";
        newMsg.innerHTML = this.renderForm();

        newMsg.addEventListener("change", (e) => {
            const changed = e.target;
            const changedName = changed.name;
            const changedVal = changed.value;
            MessageStore.updateDraftField(changedName, changedVal);
        });

        newMsg.addEventListener("submit", (e) => {
            e.preventDefault();
            MessageStore.sendDraft();
            window.location.hash = "#inbox";
        });

        return newMsg;
    },

    renderForm: function(){
        let message = MessageStore.getMessageDraft();


        let contentString = '<p class="new-message-header">New Message</p>';
        contentString += `<form class="compose-form">`;
        contentString += `<input placeholder="Recipient" name="to", type="text" value=${message.to || ""}>`
        contentString += `<input placeholder="Subject" name="subject", type="text" value=${message.subject || ""}>`;
        contentString += `<textarea name="body" rows="20">${message.body || ""}</textarea>`;
        contentString += `<button type="submit" class="btn btn-primary submit-message">send</button>`;
        contentString += `</form>`;
        return contentString;
    }

}
module.exports = Compose;