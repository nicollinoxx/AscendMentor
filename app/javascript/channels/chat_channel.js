import consumer from "channels/consumer"

function chatChannel() {
  const chatId = document.getElementById("messages")?.dataset.chatId;
  const currentUser = document.querySelector('[data-current-user]')?.dataset.currentUser;

  consumer.subscriptions.create({ channel: "ChatChannel", id: chatId }, {
    received(data) {
      setTimeout(() => this.positionMessage(data), 15);
    },

    positionMessage(data) {
      const messageElement = document.getElementById(`message_${data.message_id}`);
      if (messageElement && data.sender != parseInt(currentUser)) {
        messageElement.classList.remove('text-right')
        messageElement.querySelector('a[href*="edit"]')?.remove()
      }
    }
  });
}

document.addEventListener("turbo:load", chatChannel);
