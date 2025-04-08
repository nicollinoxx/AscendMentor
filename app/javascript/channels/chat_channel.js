import consumer from "channels/consumer"

//main
function chatChannel() {
  const chatId = document.getElementById("messages")?.dataset.chatId;
  const currentUser = document.querySelector('[data-current-user]')?.dataset.currentUser;

  consumer.subscriptions.create({ channel: "ChatChannel", id: chatId }, {
    received(data) {
      setTimeout(() => { positionMessage(data, currentUser); scrollToBottom(); }, 20);
    }
  });
}

//position messages left or right
function positionMessage(data, currentUser) {
  const messageElement = document.getElementById(`message_${data.message_id}`);
  if (!messageElement || data.sender === currentUser) return;

  messageElement.classList.remove("flex", "justify-end");

  const message = messageElement.querySelector("#message");
  message?.classList.remove("bg-slate-200", "dark:bg-slate-800");
  message?.classList.add("bg-indigo-100", "dark:bg-slate-600");

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
