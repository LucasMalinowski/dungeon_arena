import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    document.addEventListener("keydown", this.handleEscapeKey.bind(this));
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleEscapeKey.bind(this));
  }

  close() {
    this.element.remove()
  }

  handleEscapeKey(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }

  outsideClick(event) {
    if (event.target === this.element) {
      this.close();
    }
  }
}