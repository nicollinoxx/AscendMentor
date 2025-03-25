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
        messageElement.classList.remove('flex', 'justify-end');
        messageElement.querySelector('a[href*="edit"]')?.remove();
        toggleMessageBackground(messageElement);
      }
    }
  });
}

function toggleMessageBackground(messageElement) {
  const message = messageElement.querySelector('#message');
  message.classList.remove('bg-slate-200', 'dark:bg-slate-800');
  message.classList.add('bg-indigo-100', 'dark:bg-slate-600');
}

document.addEventListener("turbo:load", chatChannel);
