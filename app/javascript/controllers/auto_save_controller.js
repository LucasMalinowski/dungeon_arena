import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  connect() {
    this.cancelHandler = this.cancel.bind(this);
    this.element.addEventListener("submit", this.cancelHandler);
  }

  disconnect() {
    this.element.removeEventListener("submit", this.cancelHandler);
    this.cancel();
  }

  save(event) {
    if (!this.element) return;

    const form = this.element;
    window.clearTimeout(this.timeout);

    const delay = this._delayFor(event.target);
    this.timeout = window.setTimeout(() => {
      if (!form.reportValidity()) return;
      form.requestSubmit();
    }, delay);
  }

  _delayFor(target) {
    if (!target) return 0;
    if (target.type === "text" || target.type === "textarea") {
      return 400;
    }
    return 0;
  }

  cancel() {
    window.clearTimeout(this.timeout);
    this.timeout = null;
  }
}
