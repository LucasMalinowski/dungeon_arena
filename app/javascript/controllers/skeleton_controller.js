import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["placeholder", "content"];

  connect() {
    requestAnimationFrame(() => this.showContent());
  }

  showContent() {
    if (this.hasPlaceholderTarget) {
      this.placeholderTarget.classList.add("hidden");
    }

    if (this.hasContentTarget) {
      this.contentTarget.classList.remove("hidden");
    }
  }
}
