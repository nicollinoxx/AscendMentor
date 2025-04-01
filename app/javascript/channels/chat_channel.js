import consumer from "channels/consumer"

// Dados do usuário e chat
var chatId = document.getElementById("messages")?.dataset.chatId;
var currentUser = document.querySelector('[data-current-user]')?.dataset.currentUser;

function chatChannel() {
  consumer.subscriptions.create({ channel: "ChatChannel", id: chatId }, {
    async received(data) {
      await new Promise(resolve => setTimeout(resolve, 20));
      positionMessage(data);
      scrollToBottom();
    }
  });
}

// Ajusta posição e estilo da mensagem recebida
function positionMessage(data) {
  const messageElement = document.getElementById(`message_${data.message_id}`);
  if (messageElement && data.sender != parseInt(currentUser)) {
    messageElement.classList.remove('flex', 'justify-end');
    messageElement.querySelector('a[href*="edit"]')?.remove();
    messageBackground(messageElement);
  }
}

// Altera cores do fundo da mensagem
function messageBackground(messageElement) {
  const message = messageElement.querySelector('#message');
  message.classList.remove('bg-slate-200', 'dark:bg-slate-800');
  message.classList.add('bg-indigo-100', 'dark:bg-slate-600');
}

// Verifica se está próximo ao fim da página
function isAtBottom() {
  return document.body.scrollHeight - (window.innerHeight + window.scrollY) <= 2000;
}
// Rola suavemente até o fim quando próximo
function scrollToBottom() {
 isAtBottom() ? window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" }) : null;
}

document.addEventListener("turbo:load", () => {chatChannel();});
