import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["radio"];

  connect() {
    this.selectedRadio = null; // Keeps track of the currently selected radio button
  }

  toggleRadio(event) {
    const clickedRadio = event.currentTarget;

    if (this.selectedRadio === clickedRadio) {
      clickedRadio.checked = false;
      this.selectedRadio = null;
    } else {
      this.radioTargets.forEach((radio) => (radio.checked = false));
      clickedRadio.checked = true;
      this.selectedRadio = clickedRadio;
    }

    clickedRadio.dispatchEvent(new Event("change", { bubbles: true }));
  }
}
