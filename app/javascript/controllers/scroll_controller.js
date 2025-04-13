import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["scrollButton"];

  connect() {
    this.scrollHandler = this.isScrollButtonVisible.bind(this);
    this.scrollToBottomHandler = this.scrollToBottom.bind(this);

    document.addEventListener("turbo:load", this.scrollToBottomHandler);
    window.addEventListener("scroll", this.scrollHandler);

    this.isScrollButtonVisible();
    this.adjustScrollAfterKeyboardClose();
  }

  disconnect() {
    document.removeEventListener("turbo:load", this.scrollToBottomHandler);
    window.removeEventListener("scroll", this.scrollHandler);
  }

  scrollToEnd() {
    window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
  }

  scrollToBottom() {
    window.scrollTo(0, document.body.scrollHeight);
  }

  isAtBottom() {
    return (window.innerHeight + window.scrollY >= document.body.scrollHeight - 200);
  }

  isScrollButtonVisible() {
    this.scrollButtonTarget.hidden = this.isAtBottom();
  }

  adjustScrollAfterKeyboardClose() {
    const textarea = this.element.querySelector("textarea");
    if (!textarea) return;

    textarea.addEventListener("focusout", () => {
      setTimeout(() => { window.scrollBy(0, 1); window.scrollBy(0, -1); }, 100);
    });
  }
}
