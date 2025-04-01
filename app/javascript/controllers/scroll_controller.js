import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["scrollButton"];

  connect() {
    this.isScrollButtonVisible();
    window.addEventListener("turbo:load", () => {window.scrollTo(0, document.body.scrollHeight);});
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
}
