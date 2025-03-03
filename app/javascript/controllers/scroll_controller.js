import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["scrollButton"];

  connect() {
    this.observeMessages();
    this.scrollToEnd();
    this.isScrollButtonVisible();
    window.addEventListener("scroll", this.isScrollButtonVisible.bind(this));
  }

  disconnect() {
    window.removeEventListener("scroll", this.isScrollButtonVisible.bind(this));
  }

  scrollToEnd() {
    window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
  }

  isAtBottom() {
    return window.innerHeight + window.scrollY >= document.body.scrollHeight - 200;
  }

  isScrollButtonVisible() {
    this.scrollButtonTarget.hidden = this.isAtBottom();
  }

  isLastMessageVisible() {
    const messages = this.element.querySelectorAll("#messages > *");
    if (messages.length === 0) return false;

    const lastMessage = messages[messages.length - 1];
    const rect = lastMessage.getBoundingClientRect();

    return rect.top < window.innerHeight && rect.bottom > 0;
  }

  observeMessages() {
    const observer = new MutationObserver(() => {
      if (this.isLastMessageVisible()) {
        this.scrollToEnd();
      }
    });

    observer.observe(this.element.querySelector("#messages"), { childList: true, subtree: true });
  }
}
