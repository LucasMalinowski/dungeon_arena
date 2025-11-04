import { Controller } from "@hotwired/stimulus";

export default class ToggleableController extends Controller {
  static targets = [];

  connect() {
    this.boundHandleEscape = this.handleEscapeKey.bind(this);
    document.addEventListener("keydown", this.boundHandleEscape);
  }

  disconnect() {
    document.removeEventListener("keydown", this.boundHandleEscape);
  }

  toggleTargets(targets = []) {
    targets.forEach((target) => {
      target.classList.toggle("hidden");
    });
  }

  handleEscapeKey(event) {
    if (event.key === "Escape") {
      this.close();
    }
  }

  close() {
    this.element.classList.add("hidden");
  }

  outsideClick(event) {
    if (event.target === this.element) {
      this.close();
    }
  }
}
