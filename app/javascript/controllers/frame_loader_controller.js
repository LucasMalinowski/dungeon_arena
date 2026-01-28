import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["placeholder"];

  connect() {
    this.showHandler = this.showPlaceholder.bind(this);
    this.hideHandler = this.hidePlaceholder.bind(this);
    this.element.addEventListener("turbo:before-fetch-request", this.showHandler);
    this.element.addEventListener("turbo:frame-load", this.hideHandler);
    this.hidePlaceholder();
  }

  disconnect() {
    this.element.removeEventListener("turbo:before-fetch-request", this.showHandler);
    this.element.removeEventListener("turbo:frame-load", this.hideHandler);
  }

  showPlaceholder() {
    if (this.hasPlaceholderTarget) {
      this.placeholderTarget.classList.remove("hidden");
    }
  }

  hidePlaceholder() {
    if (this.hasPlaceholderTarget) {
      this.placeholderTarget.classList.add("hidden");
    }
  }
}
