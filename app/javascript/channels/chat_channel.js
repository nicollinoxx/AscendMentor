import consumer from "channels/consumer"

//main
function chatChannel() {
  const chatId = document.getElementById("messages")?.dataset.chatId;
  const userId = parseInt(document.querySelector('[data-current-user]')?.dataset.currentUser);

  consumer.subscriptions.create({ channel: "ChatChannel", id: chatId }, {
    received(data) {
      setTimeout(() => { positionMessage(data, userId); scrollToBottom(); }, 20);
    }
  });
}

//position messages left or right
function positionMessage(data, userId) {
  const messageElement = document.getElementById(`message_${data.message_id}`);
  if (!messageElement || data.sender == userId) return;

  messageElement.classList.remove("flex", "justify-end");
  messageElement.querySelector("#message")?.classList.replace("bg-slate-200", "bg-indigo-100");
  messageElement.querySelector('a[href*="edit"]')?.remove();
}

//follow messages
function isAtBottom() {
  return window.innerHeight + window.scrollY >= document.body.scrollHeight - 1000;
}

function scrollToBottom() {
   if (isAtBottom()) {
      window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
   }
}

document.addEventListener("turbo:load", chatChannel);
