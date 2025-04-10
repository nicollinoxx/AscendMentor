import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["scrollButton"];

  connect() {
    this.scrollHandler = this.isScrollButtonVisible.bind(this);
    this.scrollToBottomHandler = this.scrollToBottom.bind(this);

    window.addEventListener("turbo:load", this.scrollToBottomHandler);
    window.addEventListener("scroll", this.scrollHandler);

    this.isScrollButtonVisible();
  }

  disconnect() {
    window.removeEventListener("scroll", this.scrollHandler);
    window.removeEventListener("turbo:load", this.scrollToBottomHandler);
  }

  scrollToEnd() {
    window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
  }

  scrollToBottom() {
    window.scrollTo(0, document.body.scrollHeight);
  }

  isAtBottom() {
    return window.innerHeight + window.scrollY >= document.body.scrollHeight - 200;
  }

  isScrollButtonVisible() {
    this.scrollButtonTarget.hidden = this.isAtBottom();
  }
}
